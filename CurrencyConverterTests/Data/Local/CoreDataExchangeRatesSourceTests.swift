//
//  CoreDataExchangeRatesSourceTests.swift
//  CurrencyConverterTests
//
//  Created by Arun on 22/08/24.
//

import Foundation
import XCTest
@testable import CurrencyConverter

final class CoreDataExchangeRatesSourceTests: XCTestCase {
    
    private var sut: CoreDataExchangeRatesSource!
    private var persistanceManager: InMemoryPersistentManager!
    
    override func setUp() {
        persistanceManager = InMemoryPersistentManager()
        sut = CoreDataExchangeRatesSource(persistentMannager: persistanceManager)
    }
    
    override func tearDown() {
        persistanceManager = nil
        sut = nil
    }
    
    func testGetExchangeRates_Success_nil() async {
        let getExchangeRatesResult = await sut.getExchangeRates()
        
        if 
            case .success(let result) = getExchangeRatesResult,
            result == nil {
            // Success
        }
        else {
            XCTFail("Expected success with nil value")
        }
    }
    
    func testSaveExchangeRates_Success() async {
        let currency1 = Currency(code: "INR", baseAmount: 83.234)
        let currency2 = Currency(code: "CAD", baseAmount: 1.358281)
        let currency3 = Currency(code: "BTC", baseAmount: 0.000016454141)
        
        let exchangeRates = ExchangeRates(baseCurrency: "USD", rates: [currency1, currency2, currency3])
        let result = await sut.saveExchangeRates(exchangeRates: exchangeRates)
        
        if case .failure = result {
            XCTFail("Expected sucess on save")
        }
        
        let getExchangeRatesResult = await sut.getExchangeRates()
        
        switch getExchangeRatesResult {
        case .success(let getExchangeRates):
            if let getExchangeRates {
                
                XCTAssertEqual(getExchangeRates.baseCurrency, exchangeRates.baseCurrency)
                XCTAssertEqual(getExchangeRates.rates[0], exchangeRates.rates[0])
                XCTAssertEqual(getExchangeRates.rates[1], exchangeRates.rates[1])
                XCTAssertEqual(getExchangeRates.rates[2], exchangeRates.rates[2])
            }
            else {
                XCTFail("Expected value")
            }
        case .failure:
            XCTFail("Expected sucess")
        }
    }
    
    func testRemoveExchangeRates_Success() async {
        let currency1 = Currency(code: "INR", baseAmount: 83.234)
        let currency2 = Currency(code: "CAD", baseAmount: 1.358281)
        let currency3 = Currency(code: "BTC", baseAmount: 0.000016454141)
        
        let exchangeRates = ExchangeRates(baseCurrency: "USD", rates: [currency1, currency2, currency3])
        let result = await sut.saveExchangeRates(exchangeRates: exchangeRates)
        
        if case .failure = result {
            XCTFail("Expected sucess on save")
        }
        
        let removeResult = await sut.removeExchangeRates()
        
        if case .failure = removeResult {
            XCTFail("Expected success on removing")
        }
        
        let getExchangeRatesResult = await sut.getExchangeRates()
        
        switch getExchangeRatesResult {
        case .success(let getExchangeRates):
            if getExchangeRates != nil {
                XCTFail("Expected nil")
            }
        case .failure:
            XCTFail("Expected sucess with nil")
        }
    }
}
