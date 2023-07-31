//
//  ContactsTableViewCell.swift
//  Shedule
//
//  Created by Parshkova Daria on 15.07.2023.
//

import UIKit
class ContactsTableViewCell : UITableViewCell  {
    let contactImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "person.fill")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = R.Colors.blueForEmail.uiColor
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let phoneImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "phone.fill")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = R.Colors.greenSwitch.uiColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let mailImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "envelope.fill")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = R.Colors.blueForEmail.uiColor
        //imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel = UILabel(text: "Dari Parshkova", font: R.Fonts.aveneirNext(with: 20), alignment: .left)
    let phoneLabel = UILabel(text: "+7-915-198-94-30", font: R.Fonts.aveneirNext(with: 14), alignment: .left)
    let mailLabel = UILabel(text: "neifalen@yandex.ru", font: R.Fonts.aveneirNext(with: 14), alignment: .left)
    
    override func layoutIfNeeded() {
        super.layoutSubviews()
        contactImageView.layer.cornerRadius = contactImageView.frame.height / 2
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none //при нажатии на ячейку не будет выделения
        setConstraints()
        
    }
    func configure(model: ContactModel) {
        nameLabel.text = model.contactsName
        phoneLabel.text = model.contactsPhone
        mailLabel.text = model.contactsMail
        
        guard let data = model.contactsImage, let image = UIImage(data: data) else { return } //если есть какие-то данные то менем изображение
        contactImageView.image = image
       
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setConstraints() {
        self.addSubview(contactImageView)
        NSLayoutConstraint.activate([
            contactImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            contactImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            contactImageView.widthAnchor.constraint(equalToConstant: 70),
            contactImageView.heightAnchor.constraint(equalToConstant: 70)
        ])
        self.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            nameLabel.heightAnchor.constraint(equalToConstant: 21)
        ])
        
        let stackView = UIStackView(arrangedSubviews: [phoneImageView, phoneLabel, mailImageView, mailLabel], axis: .horizontal, spacing: 3, distribution: .fillProportionally)
        self.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            stackView.heightAnchor.constraint(equalToConstant: 21)
        
        ])
    }
}
