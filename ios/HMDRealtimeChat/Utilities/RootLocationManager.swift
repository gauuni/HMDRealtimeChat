//
//  FitnessLocationManager.swift
//  Fitness
//
//  Created by Duc Nguyen on 10/24/16.
//  Copyright © 2016 Reflect Apps Inc. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit


class RootLocationManager: NSObject, CLLocationManagerDelegate {
    
    static let sharedInstance = RootLocationManager()

    lazy var locationManager: CLLocationManager = {
        var _locationManager = CLLocationManager()
        _locationManager.delegate = self
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest
        _locationManager.activityType = .fitness
        _locationManager.allowsBackgroundLocationUpdates = true
        
        // Movement threshold for new events
        _locationManager.distanceFilter = 50.0
        return _locationManager
    }()
    
    lazy var locations = [CLLocation]()
    
    override init() {
        super.init()
        
        locationManager.requestAlwaysAuthorization()
    }
 
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        for location in locations {
            let howRecent = location.timestamp.timeIntervalSinceNow
            
            // save on the fitness state manager
            print("didUpdateLocations: \(location.coordinate)")
            if abs(howRecent) < 10 && location.horizontalAccuracy < 20 {
                //update distance
                if self.locations.count > 0 {
                    var coords = [CLLocationCoordinate2D]()
                    coords.append(self.locations.last!.coordinate)
                    coords.append(location.coordinate)
                }
                
                //save location
                self.locations.append(location)
            }
        }
    }
}
