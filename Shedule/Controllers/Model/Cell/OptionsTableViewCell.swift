//
//  OptionsSheduleTableViewCell.swift
//  Shedule
//
//  Created by Parshkova Daria on 10.07.2023.
//
import UIKit
class OptionsTableViewCell : UITableViewCell {
    
    let backgroundViewCell : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = R.Colors.blueForEmail
        return imageView
    }()
    
    let nameCellLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let repeatSwitch : UISwitch = {
        let repeatSwitch = UISwitch()
        repeatSwitch.isOn = true
        repeatSwitch.isHidden = true
        repeatSwitch.onTintColor = R.Colors.greenSwitch
        repeatSwitch.translatesAutoresizingMaskIntoConstraints = false
        return repeatSwitch
    }()
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
        self.selectionStyle = .none //при нажатии на ячейку не будет выделения
        self.backgroundColor = .clear
        repeatSwitch.addTarget(self, action: #selector(switchChange(paramTarget:)), for: .valueChanged)
    }
    //настройки конкертных ячеек
    func cellSheduleConfigure(nameArray:[[String]], indexPath: IndexPath) {
        nameCellLabel.text = nameArray[indexPath.section][indexPath.row] //по каждой секции нашего массива cellNameArray разбиваем по ячейкам
        if indexPath == [3,0] {
            backgroundViewCell.backgroundColor = R.Colors.yellow
        }
        if indexPath == [4,0] {
            repeatSwitch.isHidden = false
        }
    }
    func cellTasksConfigure(nameArray:[String], indexPath: IndexPath) {
        nameCellLabel.text = nameArray[indexPath.section]
        if indexPath == [3,0] {
            backgroundViewCell.backgroundColor = R.Colors.yellow
        }
    }
    func cellContactConfigure(nameArray:[String], indexPath: IndexPath) {
        nameCellLabel.text = nameArray[indexPath.section]
        indexPath.section == 4 ? backgroundViewCell.image = UIImage(systemName: "person.badge.plus")?.withRenderingMode(.alwaysTemplate) : nil
    }
    
    
    @objc func switchChange(paramTarget: UISwitch) {
        if paramTarget.isOn {
            print("ON")
        } else {
            print("Off")
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
        self.addSubview(nameCellLabel)
        NSLayoutConstraint.activate([
            nameCellLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameCellLabel.leadingAnchor.constraint(equalTo: backgroundViewCell.leadingAnchor, constant: 15)
        ])
        
        self.contentView.addSubview(repeatSwitch)
        NSLayoutConstraint.activate([
            repeatSwitch.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            repeatSwitch.trailingAnchor.constraint(equalTo: backgroundViewCell.trailingAnchor, constant: -20)
        ])
        /*
        self.contentView.addSubview(addImageContact)
        NSLayoutConstraint.activate([
            addImageContact.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            addImageContact.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            addImageContact.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            addImageContact.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])*/
        
        
        
    }
}
