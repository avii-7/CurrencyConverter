//
//  CurrencyConverterView.swift
//  CurrencyConverter
//
//  Created by Arun on 14/08/24.
//

import UIKit

class CurrencyConverterView: UIView {
    
    private let horizontalSpacing: CGFloat = 15
    
    private let verticalSpacing: CGFloat = 20
    
    let currencyAmountTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter an amount"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        textField.textAlignment = .center
        return textField
    }()
    
    let currencySelectorTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Select currency"
        textField.borderStyle = .roundedRect
        textField.tintColor = .clear
        return textField
    }()
    
    let currencySelectorPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    let currencyCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 100, height: 100)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CurrencyCollectionViewCell.self, forCellWithReuseIdentifier: CurrencyCollectionViewCell.reuseIdentifier)
        collectionView.isHidden = true
        return collectionView
    }()
    
    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Enter an amount and choose currency to view exchange rates"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        return label
        
    }()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.tintColor = .lightGray
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    var enteredAmount: Double {
        if
            let amountString = currencyAmountTextField.text,
            let amount = Double(amountString) {
            return amount
        }
        else {
            return 0
        }
    }
    
    var selectedCurrency: String? {
        get { currencySelectorTextField.text }
        set { currencySelectorTextField.text = newValue }
    }
    
    init() {
        super.init(frame: .zero)
        configure()
        addSubviews()
        activateConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configure() {
        backgroundColor = .systemBackground
        configureCurrencySelector()
    }
    
    private func configureCurrencySelector() {
        currencySelectorTextField.inputView = currencySelectorPickerView
        currencySelectorTextField.inputAccessoryView = getToolbarWithDoneButton()
    }

    @objc
    private func donePicker() {
        exchangeRates(visible: enteredAmount > 0)
        currencyCollectionView.reloadData()
        currencySelectorTextField.resignFirstResponder()
    }
    
    func animate(value: Bool) {
        if value {
            activityIndicatorView.isHidden = false
            currencyAmountTextField.isEnabled = false
            currencySelectorTextField.isEnabled = false
            activityIndicatorView.startAnimating()
        }
        else {
            currencyAmountTextField.isEnabled = true
            currencySelectorTextField.isEnabled = true
            activityIndicatorView.stopAnimating()
        }
    }
    
    func exchangeRates(visible: Bool) {
        if visible {
            currencyCollectionView.isHidden = false
            placeholderLabel.isHidden = true
        }
        else {
            currencyCollectionView.isHidden = true
            placeholderLabel.isHidden = false
        }
    }
}

extension CurrencyConverterView {
    
    private func getToolbarWithDoneButton() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: UIBarButtonItem.Style.done,
            target: self,
            action: #selector(donePicker)
        )
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        return toolBar
    }
    
    private func addSubviews() {
        addSubview(currencyAmountTextField)
        addSubview(currencySelectorTextField)
        addSubview(currencyCollectionView)
        addSubview(activityIndicatorView)
        addSubview(placeholderLabel)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            
            // For currency input field
            currencyAmountTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: verticalSpacing),
            currencyAmountTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: horizontalSpacing),
            currencyAmountTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -horizontalSpacing),
            
            // For currency selector button
            currencySelectorTextField.topAnchor.constraint(equalTo: currencyAmountTextField.bottomAnchor, constant: verticalSpacing),
            currencySelectorTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -horizontalSpacing),
            
            // For collection view
            currencyCollectionView.topAnchor.constraint(equalTo: currencySelectorTextField.bottomAnchor, constant: verticalSpacing),
            currencyCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: horizontalSpacing),
            currencyCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -horizontalSpacing),
            currencyCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -verticalSpacing),
            
            // Activity Indicator
            activityIndicatorView.centerXAnchor.constraint(equalTo: currencyCollectionView.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: currencyCollectionView.centerYAnchor),
            
            // Placeholder Label
            placeholderLabel.centerYAnchor.constraint(equalTo: currencyCollectionView.centerYAnchor),
            placeholderLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: horizontalSpacing),
            placeholderLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -horizontalSpacing),
        ])
    }
}
