//
//  HeaderOptionSheduleTableViewCell.swift
//  Shedule
//
//  Created by Parshkova Daria on 11.07.2023.
//

import UIKit
class HeaderOptionsTableViewCell : UITableViewHeaderFooterView {
    
    let headerLabel = UILabel(text: "", font: R.Fonts.aveneirNext(with: 14), alignment: .left)
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        headerLabel.textColor = .gray
        self.contentView.backgroundColor = .none
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func headerConfigure(nameArray: [String], section: Int) {
        headerLabel.text = nameArray[section]
    }
    
    func setConstraints() {
        self.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            headerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
        
    }
}

