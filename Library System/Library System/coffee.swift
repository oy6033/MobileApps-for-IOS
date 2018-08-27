//
//  coffee.swift
//  CSE335-FinalProject
//
//  Created by Yangkang Ou on 2018/4/22.
//  Copyright © 2018 Yangkang Ou. All rights reserved.
//

import Foundation
import MapKit
import UIKit
class coffee: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
