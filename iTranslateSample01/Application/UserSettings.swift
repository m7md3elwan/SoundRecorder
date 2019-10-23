//
//  UserSettings.swift
//  iTranslateSample01
//
//  Created by Elwan on 10/21/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import Foundation

struct UserSettings {
    fileprivate static let userDefaults = UserDefaults.standard
    
    static func save(_ key: UserSettingKey, value: Any) {
        userDefaults.set(value, forKey: key.rawValue)
        userDefaults.synchronize()
    }
    
    static func get<T>(_ key: UserSettingKey) -> T? {
        return userDefaults.object(forKey: key.rawValue) as? T
    }
    
    static func save(_ key: String, value: Any) {
        userDefaults.set(value, forKey: key)
        userDefaults.synchronize()
    }
    
    static func get<T>(_ key: String) -> T? {
        return userDefaults.object(forKey: key) as? T
    }
    
}

enum UserSettingKey: String {
    case FirstLaunch
}
