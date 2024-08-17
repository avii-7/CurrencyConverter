//
//  ExchangeRatesViewController.swift
//  CurrencyConverter
//
//  Created by Arun on 14/08/24.
//

import UIKit

class ExchangeRatesViewController: UIViewController {
    
    private var currencyConverterView: CurrencyConverterView!
    
    let viewModel: ExchangeRatesViewModel
    
    init(viewModel: ExchangeRatesViewModel) {
        self.viewModel = viewModel
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
        configureCurrencyInputTextField()
        configureCurrencySelectorTextField()
        configCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        currencyConverterView.animate(value: true)
        currencyConverterView.placeholderLabel.isHidden = false
        fetchExchangeRates()
    }
    
    private func fetchExchangeRates() {
        Task { @MainActor in
            do {
                try await viewModel.fetchExchangeRates()
                self.currencyConverterView.animate(value: false)
                self.currencyConverterView.currencyCollectionView.reloadData()
            }
            catch {
                // Todo: show alert
            }
        }
    }
    
    private func configureCurrencyInputTextField() {
        currencyConverterView.currencyInputTextField.delegate = self
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

extension ExchangeRatesViewController : UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        guard
            let text = textField.text,
            let amount = Double(text) else {
            currencyConverterView.placeholderLabel.isHidden = false
            currencyConverterView.currencyCollectionView.isHidden = true
            return
        }
        
        currencyConverterView.placeholderLabel.isHidden = true
        currencyConverterView.currencyCollectionView.isHidden = false
        
        let selectedCurrency = currencyConverterView.currencySelectorTextField.text
        
        if
            
            
            let selectedCurrency {
            
            viewModel.onAmountEntered(amount: amount, currency: selectedCurrency)
            currencyConverterView.currencyCollectionView.reloadData()
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == CurrencyConverterView.currencyInputTextFieldTag {
            textField.text = viewModel.currencies.first?.key
        }
    }
}

extension ExchangeRatesViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        viewModel.supportedCurrencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        viewModel.supportedCurrencies[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currencyConverterView.currencySelectorTextField.text = viewModel.supportedCurrencies[row]
    }
}

extension ExchangeRatesViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.currencies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrencyCollectionViewCell.reuseIdentifier, for: indexPath) as? CurrencyCollectionViewCell else { return UICollectionViewCell() }
        
        // Todo: Optimizaiton needed !
        let key = Array(viewModel.currencies.keys)[indexPath.item]
        
        if let value = viewModel.currencies[key] {
            cell.configure(name: key, rate: value)
        }
        
        return cell
    }
}
