//
//  CombinedExchangeRatesRepository.swift
//  CurrencyConverter
//
//  Created by Arun on 18/08/24.
//

import Foundation

class CombinedExchangeRatesRepository: ExchangeRatesRepository {
    
    let localDataSource: LocalExchangeRatesSource
    
    let remoteDataSource: RemoteExchangeRatesSource
    
    let requestTimeService: RequestTime
    
    init(localDataSource: LocalExchangeRatesSource, remoteDataSource: RemoteExchangeRatesSource, requestTimeService: RequestTime) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
        self.requestTimeService = requestTimeService
    }
    
    func getAllExchangeRates() async -> Result<ExchangeRates, ExchangeRateError> {
        
        let shouldFetchResult = await shouldFetchNewExchangeRates()
        
        switch shouldFetchResult {
        case .success(let shouldFetch):
            if shouldFetch {
                return await fetchAndDBSyncExchangeRates()
            }
            
            let localResult = await localDataSource.getExchangeRates()
            switch localResult {
            case .success(let cache):
                if let cache {
                    return .success(cache)
                }
                return await fetchAndDBSyncExchangeRates()
            case .failure(let error):
                return .failure(error)
            }
            
        case .failure(let error):
            return .failure(error)
        }
    }
    
    // Todo: Should I declare them private or not ? - Helper methods
    private func fetchAndDBSyncExchangeRates() async -> Result<ExchangeRates, ExchangeRateError> {
        let remoteResult = await remoteDataSource.getLatestCurrencyRates()
        
        switch remoteResult {
        case .success(let response):
            _ = await requestTimeService.saveLastRequestTime(for: .exchangeRates, date: .now)
            _ = await localDataSource.saveExchangeRates(exchangeRates: response)
            return .success(response)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    // Todo: What about error handling in below function ?
    private func shouldFetchNewExchangeRates() async -> Result<Bool, ExchangeRateError> {
        let requestTimeResult = await requestTimeService.getLastRequestTime(for: .exchangeRates)
        switch requestTimeResult {
        case .success(let requestTime):
            
            guard let requestTime else {
                return .success(true)
            }

            let currentTime = Date.now
            if let timeDiff =  Calendar.current.dateComponents([.minute], from: currentTime, to: requestTime).minute {
                return .success(timeDiff > 15)
            }
            else {
                return .success(true)
            }
            
        case .failure(let error):
            return .failure(.requestTime(description: error.localizedDescription))
        }
    }
}
