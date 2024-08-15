//
//  CurrencyViewModelTests.swift
//  CurrencyConverterTests
//
//  Created by Arun on 14/08/24.
//

import XCTest
@testable import CurrencyConverter

final class CurrencyViewModelTests: XCTestCase {
    
    private var viewModel: CurrencyViewModel!
    
    private var mockCurrencyResource: MockCurrencyResource!
    
    private var mockCurrencyRepository: MockCurrencyRepository!

    override func setUp() {
        mockCurrencyResource = MockCurrencyResource()
        mockCurrencyRepository = MockCurrencyRepository()
        viewModel = CurrencyViewModel(repository: mockCurrencyRepository, currencyResource: mockCurrencyResource)
    }

    override func tearDown() {
        viewModel = nil
        mockCurrencyResource = nil
        mockCurrencyRepository = nil
    }
    
    func testFetchNewCurrenciesIfTimeDifferenceIsMoreThan15Minutes() {
        
        // Set the last request time to be 15 minutes ago
        mockCurrencyRepository.cache = false
        
        let expectation = XCTestExpectation(description: "Fetch currencies")
        
        viewModel.fetchCurrencies {
            // Verify that the mock resource was called
            XCTAssertTrue(self.mockCurrencyResource.didFetchNewRates)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }

    
    func testFetchCachedCurrenciesIfTimeDifferenceIsLessThan15Minutes() {
        
        // Set the last request time to be with in 15 minutes
        mockCurrencyRepository.cache = true
        
        let expectation = XCTestExpectation(description: "Fetch currencies")
        
        viewModel.fetchCurrencies {
            // Verify that the mock resource was not called or not
            XCTAssertFalse(self.mockCurrencyResource.didFetchNewRates)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }


    
}
