//
//  MockUserDefaults.swift
//  CurrencyConverterTests
//
//  Created by Arun on 14/08/24.
//

import Foundation

class MockUserDefaults: UserDefaults {

    var store = [String: Any]()
    
    override func set(_ value: Any?, forKey defaultName: String) {
        store[defaultName] = value
    }
    
    override func data(forKey defaultName: String) -> Data? {
        return store[defaultName] as? Data
    }
    
    override func removeObject(forKey defaultName: String) {
        store.removeValue(forKey: defaultName)
    }
    
    override func object(forKey defaultName: String) -> Any? {
        return store[defaultName]
    }
}
