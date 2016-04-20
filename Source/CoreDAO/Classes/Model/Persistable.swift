//
//  Persistable.swift
//  CoreDAO
//
//  Created by Igor Bulyga on 04.02.16.
//  Copyright © 2016 RedMadRobot LLC. All rights reserved.
//


import Foundation


public protocol Persistable {
    init()//обязательный инициализатор - нужен для инстанциирования сущностей-адапторов
    var entityId: String!
    {
        get set
    }
}