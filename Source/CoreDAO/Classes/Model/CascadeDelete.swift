//
//  CascadeDelete.swift
//  CoreDAO
//
//  Created by Igor Bulyga on 09.02.16.
//  Copyright © 2016 RedMadRobot LLC. All rights reserved.
//

import Foundation


protocol CascadeDelete {
    func cascadeDeleteProperties() -> [String]
}