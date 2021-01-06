//
//  MyBarCodeScanner.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 12/27/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//

import Foundation
import UIKit
import Vision
import AVFoundation
import SafariServices

class MyBarcodeScannerVision: UIViewController {
  // MARK: - Private Variables
  var captureSession = AVCaptureSession()

  // TODO: Make VNDetectBarcodesRequest variable
    lazy var detectBarcodeRequest = VNDetectBarcodesRequest { request, error in
      guard error == nil else {
        self.showAlert(
          withTitle: "Barcode error",
          message: error?.localizedDescription ?? "error")
        return
      }
      self.processClassification(request)
    }

  // MARK: - Override Functions
  override func viewDidLoad() {
    super.viewDidLoad()
    checkPermissions()
    setupCameraLiveView()
  }
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    // TODO: Stop Session
    captureSession.stopRunning()
  }
}


extension MyBarcodeScannerVision {
  // MARK: - Camera
  private func checkPermissions() {
    switch AVCaptureDevice.authorizationStatus(for: .video) {
    // 1
    case .notDetermined:
      AVCaptureDevice.requestAccess(for: .video) { [self] granted in
        if !granted {
            self.showPermissionsAlert()
        }
      }

    // 2
    case .denied, .restricted:
      showPermissionsAlert()

    // 3
    default:
      return
    }
  }

  private func setupCameraLiveView() {
    // TODO: Setup captureSession
    captureSession.sessionPreset = .hd1280x720

    // TODO: Add input
    // 1
    let videoDevice = AVCaptureDevice
      .default(.builtInWideAngleCamera, for: .video, position: .back)

    // 2
    guard
      let device = videoDevice,
      let videoDeviceInput = try? AVCaptureDeviceInput(device: device),
      captureSession.canAddInput(videoDeviceInput)
      else {
        // 3
        showAlert(
          withTitle: "Cannot Find Camera",
          message: "There seems to be a problem with the camera on your device.")
        return
      }

    // 4
    captureSession.addInput(videoDeviceInput)

    // TODO: Add output
    let captureOutput = AVCaptureVideoDataOutput()
    // TODO: Set video sample rate
    captureOutput.videoSettings =
      [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32BGRA)]
    captureOutput.setSampleBufferDelegate(
      self,
      queue: DispatchQueue.global(qos: DispatchQoS.QoSClass.default))
    captureSession.addOutput(captureOutput)

    configurePreviewLayer()

    // TODO: Run session
    captureSession.startRunning()
  }

  // MARK: - Vision
  func processClassification(_ request: VNRequest) {
    // TODO: Main logic
    // 1
    guard let barcodes = request.results else { return }
    DispatchQueue.main.async { [self] in
        if self.captureSession.isRunning {
            self.view.layer.sublayers?.removeSubrange(1...)

        // 2
        for barcode in barcodes {
          guard
            // TODO: Check for QR Code symbology and confidence score
            let potentialQRCode = barcode as? VNBarcodeObservation
            else { return }

          // 3
            self.showAlert(
            withTitle: potentialQRCode.symbology.rawValue,
            // TODO: Check the confidence score
            message: potentialQRCode.payloadStringValue ?? "" )
        }
      }
    }
  }

  // MARK: - Handler
  func observationHandler(payload: String?) {
    // TODO: Open it in Safari
    
  }
}


// MARK: - AVCaptureDelegation
extension MyBarcodeScannerVision: AVCaptureVideoDataOutputSampleBufferDelegate {
  func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
    // TODO: Live Vision
    // 1
    guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
      return
    }

    // 2
    let imageRequestHandler = VNImageRequestHandler(
      cvPixelBuffer: pixelBuffer,
      orientation: .right)

    // 3
    do {
      try imageRequestHandler.perform([detectBarcodeRequest])
    } catch {
      print(error)
    }
  }
}


// MARK: - Helper
extension MyBarcodeScannerVision {
  private func configurePreviewLayer() {
    let cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    cameraPreviewLayer.videoGravity = .resizeAspectFill
    cameraPreviewLayer.connection?.videoOrientation = .portrait
    cameraPreviewLayer.frame = view.frame
    view.layer.insertSublayer(cameraPreviewLayer, at: 0)
  }

  private func showAlert(withTitle title: String, message: String) {
    DispatchQueue.main.async {
      let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
      alertController.addAction(UIAlertAction(title: "OK", style: .default))
      self.present(alertController, animated: true)
    }
  }

  private func showPermissionsAlert() {
    showAlert(
      withTitle: "Camera Permissions",
      message: "Please open Settings and grant permission for this app to use your camera.")
  }
}


// MARK: - SafariViewControllerDelegate
extension MyBarcodeScannerVision: SFSafariViewControllerDelegate {
  func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
    captureSession.startRunning()
  }
}
