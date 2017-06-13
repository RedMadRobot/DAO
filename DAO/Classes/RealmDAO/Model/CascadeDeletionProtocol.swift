//
//  CascadeDeletionProtocol.swift
//  DAO
//
//  Created by Igor Bulyga on 24.06.16.
//  Copyright © 2016 RedMadRobot LLC. All rights reserved.
//


import Foundation
import RealmSwift


/// Protocol to implement cascade deletion of related entities
public protocol CascadeDeletionProtocol {
    
    var objectsToDelete: [Object] { get }
    
}
