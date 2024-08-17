//
//  ExchangeRatesFactory.swift
//  CurrencyConverter
//
//  Created by Arun on 18/08/24.
//

import Foundation

struct ExchangeRatesFactory {
    
    static func makeModule() -> ExchangeRatesViewController {
        
        let localSource = CoreDataExchangeRatesSource()
        let remoteSource = RESTAPIExchangeRatesSource()
        let requestTimeService = UserDefaultsRequestTime()

        let repository = CombinedExchangeRatesRepository(
            localDataSource: localSource,
            remoteDataSource: remoteSource,
            requestTimeService: requestTimeService
        )
        let vm = ExchangeRatesViewModel(exchangeRateRepository: repository)
        let vc = ExchangeRatesViewController(viewModel: vm)
        return vc
    }
}
