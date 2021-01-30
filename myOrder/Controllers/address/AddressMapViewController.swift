//
//  AddressMapViewController.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 1/11/21.
//  Copyright © 2021 Geanni Barbulescu. All rights reserved.
//

import UIKit
import GoogleMaps

class AddressMapViewController: UIViewController, GMSMapViewDelegate {

    @IBOutlet weak var viewMap: UIView!
    @IBOutlet weak var labelNext: UILabel!
    var  destinationMarker:GMSMarker? = nil
    var mapView :GMSMapView? = nil
    @IBOutlet weak var labelTop: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labelNext.generateNext(title: "SALVEAZA ADRESA", isEnabled: true)
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.viewMap.addSubview(mapView!)
        mapView?.delegate = self

        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        
//        let destinationMarker = GMSMarker(position: self.destinationLocation.coordinate)
//
//        let image = UIImage(named:"sourcemarker")
//        destinationMarker.icon = image
//        destinationMarker.draggable = true
//        destinationMarker.map = self.viewMap
//        //viewMap.selectedMarker = destinationMarker
//        destinationMarker.title = "hi"
//        destinationMarker.userData = "changedestination"
        // Do any additional setup after loading the view.
    }
    
    func updateLocationoordinates(coordinates:CLLocationCoordinate2D) {
           if destinationMarker == nil
           {
               destinationMarker = GMSMarker()
               destinationMarker?.position = coordinates
               let image = UIImage(named:"destinationmarker")
               destinationMarker?.icon = image
               destinationMarker?.map = mapView
//            destinationMarker.appearAnimation = .
           }
           else
           {
               CATransaction.begin()
               CATransaction.setAnimationDuration(1.0)
               destinationMarker?.position =  coordinates
               CATransaction.commit()
           }
        getAddressFromLatLon(Latitude: coordinates.latitude, Longitude: coordinates.longitude)
       }
    
    func getAddressFromLatLon(Latitude: Double, Longitude: Double) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()


        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = Latitude
        center.longitude = Longitude

        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)


        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                    return
                }
                let pm = placemarks! as [CLPlacemark]

                if pm.count > 0 {
                    let pm = placemarks![0]
                    print(pm.country)
                    print(pm.locality)
                    print(pm.subLocality)
                    print(pm.thoroughfare)
                    print(pm.postalCode)
                    print(pm.subThoroughfare)
                    var addressString : String = ""
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }


                    print(addressString)
                    self.labelTop.generateAttributedString(fonts: ["Roboto-Bold"],
                        colors: [.selgrosTitle],
                        sizes: [14],
                        texts: [addressString],
                        alignement: .left)
              }
        })

    }

       // Camera change Position this methods will call every time
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {

           let destinationLocation = CLLocation(latitude: position.target.latitude,  longitude: position.target.longitude)
           let destinationCoordinate = destinationLocation.coordinate
        updateLocationoordinates(coordinates: destinationCoordinate)
           
       }
}
