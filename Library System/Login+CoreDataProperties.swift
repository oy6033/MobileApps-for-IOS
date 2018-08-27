//
//  Login+CoreDataProperties.swift
//  CSE335-FinalProject
//
//  Created by Yangkang Ou on 2018/4/22.
//  Copyright © 2018 Yangkang Ou. All rights reserved.
//
//

import Foundation
import CoreData


extension Login {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Login> {
        return NSFetchRequest<Login>(entityName: "Login")
    }

    @NSManaged public var username: String?
    @NSManaged public var password: String?
    @NSManaged public var email: String?
    @NSManaged public var image: NSData?

}
