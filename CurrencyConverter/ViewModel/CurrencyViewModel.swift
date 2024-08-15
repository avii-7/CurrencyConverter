//
//  CurrencyViewModel.swift
//  CurrencyConverter
//
//  Created by Arun on 14/08/24.
//

import Foundation

class CurrencyViewModel {
    
    var exchangeRates = ExchangeRates()
    
    private(set) var currencies = [String: Double]()
    
    var currencyConverter = CurrencyConverter()
    
    var supportedCurrencies = [String]()
    
    private let currencyResource: CurrencyResourceProtocol
    
    private let repository: CurrencyRepository
    
    init(
        currencyConverter: CurrencyConverter = CurrencyConverter(),
        repository: CurrencyRepository = CurrencyCoreDataRepository(),
        currencyResource: CurrencyResourceProtocol = CurrencyResource()
    ) {
        self.currencyConverter = currencyConverter
        self.repository = repository
        self.currencyResource = currencyResource
    }
    
    func fetchCurrencies(completion: @escaping () -> Void) {
        
        if shouldFetchNewCurrencies() {
            Task {
                
                do {
                    
                    let exchangeRateResponse = try await self.fetchNewCurrencies()
                    
                    // core datauserDefaultManager
                    repository.saveCurrencyRates(exchangeRate: exchangeRateResponse)
                    
                    //local variable update
                    self.exchangeRates = ExchangeRates(
                        baseCurrency: exchangeRateResponse.base,
                        rates: exchangeRateResponse.rates
                    )
                    
                    self.supportedCurrencies = Array(exchangeRateResponse.rates.keys)
                    
                    currencyConverter = CurrencyConverter(
                        currencies: exchangeRateResponse.rates
                    )
                    
                    repository.saveLastRequestTime(time: .now)
                    
                    completion()
                }
                catch {
                    completion()
                }
            }
        }
        else {
            
            guard let exchangeRates = repository.getExchangeRates() else {
                completion()
                return
            }
            
            self.exchangeRates = ExchangeRates(
                baseCurrency: exchangeRates.baseCurrency,
                rates: exchangeRates.rates
            )
            
            self.supportedCurrencies = Array(exchangeRates.rates.keys)
            
            currencyConverter = CurrencyConverter(currencies: exchangeRates.rates)
            completion()
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
      
    private func fetchNewCurrencies() async throws -> ExchangeRateResponse {
        let currenciesRates = try await currencyResource.getLatestCurrencyRates()
        return currenciesRates
    }
    
    private func shouldFetchNewCurrencies() -> Bool {
        
        guard let requestTime = repository.getLastRequestTime() else {
            return true
        }
        let currentTime = Date.now
        if let timeDiff =  Calendar.current.dateComponents([.minute], from: currentTime, to: requestTime).minute {
            return timeDiff > 15
        }
        
        return false
    }
}
