//
//  CDMessage+CoreDataProperties.swift
//  DAO
//
//  Created by Ivan Vavilov on 5/2/17.
//  Copyright © 2017 RedMadRobot LLC. All rights reserved.
//

import Foundation
import CoreData


extension CDMessage {

    @nonobjc
    class func fetchRequest() -> NSFetchRequest<CDMessage> {
        return NSFetchRequest<CDMessage>(entityName: "CDMessage")
    }

    @NSManaged var text: String?

}
