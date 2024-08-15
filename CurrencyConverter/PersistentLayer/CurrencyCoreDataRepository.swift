//
//  CurrencyCoreDataRepository.swift
//  CurrencyConverter
//
//  Created by Arun on 14/08/24.
//

import Foundation
import CoreData

class CurrencyCoreDataRepository: CurrencyRepository {
    
    private let persistentMannager: PersistentManager
    
    private let userDefaultsManager: UserDefaultsManager
    
    init(
        persistentMannager: PersistentManager = PersistentManager.shared,
        userDefaultsManager: UserDefaultsManager = UserDefaultsManager()
    ) {
        self.persistentMannager = persistentMannager
        self.userDefaultsManager = userDefaultsManager
    }
    
    func getExchangeRates() -> ExchangeRates? {
        let request: NSFetchRequest<ExchangeRateEntity> = ExchangeRateEntity.fetchRequest()
        request.fetchLimit = 1
        
        do {
            let exchangeRateEntity = try persistentMannager.context.fetch(request).first
            return exchangeRateEntity?.convertToDomain()
        } catch {
            print("Error fetching from CoreData: \(error)")
            return nil
        }
    }
    
    func saveCurrencyRates(exchangeRate: ExchangeRateResponse) {
        removeExistingCurrencies()
        do {
            
            let exchangeRateEntity = ExchangeRateEntity(context: persistentMannager.context)
            exchangeRateEntity.baseCurrency = exchangeRate.base
            
            let ratesData = try JSONSerialization.data(withJSONObject: exchangeRate.rates, options: [])
            exchangeRateEntity.exchangeRates = ratesData
            
            try persistentMannager.context.save()
        } catch {
            print("Error saving to CoreData: \(error)")
        }
    }
    
    func removeExistingCurrencies() {
        let fetchRequest = ExchangeRateEntity.fetchRequest()
        
        do {
            if let exchangeRateEntity = try persistentMannager.context.fetch(fetchRequest).first {
                persistentMannager.context.delete(exchangeRateEntity)
                try persistentMannager.context.save()
            }
        } catch {
            print("Error deleting from CoreData: \(error)")
        }
    }
    
    func saveLastRequestTime(time: Date) {
        userDefaultsManager.set(time, forKey: "lastRequestTime")
    }
    
    func getLastRequestTime() -> Date? {
        userDefaultsManager.get(forKey: "lastRequestTime", as: Date.self)
    }
}
