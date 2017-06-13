//
//  CDFolder+CoreDataProperties.swift
//  DAO
//
//  Created by Ivan Vavilov on 5/2/17.
//  Copyright © 2017 RedMadRobot LLC. All rights reserved.
//

import Foundation
import CoreData


extension CDFolder {

    @nonobjc
    class func fetchRequest() -> NSFetchRequest<CDFolder> {
        return NSFetchRequest<CDFolder>(entityName: "CDFolder")
    }

    @NSManaged var name: String
    @NSManaged var messages: NSSet?

}

// MARK: Generated accessors for messages
extension CDFolder {

    @objc(addMessagesObject:)
    @NSManaged func addToMessages(_ value: CDMessage)

    @objc(removeMessagesObject:)
    @NSManaged func removeFromMessages(_ value: CDMessage)

    @objc(addMessages:)
    @NSManaged func addToMessages(_ values: NSSet)

    @objc(removeMessages:)
    @NSManaged func removeFromMessages(_ values: NSSet)

}
