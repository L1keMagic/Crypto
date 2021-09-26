//
//  ChosenCryptoTableViewCell.swift
//  Crypto
//
//  Created by Артур Карачев on 25.09.2021.
//

import UIKit

struct ChosenCryptoTableViewCellModel {
    let title: String
    let value: String
}

class ChosenCryptoTableViewCell: UITableViewCell {

    static let identifier = "ChosenTableViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(valueLabel)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.sizeToFit()
        valueLabel.sizeToFit()
        
        label.frame = CGRect(x: 15, y: 0, width: label.frame.size.width, height: contentView.frame.size.height)
        valueLabel.frame = CGRect(x: contentView.frame.size.width - 15 - valueLabel.frame.size.width, y: 0, width: valueLabel.frame.size.width, height: contentView.frame.size.height)
    }
    
    func configure(with viewModel: ChosenCryptoTableViewCellModel) {
        label.text = viewModel.title
        valueLabel.text = viewModel.value
    }

}
