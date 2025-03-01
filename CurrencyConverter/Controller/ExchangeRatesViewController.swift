//
//  ExchangeRatesViewController.swift
//  CurrencyConverter
//
//  Created by Arun on 14/08/24.
//

import UIKit

final class ExchangeRatesViewController: UIViewController {
    
    private var currencyConverterView: CurrencyConverterView!
    
    private let viewModel: ExchangeRatesViewModel
    
    private let currencyConverter: CurrencyConverter
    
    init(viewModel: ExchangeRatesViewModel, currencyConverter: CurrencyConverter) {
        self.viewModel = viewModel
        self.currencyConverter = currencyConverter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        currencyConverterView = CurrencyConverterView()
        view = currencyConverterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
        configureCurrencyInputTextField()
        configureCurrencySelectorTextField()
        configCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        currencyConverterView.animate(value: true)
        fetchExchangeRates()
    }
    
    private func setTitle() {
        title = "Currency Converter"
        navigationController?.navigationBar.titleTextAttributes
        = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .title1)]
    }
    
    private func fetchExchangeRates() {
        Task {
            await viewModel.fetchExchangeRates()
            self.currencyConverterView.animate(value: false)
            self.currencyConverterView.currencyCollectionView.reloadData()
        }
    }
    
    private func configureCurrencyInputTextField() {
        currencyConverterView.currencyAmountTextField.delegate = self
    }
    
    private func configureCurrencySelectorTextField() {
        currencyConverterView.currencySelectorTextField.delegate = self
        
        currencyConverterView.currencySelectorPickerView.delegate = self
        currencyConverterView.currencySelectorPickerView.dataSource = self
    }
    
    private func configCollectionView() {
        currencyConverterView.currencyCollectionView.dataSource = self
    }
}

// MARK: - UITextField Delegates.

extension ExchangeRatesViewController : UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard textField == currencyConverterView.currencyAmountTextField else { return }
        
        // Todo: Add debouncing
        if
            let selectecdCurrency = currencyConverterView.selectedCurrency,
            selectecdCurrency.isEmpty == false,
            currencyConverterView.enteredAmount > 0 {
            currencyConverterView.exchangeRates(visible: true)
            currencyConverterView.currencyCollectionView.reloadData()
        }
        else {
            currencyConverterView.exchangeRates(visible: false)
        }
    }
}

// MARK: - UIPickerView Delegates

extension ExchangeRatesViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        viewModel.currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        viewModel.currencies[row].code
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currencyConverterView.selectedCurrency = viewModel.currencies[row].code
    }
}

// MARK: - UICollectionView Delegates

extension ExchangeRatesViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.currencies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrencyCollectionViewCell.reuseIdentifier, for: indexPath) as? CurrencyCollectionViewCell else { return UICollectionViewCell() }
        
        let selectedCurrencyIndex = currencyConverterView.currencySelectorPickerView.selectedRow(inComponent: 0)
        
        let selectedCurrency = viewModel.currencies[selectedCurrencyIndex]
        
        let destinationCurrency = viewModel.currencies[indexPath.item]

        let amount = currencyConverterView.enteredAmount
        
        let convertedAmount = currencyConverter.convert(
            from: Currency(
                id: selectedCurrency.id,
                code: selectedCurrency.code,
                baseAmount: selectedCurrency.baseAmount
            ),
            to: Currency(
                id: destinationCurrency.id,
                code: destinationCurrency.code,
                baseAmount: destinationCurrency.baseAmount
            ),
            for: amount
        )
        
        cell.configure(name: destinationCurrency.code, rate: convertedAmount)
        return cell
    }
}
