//
//  SheduleTableViewCell.swift
//  Shedule
//
//  Created by Parshkova Daria on 09.07.2023.
//

import UIKit

class SheduleTableViewCell : UITableViewCell {
    
    let lessonName = UILabel(text: "", font: R.Fonts.aveneirNextDemiBold(with: 20), alignment: .left)
    
    let teacherName = UILabel(text: "", font: R.Fonts.aveneirNextDemiBold(with: 20), alignment: .right)
    let lessonTime = UILabel(text: "", font: R.Fonts.aveneirNextDemiBold(with: 20), alignment: .left)
    let typeLabel = UILabel(text: "Type:", font: R.Fonts.aveneirNext(with: 14), alignment: .right)
    let lessonType = UILabel(text: "", font: R.Fonts.aveneirNextDemiBold(with: 14), alignment: .left)
    let buildingLabel = UILabel(text: "Building body:", font: R.Fonts.aveneirNext(with: 14), alignment: .right)
    let lessonBuilding = UILabel(text: "", font: R.Fonts.aveneirNextDemiBold(with: 14), alignment: .left)
    let audLabel = UILabel(text: "Audience:", font: R.Fonts.aveneirNext(with: 14), alignment: .right)
    let lessonAud = UILabel(text: "", font: R.Fonts.aveneirNextDemiBold(with: 14), alignment: .left)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
        self.selectionStyle = .none //при нажатии на ячейку не будет выделения
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(model: SheduleModel) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        lessonName.text = model.sheduleName
        teacherName.text = model.sheduleTeacher
        lessonTime.text = dateFormatter.string(from: model.sheduleTime)
        lessonType.text = model.sheduleType
        lessonBuilding.text = model.sheduleBuilding
        lessonAud.text = model.sheduleAudience
        backgroundColor = UIColor(hexString: model.sheduleColor)
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
