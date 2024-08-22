//
//  ExchangeRatesViewModel.swift
//  CurrencyConverter
//
//  Created by Arun on 14/08/24.
//

import Foundation

class ExchangeRatesViewModel {
    
    private(set) var currencies = [Currency]()
    
    let exchangeRatesRepository: ExchangeRatesRepository

    init(exchangeRateRepository: ExchangeRatesRepository) {
        self.exchangeRatesRepository = exchangeRateRepository
    }
    
    func fetchExchangeRates() async throws {
        let result = await exchangeRatesRepository.getAllExchangeRates()
        switch result {
        case .success(let exchangeRates):
            self.currencies = exchangeRates.rates
        case .failure(let error):
            throw error
        }
    }
}
