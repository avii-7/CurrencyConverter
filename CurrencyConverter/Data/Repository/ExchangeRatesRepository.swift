//
//  ExchangeRatesRepository.swift
//  CurrencyConverter
//
//  Created by Arun on 14/08/24.
//

import Foundation

protocol ExchangeRatesRepository: Sendable {

    func getAllExchangeRates() async -> Result<ExchangeRates, ExchangeRateError>
}
