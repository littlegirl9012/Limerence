//
//  BookMapViewController.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/20/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
class BookMapViewController: MasterViewController,GMSMapViewDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    var users : [User] = []
    var isDraw = false;
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.isMyLocationEnabled = true
        mapView.delegate = self;
        notifyInstance.add(self, .updateLocation, selector: #selector(getBookLocation))
        locationInstance.requestAuthorization()
        
        navigationView.set(style: .back, title: "Bản Đồ") {
            self.pop()
        }
    }
    
    @objc func getBookLocation()
    {
        mapView.clear();

        let circle = GMSCircle(position: (locationInstance.myLocation?.coordinate)!, radius: 500)
        circle.fillColor = UIColor.red.withAlphaComponent(0.08)
        circle.strokeColor = template.sellColor
        circle.strokeWidth = 2
        circle.map = mapView

        
        let camera = GMSCameraPosition.camera(withLatitude: (locationInstance.myLocation?.coordinate.latitude)!, longitude: (locationInstance.myLocation?.coordinate.longitude)!, zoom: 15.0)
        self.mapView?.animate(to: camera)
        
        let request = UserNear_Request()
        request.user_id = userInstance.user.id
        request.latitude = (locationInstance.myLocation?.coordinate.latitude)!
        request.longitude = (locationInstance.myLocation?.coordinate.longitude)!
//      request.distance = 0.005;
//        request.distance = 0.05;

        request.distance = 1;

        services.userNear(request: request, success: { (response) in
            DispatchQueue.main.async {
                self.users.append(contentsOf: response)
                for item in self.users
                {
                    item.gmsMarker().map = self.mapView
                }

            }
        }) { (error) in
        }
    }

    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        let userMarker = marker as! GMSBookMarker
        mapView.selectedMarker = marker ;
        let newUser = User()
        newUser.aliasname = userMarker.snippet!
        newUser.id = userMarker.user_id
        let detail = BookViewController()
        detail.user = newUser
        push(detail)
        return true
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
