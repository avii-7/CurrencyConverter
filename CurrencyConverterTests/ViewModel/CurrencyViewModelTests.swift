//
//  CurrencyViewModelTests.swift
//  CurrencyConverterTests
//
//  Created by Arun on 14/08/24.
//

import XCTest
@testable import CurrencyConverter

final class CurrencyViewModelTests: XCTestCase {
    
    private var sut: ExchangeRatesViewModel!
    
    private var repositoryStub: CombinedExchangeRatesRepositoryStub!

    override func setUp() {
        repositoryStub = CombinedExchangeRatesRepositoryStub()
        sut = ExchangeRatesViewModel(exchangeRateRepository: repositoryStub)
    }

    override func tearDown() {
        sut = nil
        repositoryStub = nil
    }
    
    func testFetchExchangeRates_Success() async throws {
        try await sut.fetchExchangeRates()
        
        XCTAssertEqual(sut.currencies.count, 3)
    }
    
    func testFetchExchangeRates_MockLocalFailure() async throws {
        
        let mockError = ExchangeRateError.localData(description: "mock local error")
        repositoryStub.error = mockError
        
        do {
            try await sut.fetchExchangeRates()
        }
        catch {
            XCTAssertEqual(error as! ExchangeRateError, mockError)
        }
        XCTAssertEqual(sut.currencies.count, 0)
    }
    
    func testFetchExchangeRates_RemoteMockFailure() async throws {
        
        let mockError = ExchangeRateError.remoteData(description: "mock remote error")
        repositoryStub.error = mockError
        
        do {
            try await sut.fetchExchangeRates()
        }
        catch {
            XCTAssertEqual(error as! ExchangeRateError, mockError)
        }
        XCTAssertEqual(sut.currencies.count, 0)
    }
}

/**
 //    func testFetchNewCurrenciesIfTimeDifferenceIsMoreThan15Minutes() {
 //
 //        // Set the last request time to be 15 minutes ago
 //        mockCurrencyRepository.cache = false
 //
 //        let expectation = XCTestExpectation(description: "Fetch currencies")
 //
 //        viewModel.fetchCurrencies {
 //            // Verify that the mock resource was called
 //            XCTAssertTrue(self.mockCurrencyResource.didFetchNewRates)
 //            expectation.fulfill()
 //        }
 //
 //        wait(for: [expectation], timeout: 2.0)
 //    }
 //
 //
 //    func testFetchCachedCurrenciesIfTimeDifferenceIsLessThan15Minutes() {
 //
 //        // Set the last request time to be with in 15 minutes
 //        mockCurrencyRepository.cache = true
 //
 //        let expectation = XCTestExpectation(description: "Fetch currencies")
 //
 //        viewModel.fetchCurrencies {
 //            // Verify that the mock resource was not called or not
 //            XCTAssertFalse(self.mockCurrencyResource.didFetchNewRates)
 //            expectation.fulfill()
 //        }
 //
 //        wait(for: [expectation], timeout: 2.0)
 //    }
 */
