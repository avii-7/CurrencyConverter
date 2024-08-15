//
//  CurrencyRepository.swift
//  CurrencyConverter
//
//  Created by Arun on 14/08/24.
//

import Foundation

protocol CurrencyRepository {
    
    func getExchangeRates() -> ExchangeRates?
    
    func saveCurrencyRates(exchangeRate: ExchangeRateResponse)
    
    func removeExistingCurrencies()
    
    func saveLastRequestTime(time: Date)
    
    func getLastRequestTime() -> Date?
}
