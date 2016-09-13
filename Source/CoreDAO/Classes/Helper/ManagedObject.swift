//
//  ManagedObject.swift
//  CoreDAO
//
//  Created by Ivan Vavilov on 07/02/16.
//  Copyright © 2016 RedMadRobot LLC. All rights reserved.
//

import UIKit
import CoreData


class ManagedObject: NSManagedObject {

    //FIXME
    init(withClass: NSManagedObject.Type, inContext context: NSManagedObjectContext)
    {
        super.init(entity: ManagedObject.entity(withClass, context: context), insertInto: context)
    }

    internal class func object(_ ofClass: NSManagedObject.Type, inContext context: NSManagedObjectContext) -> NSManagedObject
    {
        return ManagedObject(withClass: ofClass, inContext: context)
    }

    fileprivate class func entity(_ withClass: NSManagedObject.Type, context: NSManagedObjectContext) -> NSEntityDescription
    {
        return NSEntityDescription.entity(forEntityName: name(withClass), in: context)!
    }

    fileprivate class func name(_ withClass: NSManagedObject.Type) -> String
    {
        return NSStringFromClass(withClass).components(separatedBy: ".").last!
    }
}
