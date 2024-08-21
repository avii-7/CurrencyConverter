//
//  ExchangeRateEntity+CoreDataProperties.swift
//  CurrencyConverter
//
//  Created by Arun on 21/08/24.
//
//

import Foundation
import CoreData


extension ExchangeRateEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExchangeRateEntity> {
        return NSFetchRequest<ExchangeRateEntity>(entityName: "ExchangeRateEntity")
    }

    @NSManaged public var baseCurrency: String?
    @NSManaged public var currencies: Set<CurrencyEntity>?

}

// MARK: Generated accessors for currencies
extension ExchangeRateEntity {

    @objc(addCurrenciesObject:)
    @NSManaged public func addToCurrencies(_ value: CurrencyEntity)

    @objc(removeCurrenciesObject:)
    @NSManaged public func removeFromCurrencies(_ value: CurrencyEntity)

    @objc(addCurrencies:)
    @NSManaged public func addToCurrencies(_ values: Set<CurrencyEntity>)

    @objc(removeCurrencies:)
    @NSManaged public func removeFromCurrencies(_ values: Set<CurrencyEntity>)

}

extension ExchangeRateEntity : Identifiable {

}
