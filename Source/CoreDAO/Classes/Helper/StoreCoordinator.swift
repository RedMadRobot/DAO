//
//  StoreCoordinator.swift
//  CoreDAO
//
//  Created by Ivan Vavilov on 07/02/16.
//  Copyright © 2016 RedMadRobot LLC. All rights reserved.
//

import UIKit
import CoreData


class StoreCoordinator: NSPersistentStoreCoordinator {

    private var storeOptions: [String:AnyObject]
    {
        return [ NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true, NSSQLitePragmasOption: [ "journal_mode": "WAL" ] ]
    }

    init(storeName: String)
    {
        super.init(managedObjectModel: NSManagedObjectModel.mergedModelFromBundles(nil)!)
        _ = try? addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url(storeName), options: storeOptions)
    }

    class func coordinator(storageName: String) -> StoreCoordinator
    {
        return StoreCoordinator(storeName: storageName)
    }


    private func url(storeName: String) -> NSURL!
    {
        var url: NSURL! = nil
        if let documentsDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first {
            let storeAbsolutePath = ( documentsDirectory as NSString ).stringByAppendingPathComponent(storeName)
            url = NSURL(fileURLWithPath: storeAbsolutePath)
        }

        return url
    }

}
