//
//  DBrepresent.swift
//  Chat-Now
//
//  Created by Zhicheng Qian on 9/27/18.
//  Copyright © 2018 Zhicheng Qian. All rights reserved.
//

import Foundation

protocol DatabaseRepresentation {
    var representation: [String: Any] { get }
}
