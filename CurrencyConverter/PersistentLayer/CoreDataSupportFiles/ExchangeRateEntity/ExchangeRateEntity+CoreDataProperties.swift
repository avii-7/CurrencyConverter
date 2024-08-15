//
//  ExchangeRateEntity+CoreDataProperties.swift
//  CurrencyConverter
//
//  Created by Arun on 14/08/24.
//
//

import Foundation
import CoreData


extension ExchangeRateEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExchangeRateEntity> {
        return NSFetchRequest<ExchangeRateEntity>(entityName: "ExchangeRateEntity")
    }

    @NSManaged public var baseCurrency: String?
    @NSManaged public var exchangeRates: Data?

}

extension ExchangeRateEntity : Identifiable {

}
