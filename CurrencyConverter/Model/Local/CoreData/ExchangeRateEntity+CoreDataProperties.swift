//
//  ExchangeRateEntity+CoreDataProperties.swift
//  CurrencyConverter
//
//  Created by Arun on 22/08/24.
//
//

import Foundation
import CoreData


extension ExchangeRateEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExchangeRateEntity> {
        return NSFetchRequest<ExchangeRateEntity>(entityName: "ExchangeRateEntity")
    }

    @NSManaged public var baseCurrency: String?
    @NSManaged public var currencies: NSOrderedSet?

}

// MARK: Generated accessors for currencies
extension ExchangeRateEntity {

    @objc(insertObject:inCurrenciesAtIndex:)
    @NSManaged public func insertIntoCurrencies(_ value: CurrencyEntity, at idx: Int)

    @objc(removeObjectFromCurrenciesAtIndex:)
    @NSManaged public func removeFromCurrencies(at idx: Int)

    @objc(insertCurrencies:atIndexes:)
    @NSManaged public func insertIntoCurrencies(_ values: [CurrencyEntity], at indexes: NSIndexSet)

    @objc(removeCurrenciesAtIndexes:)
    @NSManaged public func removeFromCurrencies(at indexes: NSIndexSet)

    @objc(replaceObjectInCurrenciesAtIndex:withObject:)
    @NSManaged public func replaceCurrencies(at idx: Int, with value: CurrencyEntity)

    @objc(replaceCurrenciesAtIndexes:withCurrencies:)
    @NSManaged public func replaceCurrencies(at indexes: NSIndexSet, with values: [CurrencyEntity])

    @objc(addCurrenciesObject:)
    @NSManaged public func addToCurrencies(_ value: CurrencyEntity)

    @objc(removeCurrenciesObject:)
    @NSManaged public func removeFromCurrencies(_ value: CurrencyEntity)

    @objc(addCurrencies:)
    @NSManaged public func addToCurrencies(_ values: NSOrderedSet)

    @objc(removeCurrencies:)
    @NSManaged public func removeFromCurrencies(_ values: NSOrderedSet)

}

extension ExchangeRateEntity : Identifiable {

}
