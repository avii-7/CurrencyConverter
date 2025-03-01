//
//  ExchangeRatesViewModel.swift
//  CurrencyConverter
//
//  Created by Arun on 14/08/24.
//

import Foundation

final class ExchangeRatesViewModel: Sendable {

    private let exchangeRatesRepository: ExchangeRatesRepository

    init(exchangeRateRepository: ExchangeRatesRepository) {
        self.exchangeRatesRepository = exchangeRateRepository
    }
    
    func fetchExchangeRates() async throws -> [Currency] {
        let result = await exchangeRatesRepository.getAllExchangeRates()
        switch result {
        case .success(let exchangeRates):
            return exchangeRates.rates
        case .failure(let error):
            print("Error while fetching currencies: \(error)")
            throw error    
        }
    }
}
