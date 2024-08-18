//
//  ExchangeRatesViewModel.swift
//  CurrencyConverter
//
//  Created by Arun on 14/08/24.
//

import Foundation

class ExchangeRatesViewModel {
    
    private(set) var exchangeRates = [String: Double]()
    
    private(set) var currencies = [String]()
    
    let exchangeRatesRepository: ExchangeRatesRepository

    init(exchangeRateRepository: ExchangeRatesRepository) {
        self.exchangeRatesRepository = exchangeRateRepository
    }
    
    func fetchExchangeRates() async throws {
        Task {
            let result = await exchangeRatesRepository.getAllExchangeRates()
            
            switch result {
            case .success(let exchangeRates):
                self.exchangeRates = exchangeRates.rates
                currencies = exchangeRates.rates.keys.sorted()
            case .failure(let error):
                throw error
            }
        }
    }
    
    //func onAmountEntered(amount: Double, selectedCurrency: String) { }
}
