//
//  InMemoryPersistentManager.swift
//  CurrencyConverterTests
//
//  Created by Arun on 22/08/24.
//

import Foundation
@testable import CurrencyConverter

class InMemoryPersistentManager : PersistentManager {
    
    private override init(inMemory: Bool = false) {
        super.init(inMemory: inMemory)
    }
    
    convenience init() {
        self.init(inMemory: true)
    }
}
