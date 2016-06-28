//
//  CascadeDeletionProtocol.swift
//  CoreDAO
//
//  Created by Igor Bulyga on 24.06.16.
//  Copyright © 2016 RedMadRobot LLC. All rights reserved.
//


import Foundation
import RealmSwift


public protocol CascadeDeletionProtocol {
    func objectsToDelete() -> [AnyObject?]
}