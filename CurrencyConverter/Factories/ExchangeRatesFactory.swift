//
//  ExchangeRatesFactory.swift
//  CurrencyConverter
//
//  Created by Arun on 18/08/24.
//

import Foundation

@MainActor
struct ExchangeRatesFactory {
    
    static func makeModule() -> ExchangeRatesViewController {
        
        let vm = getViewModel()
        let converter = CurrencyConverterUtility()
        let vc = ExchangeRatesViewController(viewModel: vm, currencyConverter: converter)
        return vc
    }
    
    static func getViewModel() -> ExchangeRatesViewModel {
        let persistenceManager = PersistentManager.shared
        let localSource = CoreDataExchangeRatesSource(persistentMannager: persistenceManager)
        
        let remoteSource = RESTAPIExchangeRatesSource()
        let requestTimeService = UserDefaultsRequestTime()

        let repository = CombinedExchangeRatesRepository(
            localDataSource: localSource,
            remoteDataSource: remoteSource,
            requestTimeService: requestTimeService
        )
        let vm = ExchangeRatesViewModel(exchangeRateRepository: repository)
        return vm
    }
}
