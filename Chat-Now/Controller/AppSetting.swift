//
//  AppSetting.swift
//  Chat-Now
//
//  Created by Zhicheng Qian on 9/27/18.
//  Copyright © 2018 Zhicheng Qian. All rights reserved.
//

import Foundation

final class AppSettings {
    
    private enum SettingKey: String {
        case displayName

    }
    
    static var displayName: String! {
        get {
            return UserDefaults.standard.string(forKey: SettingKey.displayName.rawValue)
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingKey.displayName.rawValue
            
            if let name = newValue {
                defaults.set(name, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
}
