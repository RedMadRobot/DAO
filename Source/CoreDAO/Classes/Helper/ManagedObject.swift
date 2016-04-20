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
        super.init(entity: ManagedObject.entity(withClass, context: context), insertIntoManagedObjectContext: context)
    }

    internal class func object(ofClass: NSManagedObject.Type, inContext context: NSManagedObjectContext) -> NSManagedObject
    {
        return ManagedObject(withClass: ofClass, inContext: context)
    }

    private class func entity(withClass: NSManagedObject.Type, context: NSManagedObjectContext) -> NSEntityDescription
    {
        return NSEntityDescription.entityForName(name(withClass), inManagedObjectContext: context)!
    }

    private class func name(withClass: NSManagedObject.Type) -> String
    {
        return NSStringFromClass(withClass).componentsSeparatedByString(".").last!
    }
}
