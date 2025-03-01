//
//  CurrencyConerterView1.swift
//  CurrencyConverter
//
//  Created by Arun on 28/08/24.
//

import SwiftUI

//struct CurrencyConerterView1: View {
//    
//    let columns = [
//        GridItem(.flexible()),
//        GridItem(.flexible()),
//        GridItem(.flexible())
//    ]
//    
//    @StateObject private var vm = ExchangeRatesFactory.getViewModel()
//    
//    var body: some View {
//        NavigationStack {
//            GeometryReader { geometry in
//                VStack {
//                    HStack {
//                        Text(getSymbolForCurrencyCode(code: vm.selectedCurrency) ?? "")
//                        TextField("Enter an amount", value: $vm.amount, format: .number)
//                            .textFieldStyle(.roundedBorder)
//                            .padding(.vertical)
//                            .keyboardType(.decimalPad)
//                    }
//                    
//                    Picker("Please choose a currency", selection: $vm.selectedCurrency) {
//                        ForEach(vm.currencies) { currency in
//                            Text(currency.code).tag(currency.code)
//                        }
//                    }
//                    .pickerStyle(.menu)
//                    
//                    ScrollView {
//                        LazyVGrid(columns: columns, spacing: 10, content: {
//                            ForEach(vm.filteredCurrencies) { item in
//                                VStack {
//                                    Text(item.code)
//                                    Text(item.baseAmount, format: .currency(code: item.code))
//                                }
//                                .frame(width: geometry.size.width / 3 - 15, height: 150)
//                                .background(.gray)
//                            }
//                        })
//                    }.task {
//                        await vm.fetchExchangeRates()
//                    }
//                }.padding(.horizontal, 10)
//            }
//            .navigationTitle("Currency Converter")
//            .toolbarTitleDisplayMode(.inline)
//        }
//    }
//    
//    func getSymbolForCurrencyCode(code: String) -> String? {
//        let result = Locale.availableIdentifiers.first { $0.caseInsensitiveCompare(code) == .orderedSame }
//        return Locale(identifier: result ?? "").currencySymbol
//        //return result?.currencySymbol
//        
////        return Locale(identifier: "CAD").currencySymbol
////        return Locale.current.currencySymbol
//    }
//}
//
//#Preview {
//    CurrencyConerterView1()
//}
