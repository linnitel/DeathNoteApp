//
//  PersonCell.swift
//  DeathNoteApp
//
//  Created by Yuliya Martsenko on 25.01.2022.
//

import UIKit

class PersonCell: UITableViewCell {
    
    var name: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    var date: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .right
        return label
    }()

    let stackNameDate: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 16
        stack.alignment = .fill
        stack.distribution = .fill
        stack.layer.borderColor = CGColor(red: 256, green: 0, blue: 0, alpha: 100)
        stack.layer.borderWidth = 1.0

        return stack
    }()

    var howToDie: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    func setupCell(data: PersonModel) {
        name.text = data.name
        date.text = data.date
        howToDie.text = data.howToDie
    }

    private func setupViews() {
        stackNameDate.addArrangedSubview(name)
        stackNameDate.addArrangedSubview(date)
        contentView.addSubview(stackNameDate)
        contentView.addSubview(howToDie)
    }

    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            stackNameDate.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor,
                                               constant: 12),
            stackNameDate.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor,
                                                   constant: 12),
            stackNameDate.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor,
                                                    constant: -12),
            
            howToDie.leadingAnchor.constraint(equalTo: stackNameDate.leadingAnchor),
            howToDie.trailingAnchor.constraint(equalTo: stackNameDate.trailingAnchor),
            howToDie.topAnchor.constraint(equalTo: stackNameDate.bottomAnchor,
                                          constant: 12),
            howToDie.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor,
                                             constant: -12)
            
        ])
    }
    
    override func layoutSubviews() {
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        setupViews()
        setupConstraints()

     }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
