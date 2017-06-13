//
//  RLMTypes.swift
//  DAO
//
//  Created by Ivan Vavilov on 5/17/17.
//  Copyright © 2017 RedMadRobot LLC. All rights reserved.
//

import UIKit
import RealmSwift
import Realm


/// Protocol for implement wrappers for standard types that Realm can't save now.
/// Use it if you want to save collection of standard type in Realm.
public protocol RLMPrimitiveType: class {
    
    associatedtype A

    var value: A { get set }
    
    init(val: A)
}


/// String wrapper
open class RLMString: Object, RLMPrimitiveType {

    public required init(val: String) {
        value = val
        super.init()
    }

    public required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    
    public required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required public init() {
        super.init()
    }
    
    public typealias A = String
    
    public dynamic var value: String = ""

}


/// Integer wrapper
open class RLMInteger: Object, RLMPrimitiveType {
    
    public required init(val: Int) {
        value = val
        super.init()
    }
    
    public required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    
    public required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required public init() {
        super.init()
    }

    public typealias A = Int
    
    public dynamic var value: Int = 0

}


/// Double wrapper
open class RLMDouble: Object, RLMPrimitiveType {
    
    public required init(val: Double) {
        value = val
        super.init()
    }
    
    public required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    
    public required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required public init() {
        super.init()
    }
    
    public typealias A = Double
    
    public dynamic var value: Double = 0.0
    
}


/// Date wrapper
open class RLMDate: Object, RLMPrimitiveType {
    
    public required init(val: Date) {
        super.init()
    }
    
    public required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    
    public required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required public init() {
        super.init()
    }
    
    public typealias A = Date
    
    public dynamic var value: Date = Date()
    
}


/// Data wrapper
open class RLMData: Object, RLMPrimitiveType {
    
    public required init(val: Data) {
        value = val
        super.init()
    }
    
    public required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    
    public required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required public init() {
        super.init()
    }
    
    public typealias A = Data
    
    public dynamic var value: Data = Data()

}
