//
//  RequestTime.swift
//  CurrencyConverter
//
//  Created by Arun on 17/08/24.
//

import Foundation

protocol RequestTime {
    
    func getLastRequestTime(for entity: RequestTimeEntity) async -> Result<Date?, ExchangeRateError>
    
    func saveLastRequestTime(for entity: RequestTimeEntity, date: Date) async -> Result<Void, ExchangeRateError>
}


