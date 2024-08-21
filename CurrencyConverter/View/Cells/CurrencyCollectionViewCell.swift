//
//  CurrencyCollectionViewCell.swift
//  CurrencyConverter
//
//  Created by Arun on 14/08/24.
//

import UIKit

class CurrencyCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "CurrencyCollectionViewCell"
    
    private let horizontalSpacing: CGFloat = 10
    
    private let verticalSpacing: CGFloat = 15
    
    private let currecyNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()
    
    private let currecyRateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .footnote)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .lightGray
        addSubviews()
        activateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(name: String, rate: Decimal) {
        currecyNameLabel.text = name
        currecyRateLabel.text = "\(rate)"
    }
}

extension CurrencyCollectionViewCell {
    
    private func addSubviews() {
        addSubview(currecyNameLabel)
        addSubview(currecyRateLabel)
    }
    
    private func activateConstraints() {
        
        NSLayoutConstraint.activate([
            // For currency symbol code
            currecyNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: verticalSpacing),
            currecyNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: horizontalSpacing),
            currecyNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -horizontalSpacing),
            
            // For currency rate
            currecyRateLabel.topAnchor.constraint(equalTo: currecyNameLabel.bottomAnchor, constant: verticalSpacing),
            currecyRateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: horizontalSpacing),
            currecyRateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -horizontalSpacing),
            currecyRateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -horizontalSpacing),
            
        ])
    }
}

