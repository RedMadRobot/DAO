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

    fileprivate var storeOptions: [String: Any]
    {
        return [
            NSMigratePersistentStoresAutomaticallyOption: true as AnyObject,
            NSInferMappingModelAutomaticallyOption: true as AnyObject,
            NSSQLitePragmasOption: [ "journal_mode": "WAL" ] ]
    }

    init(storeName: String)
    {
        super.init(managedObjectModel: NSManagedObjectModel.mergedModel(from: nil)!)
        _ = try? addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url(storeName), options: storeOptions)
    }

    class func coordinator(_ storageName: String) -> StoreCoordinator
    {
        return StoreCoordinator(storeName: storageName)
    }


    fileprivate func url(_ storeName: String) -> URL!
    {
        var url: URL! = nil
        if let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            let storeAbsolutePath = ( documentsDirectory as NSString ).appendingPathComponent(storeName)
            url = URL(fileURLWithPath: storeAbsolutePath)
        }

        return url
    }

}
