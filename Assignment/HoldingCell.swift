//
//  HoldingCell.swift
//  Assignment
//
//  Created by Sapna Fulwani on 18/11/24.
//

import UIKit

class HoldingCell: UITableViewCell {
    private let stockNameLabel = UILabel()
    private let quantityLabel = UILabel()
    private let ltpLabel = UILabel()
    private let pnlLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        stockNameLabel.font = .systemFont(ofSize: 16)
        stockNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stockNameLabel)
        
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(quantityLabel)
        
        ltpLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(ltpLabel)
        
        pnlLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(pnlLabel)
        
        NSLayoutConstraint.activate([
            stockNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stockNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            
            quantityLabel.leadingAnchor.constraint(equalTo: stockNameLabel.leadingAnchor),
            quantityLabel.topAnchor.constraint(equalTo: stockNameLabel.bottomAnchor, constant: 20),
            quantityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            ltpLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            ltpLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            
            pnlLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            pnlLabel.topAnchor.constraint(equalTo: ltpLabel.bottomAnchor, constant: 6),
            pnlLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
    
    func configure(with holding: Holding, pnl: Double) {
        stockNameLabel.text = holding.symbol
        
        let quantityText = "NET QTY: "
        let quantityVal = "\(holding.quantity)"
        let quantityPrefixAtt: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 10),
            .foregroundColor: UIColor.darkGray
        ]
        let quantityValAtt: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 13),
            .foregroundColor: UIColor.black
        ]
        let quantityAttString = NSMutableAttributedString(string: quantityText, attributes: quantityPrefixAtt)
        quantityAttString.append(NSAttributedString(string: quantityVal, attributes: quantityValAtt))
        quantityLabel.attributedText = quantityAttString
        
        let ltpText = "LTP: "
        let ltpVal = "₹\(holding.ltp)"
        let ltpPrefixAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 10),
            .foregroundColor: UIColor.darkGray
        ]
        let ltpValueAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 13),
            .foregroundColor: UIColor.black
        ]
        let ltpAttributedString = NSMutableAttributedString(string: ltpText, attributes: ltpPrefixAttributes)
        ltpAttributedString.append(NSAttributedString(string: ltpVal, attributes: ltpValueAttributes))
        
        ltpLabel.attributedText = ltpAttributedString
        
        
        let pnlText = "P&L: "
        let pnlVal = String(format: " ₹%.2f", pnl)
        let pnlPrefixAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 10),
            .foregroundColor: UIColor.darkGray
        ]
        let pnlValueAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 13),
            .foregroundColor: pnl >= 0 ? UIColor.systemGreen : UIColor.red
        ]
        let pnlAttributedString = NSMutableAttributedString(string: pnlText, attributes: pnlPrefixAttributes)
        pnlAttributedString.append(NSAttributedString(string: pnlVal, attributes: pnlValueAttributes))
        
        pnlLabel.attributedText = pnlAttributedString
    }
}
