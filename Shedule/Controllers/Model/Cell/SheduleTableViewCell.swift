//
//  SheduleTableViewCell.swift
//  Shedule
//
//  Created by Parshkova Daria on 09.07.2023.
//

import UIKit

class SheduleTableViewCell : UITableViewCell {
    
    let lessonName = UILabel(text: "Математика", font: R.Fonts.aveneirNextDemiBold(with: 20), alignment: .left)
    
    let teacherName = UILabel(text: "Паршкова Дарья Владимировна", font: R.Fonts.aveneirNextDemiBold(with: 20), alignment: .right)
    let lessonTime = UILabel(text: "08:00", font: R.Fonts.aveneirNextDemiBold(with: 20), alignment: .left)
    let typeLabel = UILabel(text: "Тип:", font: R.Fonts.aveneirNext(with: 14), alignment: .right)
    let lessonType = UILabel(text: "лекция", font: R.Fonts.aveneirNextDemiBold(with: 14), alignment: .left)
    let buildingLabel = UILabel(text: "корпус", font: R.Fonts.aveneirNext(with: 14), alignment: .right)
    let lessonBuilding = UILabel(text: "1", font: R.Fonts.aveneirNextDemiBold(with: 14), alignment: .left)
    let audLabel = UILabel(text: "Аудитория:", font: R.Fonts.aveneirNext(with: 14), alignment: .right)
    let lessonAud = UILabel(text: "101", font: R.Fonts.aveneirNextDemiBold(with: 14), alignment: .left)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setConstraints() {
        let topStackView = UIStackView(arrangedSubviews: [lessonName, teacherName], axis: .horizontal, spacing: 10, distribution: .fillEqually)
        self.addSubview(topStackView)
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            topStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            topStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            topStackView.heightAnchor.constraint(equalToConstant: 25)
        ])
        self.addSubview(lessonTime)
        NSLayoutConstraint.activate([
            lessonTime.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            lessonTime.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            //lessonTime.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 15),
            lessonTime.widthAnchor.constraint(equalToConstant: 100),
            lessonTime.heightAnchor.constraint(equalToConstant: 25)
        ])
        let bottomStackView = UIStackView(arrangedSubviews: [typeLabel, lessonType, buildingLabel, lessonBuilding,audLabel, lessonAud ]
                                          , axis: .horizontal, spacing: 5, distribution: .fillProportionally)
        self.addSubview(bottomStackView)
        NSLayoutConstraint.activate([
            bottomStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            bottomStackView.leadingAnchor.constraint(equalTo: lessonTime.trailingAnchor, constant: 5),
            bottomStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            bottomStackView.heightAnchor.constraint(equalToConstant: 25)
        ])
        
    }
}
