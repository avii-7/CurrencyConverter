//
//  UserDefaultsRequestTime.swift
//  CurrencyConverter
//
//  Created by Arun on 17/08/24.
//

import Foundation

class UserDefaultsRequestTime: RequestTime {
    
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    func getLastRequestTime(for entity: RequestTimeEntity) async -> Result<Date?, ExchangeRateError> {
        if let result = userDefaults.object(forKey: entity.rawValue) as? Date {
            return .success(result)
        }
        
        return .success(nil)
    }
    
    func saveLastRequestTime(for entity: RequestTimeEntity, date: Date) async -> Result<Void, ExchangeRateError> {
        userDefaults.set(date, forKey: entity.rawValue)
        return .success(())
    }
}
