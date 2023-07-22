//
//  ColorSheduleTableViewCell.swift
//  Shedule
//
//  Created by Parshkova Daria on 13.07.2023.
//

import UIKit
class ColorsTableViewCell : UITableViewCell {
    
    let backgroundViewCell : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
        self.selectionStyle = .none //при нажатии на ячейку не будет выделения
        self.backgroundColor = .clear
    }
    //настройки конкертных ячеек
    func cellConfigure(indexPath:IndexPath) {
        switch indexPath.section {
        case 0 : backgroundViewCell.backgroundColor = R.Colors.pink
        case 1 : backgroundViewCell.backgroundColor = R.Colors.yellow
        case 2 : backgroundViewCell.backgroundColor = R.Colors.green
        case 3 : backgroundViewCell.backgroundColor = R.Colors.purple
        case 4 : backgroundViewCell.backgroundColor = R.Colors.orange
        case 5 : backgroundViewCell.backgroundColor = R.Colors.grey
        case 6 : backgroundViewCell.backgroundColor = R.Colors.blue
        default :
            backgroundViewCell.backgroundColor = .white
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setConstraints() {
        self.addSubview(backgroundViewCell)
        NSLayoutConstraint.activate([
            backgroundViewCell.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            backgroundViewCell.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            backgroundViewCell.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            backgroundViewCell.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1)
        ])
        
    }
}

