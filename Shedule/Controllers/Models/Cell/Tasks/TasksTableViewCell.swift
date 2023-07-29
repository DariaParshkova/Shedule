//
//  TasksTableViewCell.swift
//  Shedule
//
//  Created by Parshkova Daria on 10.07.2023.
//

import UIKit
class TasksTableViewCell : UITableViewCell {
    let taskName = UILabel(text: "Программирование", font: R.Fonts.aveneirNext(with: 20),alignment: .left)
    let taskDescription = UILabel(text: "Научиться писать слова lolololo", font: R.Fonts.aveneirNext(with: 14), alignment: .left)
    
    let readyButton : UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "chevron.down.circle"), for: .normal)
        button.tintColor = R.Colors.blueForEmail.uiColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    weak var cellTaskDelegate : PressReadyTaskButtonProtocol?
    var index : IndexPath?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none //при нажатии на ячейку не будет выделения
        
        taskDescription.numberOfLines = 2 //две строки в случае большого текста
        
        setConstraints()
        
        readyButton.addTarget(self, action: #selector(readyButtonTapped), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func readyButtonTapped() {
        guard let index = index else { return }
        cellTaskDelegate?.readyButtonTapped(indexPath: index)
    }
    func configure(model: TaskModel) {
        taskName.text = model.taskName
        taskDescription.text = model.taskDescriptionName
        backgroundColor = UIColor(hexString: model.taskColor)
        
        let image = model.taskReady ? UIImage(systemName: "flag.slash") : UIImage(systemName: "flag.fill")
        readyButton.setBackgroundImage(image, for: .normal)
    }
    
    
    
    
    func setConstraints() {
        self.contentView.addSubview(readyButton)
        NSLayoutConstraint.activate([
            readyButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            readyButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            readyButton.heightAnchor.constraint(equalToConstant: 40),
            readyButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        self.addSubview(taskName)
        NSLayoutConstraint.activate([
            taskName.topAnchor.constraint(equalTo:self.topAnchor, constant: 10),
            taskName.trailingAnchor.constraint(equalTo: readyButton.leadingAnchor, constant: -5),
            taskName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            taskName.heightAnchor.constraint(equalToConstant: 25),
        ])
        self.addSubview(taskDescription)
        NSLayoutConstraint.activate([
            taskDescription.bottomAnchor.constraint(equalTo: taskName.bottomAnchor, constant: 5),
            taskDescription.trailingAnchor.constraint(equalTo: readyButton.leadingAnchor , constant: -5),
            taskDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            taskDescription.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
            
        ])
        
        
    }
}
