//
//  ExchangeRatesViewModel.swift
//  CurrencyConverter
//
//  Created by Arun on 14/08/24.
//

import Foundation

class ExchangeRatesViewModel {
    
    // Todo: Should be optional
    var exchangeRates = ExchangeRates()
    
    private(set) var currencies = [String: Double]()
    
    var currencyConverter = CurrencyConverter()
    
    var supportedCurrencies = [String]()
    
    let exchangeRatesRepository: ExchangeRatesRepository

    init(exchangeRateRepository: ExchangeRatesRepository) {
        self.exchangeRatesRepository = exchangeRateRepository
    }
    
    func fetchExchangeRates() async throws {
        Task {
            let result = await exchangeRatesRepository.getAllExchangeRates()
            
            switch result {
            case .success(let exchangeRates):
                self.exchangeRates = exchangeRates
                supportedCurrencies = Array(exchangeRates.rates.keys)
                currencyConverter = CurrencyConverter(currencies: exchangeRates.rates)
            case .failure(let error):
                throw error
            }
        }
    }
    
    func onAmountEntered(amount: Double, currency selectedCurrency: String) {
        
        currencies.removeAll(keepingCapacity: true)
        
        for currencyRate in exchangeRates.rates {
            let currency = currencyRate.key
            let convertedPrice = currencyConverter.convert(from: selectedCurrency, to: currency, for: amount)
            currencies[currency] = convertedPrice
        }
    }
}
