//
//  MapVC.swift
//  Pneuma
//
//  Created by iTechnolabs on 04/03/21.
//  Copyright © 2021 Jatin. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController {

    @IBOutlet weak var customNavigation: CustomNavigationView!
    @IBOutlet weak var mapView: MKMapView!

    var lat:Double!
    var long:Double!
    var hotelData : HotelSearchData?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        customNavigation.title = hotelData?.hotelName
        setMap()
    }
    

    private func setMap() {
        //1
        self.mapView.isUserInteractionEnabled = false
        let location = CLLocationCoordinate2D(latitude: lat,longitude: long)

        // 2
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)

        //3
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = hotelData?.hotelName
        annotation.subtitle = hotelData?.hotelAddress
        mapView.addAnnotation(annotation)
    }
}
