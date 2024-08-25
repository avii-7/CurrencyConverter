//
//  CombinedExchangeRatesRepositoryTests.swift
//  CurrencyConverterTests
//
//  Created by Arun on 25/08/24.
//

import Foundation
import XCTest
@testable import CurrencyConverter

final class CombinedExchangeRatesRepositoryTests: XCTestCase {
    
    var localDataSource: LocalExchangeRatesSourceStub!
    
    var remoteDataSource: RemoteExchangeRatesSourceStub!
    
    var requestTimeService: RequestTimeStub!
    
    var sut: CombinedExchangeRatesRepository!
    
    override func setUp() {
        localDataSource = LocalExchangeRatesSourceStub()
        remoteDataSource = RemoteExchangeRatesSourceStub()
        requestTimeService = RequestTimeStub()
        sut = CombinedExchangeRatesRepository(
            localDataSource: localDataSource,
            remoteDataSource: remoteDataSource,
            requestTimeService: requestTimeService
        )
    }
    
    override func tearDown() {
        localDataSource = nil
        remoteDataSource = nil
        requestTimeService = nil
    }
    
    func testGetAllExchangeRates_shouldFetchTrue() async {
        requestTimeService.dateType = .past
        
        let exchangeRates = await sut.getAllExchangeRates()
        
        guard case .success(let exchangeRates) = exchangeRates else {
            XCTFail("Excepted Success")
            return
        }

        assertExchangeRates(exchangeRates, local: false)
    }
    
    func testGetAllExchangeRates_shouldFetchFalse() async {
        requestTimeService.dateType = .now
        
        let exchangeRates = await sut.getAllExchangeRates()
        
        guard case .success(let exchangeRates) = exchangeRates else {
            XCTFail("Excepted Success")
            return
        }

        assertExchangeRates(exchangeRates, local: true)
    }
    
    func testGetAllExchangeRates_shouldFetchError() async {
        let testError = ExchangeRateError.requestTime(description: "some error")
        requestTimeService.error = testError
        
        let exchangeRates = await sut.getAllExchangeRates()
        
        guard case .failure(let error) = exchangeRates else {
            XCTFail("Excepted Failure")
            return
        }

        XCTAssertEqual(error, testError)
    }
    
    func testGetAllExchangeRates_cacheEmpty() async {
        localDataSource.shouldReturnExchangeRates = false
        
        let exchangeRates = await sut.getAllExchangeRates()
        
        guard case .success(let exchangeRates) = exchangeRates else {
            XCTFail("Excepted Success")
            return
        }

        assertExchangeRates(exchangeRates, local: false)
    }
    
    func testGetAllExchangeRates_localGetFailure() async {
        
        let testError = ExchangeRateError.localData(description: "some error")
        localDataSource.throwGet = testError
        
        let exchangeRates = await sut.getAllExchangeRates()
        
        guard case .failure(let error) = exchangeRates else {
            XCTFail("Excepted Failure")
            return
        }

        XCTAssertEqual(error, testError)
    }
    
    //MARK: - Tests for fetchAndDBSyncExchangeRates
    
    func testfetchAndDBSyncExchangeRates_RemoteFailure() async {
        requestTimeService.dateType = .past
        
        let testError = ExchangeRateError.localData(description: "some error")
        remoteDataSource.error = testError
        
        let exchangeRates = await sut.getAllExchangeRates()
        
        guard case .failure(let error) = exchangeRates else {
            XCTFail("Excepted Failure")
            return
        }

        XCTAssertEqual(error, testError)
    }
    
    func testfetchAndDBSyncExchangeRates_LocalRemoveFailure() async {
        requestTimeService.dateType = .past
        
        let testError = ExchangeRateError.localData(description: "some error")
        localDataSource.throwRemove = testError
        
        let exchangeRates = await sut.getAllExchangeRates()
        
        guard case .failure(let error) = exchangeRates else {
            XCTFail("Excepted Failure")
            return
        }

        XCTAssertEqual(error, testError)
    }
    
    func testfetchAndDBSyncExchangeRates_LocalSaveFailure() async {
        requestTimeService.dateType = .past
        
        let testError = ExchangeRateError.localData(description: "some error")
        localDataSource.throwSave = testError
        
        let exchangeRates = await sut.getAllExchangeRates()
        
        guard case .failure(let error) = exchangeRates else {
            XCTFail("Excepted Failure")
            return
        }

        XCTAssertEqual(error, testError)
    }
    
    func testfetchAndDBSyncExchangeRates_updateRequestTimeFailure() async {
        requestTimeService.dateType = .past
        
        let testError = ExchangeRateError.requestTime(description: "some error")
        requestTimeService.error = testError
        
        let exchangeRates = await sut.getAllExchangeRates()
        
        guard case .failure(let error) = exchangeRates else {
            XCTFail("Excepted Failure")
            return
        }

        XCTAssertEqual(error, testError)
    }
    
    func assertExchangeRates(_ exchangeRates: ExchangeRates, local: Bool) {
        let staticExchangeRates = local ? ExchangeRates.testGetLocal() : ExchangeRates.testGetRemote()
        XCTAssertEqual(exchangeRates.baseCurrency, staticExchangeRates.baseCurrency)
        XCTAssertEqual(exchangeRates.rates[0], staticExchangeRates.rates[0])
        XCTAssertEqual(exchangeRates.rates[1], staticExchangeRates.rates[1])
        XCTAssertEqual(exchangeRates.rates[2], staticExchangeRates.rates[2])
    }
}
