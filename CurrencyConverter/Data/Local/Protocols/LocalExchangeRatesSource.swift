//
//  LocalExchangeRatesSource.swift
//  CurrencyConverter
//
//  Created by Arun on 17/08/24.
//

import Foundation

protocol LocalExchangeRatesSource {
    
    func getExchangeRates() async -> Result<ExchangeRates?, ExchangeRateError>
    
    func saveExchangeRates(exchangeRates: ExchangeRates) async -> Result<Void, ExchangeRateError>
                                                
    func removeExchangeRates() async -> Result<Void, ExchangeRateError>
}
