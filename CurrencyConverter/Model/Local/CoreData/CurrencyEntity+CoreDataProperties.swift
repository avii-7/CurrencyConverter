//
//  CurrencyEntity+CoreDataProperties.swift
//  CurrencyConverter
//
//  Created by Arun on 21/08/24.
//
//

import Foundation
import CoreData


extension CurrencyEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrencyEntity> {
        return NSFetchRequest<CurrencyEntity>(entityName: "CurrencyEntity")
    }

    @NSManaged public var baseAmount: NSDecimalNumber
    @NSManaged public var code: String
    @NSManaged public var exchangeRates: ExchangeRateEntity?

}

extension CurrencyEntity : Identifiable {

}
