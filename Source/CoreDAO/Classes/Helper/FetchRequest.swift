//
//  FetchRequest.swift
//  CoreDAO
//
//  Created by Ivan Vavilov on 06/02/16.
//  Copyright © 2016 RedMadRobot LLC. All rights reserved.
//

import UIKit
import CoreData


// MARK: - Реализован в виде extension, т.к. требуется вызов designated initializer, а нам нужeн вызов convenience initializer


extension NSFetchRequest {

    class func fetchRequest(entryClass: NSManagedObject.Type) -> NSFetchRequest!
    {
        return NSFetchRequest(entityName: NSFetchRequest.name(entryClass))
    }

    class func fetchRequest(entryClass: NSManagedObject.Type, predicate: NSPredicate?) -> NSFetchRequest!
    {
        let fetchRequest = NSFetchRequest.fetchRequest(entryClass: entryClass)
        fetchRequest?.predicate = predicate
        return fetchRequest
    }

    class func fetchRequest(entryClass: NSManagedObject.Type, predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]) -> NSFetchRequest!
    {
        let fetchRequest = NSFetchRequest.fetchRequest(entryClass: entryClass)
        fetchRequest?.predicate = predicate
        fetchRequest?.sortDescriptors = sortDescriptors
        return fetchRequest
    }

    fileprivate class func name(_ withClass: NSManagedObject.Type) -> String
    {
        return NSStringFromClass(withClass).components(separatedBy: ".").last!
    }
}
