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
    
    private func fetchAndDBSyncExchangeRates() async -> Result<ExchangeRates, ExchangeRateError> {
        
        let remoteResult = await fetchRemoteExchangeRates()
        guard case .success(let response) = remoteResult else {
            return remoteResult
        }
        
        let removeResult = await removeLocalExchangeRates()
        guard case .success = removeResult else {
            return removeResult.map { response }
        }
        
        let saveResult = await saveExchangeRates(response)
        guard case .success = saveResult else {
            return saveResult.map { response }
        }
        
        let updateTimeResult = await updateLastRequestTime()
        guard case .success = updateTimeResult else {
            return updateTimeResult.map { _ in response }
        }
        
        return .success(response)
        /*
         switch remoteResult {
        case .success(let response):
            let removeResult = await localDataSource.removeExchangeRates()
            
            switch removeResult {
            case .success:
                let saveResult = await localDataSource.saveExchangeRates(exchangeRates: response)
                
                switch saveResult {
                case .success:
                    _ = await requestTimeService.saveLastRequestTime(for: .exchangeRates, date: .now)
                    return .success(response)
                case .failure(let error):
                    return .failure(error)
                }
            case .failure(let error):
                return .failure(error)
            }
        case .failure(let error):
            return .failure(error)
        }
         */
    }
    
    private func fetchRemoteExchangeRates() async -> Result<ExchangeRates, ExchangeRateError> {
        await remoteDataSource.getLatestCurrencyRates()
    }
    
    private func removeLocalExchangeRates() async -> Result<Void, ExchangeRateError> {
        await localDataSource.removeExchangeRates()
    }
    
    private func saveExchangeRates(_ exchangeRates: ExchangeRates) async -> Result<Void, ExchangeRateError> {
        await localDataSource.saveExchangeRates(exchangeRates: exchangeRates)
    }
    
    private func updateLastRequestTime() async -> Result<Void, ExchangeRateError> {
        await requestTimeService.saveLastRequestTime(for: .exchangeRates, date: .now)
    }
    
    private func shouldFetchNewExchangeRates() async -> Result<Bool, ExchangeRateError> {
        
        let requestTimeResult = await requestTimeService.getLastRequestTime(for: .exchangeRates)
        switch requestTimeResult {
        case .success(let requestTime):
            
            guard let requestTime else {
                return .success(true)
            }
            
            let currentTime = Date.now
            if let timeDiff =  Calendar.current.dateComponents([.minute], from: requestTime, to: currentTime).minute {
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
