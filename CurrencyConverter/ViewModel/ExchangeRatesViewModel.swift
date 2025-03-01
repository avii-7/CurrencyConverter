//
//  ExchangeRatesViewModel.swift
//  CurrencyConverter
//
//  Created by Arun on 14/08/24.
//

import Foundation

@MainActor
final class ExchangeRatesViewModel: ObservableObject {
    
    @Published var currencies = [Currency]()
    
    var filteredCurrencies: [Currency] {
        guard amount > 0 else { return [] }
        return currencies
    }
    
    @Published var amount = 0
    
    @Published var selectedCurrency = "INR"

    let exchangeRatesRepository: ExchangeRatesRepository
    
    nonisolated init(exchangeRateRepository: ExchangeRatesRepository) {
        self.exchangeRatesRepository = exchangeRateRepository
    }
    
    func fetchExchangeRates() async {
        let result = await exchangeRatesRepository.getAllExchangeRates()
        switch result {
        case .success(let exchangeRates):
            self.currencies = exchangeRates.rates
        case .failure(let error):
            debugPrint(error)
        }
    }
}
