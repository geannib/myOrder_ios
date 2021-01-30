//
//  AddressMapViewController.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 1/11/21.
//  Copyright © 2021 Geanni Barbulescu. All rights reserved.
//

import UIKit
import GoogleMaps

class AddressMapViewController: UIViewController {

    @IBOutlet weak var viewMap: UIView!
    @IBOutlet weak var labelNext: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        labelNext.generateNext(title: "SALVEAZA ADRESA", isEnabled: true)
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.viewMap.addSubview(mapView)

        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
