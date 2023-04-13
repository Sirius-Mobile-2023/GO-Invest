//
//  CustomTableViewCell.swift
//  GoInvest
//
//  Created by Мустафа Натур on 12.04.2023.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    private var shortNameLabel = UILabel()
    private var costLabel = UILabel()
    private var differenceCostLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(shortNameLabel)
        addSubview(costLabel)
        addSubview(differenceCostLabel)
        
        configureShortNameLabel()
        configureCostLabel()
        configureDifferenceCostLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureShortNameLabel() {
        shortNameLabel.numberOfLines = 0
        shortNameLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
        
        shortNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shortNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            shortNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            shortNameLabel.widthAnchor.constraint(equalToConstant: self.bounds.width / 2)
        ])
    }
    
    private func configureCostLabel() {
        costLabel.numberOfLines = 0
        costLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
        costLabel.textAlignment = .right

        costLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            costLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            costLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10),
            costLabel.widthAnchor.constraint(equalToConstant: self.bounds.width / 2)
        ])
    }
    
    private func configureDifferenceCostLabel() {
        differenceCostLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 15.0)
        differenceCostLabel.textAlignment = .right

        differenceCostLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            differenceCostLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            differenceCostLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 10),
            differenceCostLabel.widthAnchor.constraint(equalToConstant: self.bounds.width / 2)
        ])
    }
    
    func setData(model: QuoteModel) {
        shortNameLabel.text = model.shortName
        costLabel.text = "$\(model.cost)"
        
        if model.costDifference < 0 {
            differenceCostLabel.text = "\(model.costDifference)%"
            differenceCostLabel.textColor = .red
        } else {
            differenceCostLabel.textColor = UIColor(red: 23/255, green: 143/255, blue: 31/255, alpha: 1)
            differenceCostLabel.text = "+\(model.costDifference)%"
        }
    }

}

