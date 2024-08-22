//
//  CoreDataExchangeRatesSource.swift
//  CurrencyConverter
//
//  Created by Arun on 17/08/24.
//

import Foundation
import CoreData

class CoreDataExchangeRatesSource: LocalExchangeRatesSource {
    
    private let persistentMannager: PersistentManager
    
    init(persistentMannager: PersistentManager) {
        self.persistentMannager = persistentMannager
    }
    
    func getExchangeRates() async -> Result<ExchangeRates?, ExchangeRateError> {
        do {
            let request: NSFetchRequest<ExchangeRateEntity> = ExchangeRateEntity.fetchRequest()
            request.fetchLimit = 1
            if let exchangeRateEntity = try persistentMannager.context.fetch(request).first {
                return .success(exchangeRateEntity.convertToDomain())
            }
            return .success(nil)
        } catch {
            return .failure(.localData(description: error.localizedDescription))
        }
    }
    
    func saveExchangeRates(exchangeRates: ExchangeRates) async -> Result<Void, ExchangeRateError> {
        do {
            let exchangeRateEntity = ExchangeRateEntity(context: persistentMannager.context)
            exchangeRateEntity.baseCurrency = exchangeRates.baseCurrency
            
            let currencyEntites = exchangeRates.rates.map {
                let entity = CurrencyEntity(context: persistentMannager.context)
                entity.baseAmount = NSDecimalNumber(decimal: $0.baseAmount)
                entity.code = $0.code
                return entity
            }
            
            exchangeRateEntity.currencies = Set(currencyEntites)
            
            try persistentMannager.saveContext()
            return .success(())
        }
        catch {
            return .failure(.localData(description: error.localizedDescription))
        }
    }
    
    func removeExchangeRates() async -> Result<Void, ExchangeRateError> {
        do {
            let fetchRequest = ExchangeRateEntity.fetchRequest()
            
            let entities = try persistentMannager.context.fetch(fetchRequest)
            
            for entity in entities {
                persistentMannager.context.delete(entity)
            }
            try persistentMannager.saveContext()
            return .success(())
        } catch {
            return .failure(.localData(description: error.localizedDescription))
        }
    }
}
