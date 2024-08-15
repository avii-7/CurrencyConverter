//
//  UserDefaultManager.swift
//  CurrencyConverter
//
//  Created by Arun on 14/08/24.
//

import Foundation

class UserDefaultsManager {
    
    let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    func set<T>(_ value: T?, forKey key: String) {
        guard let value = value else {
            userDefaults.removeObject(forKey: key)
            return
        }
        userDefaults.set(value, forKey: key)
    }
    
    func get<T>(forKey key: String, as type: T.Type) -> T? {
        guard let data = userDefaults.object(forKey: key) else {
            return nil
        }
        
        return data as? T
    }
    
    func remove(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }
}
