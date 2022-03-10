//
//  AddItemViewController.swift
//  DeathNoteApp
//
//  Created by Yuliya Martsenko on 25.01.2022.
//

import UIKit

class AddItemViewController: UIViewController {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name:"
        label.backgroundColor = .black
        label.textColor = .white
        return label
    }()
    
    let name: UITextField = {
        let view  = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1.0
        view.layer.borderColor = CGColor.init(red: 256, green: 0, blue: 0, alpha: 100)
        view.layer.cornerRadius = 8.0
        view.backgroundColor = .black
        view.textColor = .white
        view.placeholder = "Fill who will die"
        return view
    }()
    
    let date: UIDatePicker = {
        let date  = UIDatePicker()
        date.translatesAutoresizingMaskIntoConstraints = false
        date.backgroundColor = .red
        date.tintColor = .white
        date.minimumDate = Date(timeIntervalSinceNow: 0)
        return date
    }()
    
    let dateStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 16
        stack.alignment = .fill
        stack.distribution = .fill

        return stack
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 16
        stack.alignment = .fill
        stack.distribution = .fill

        return stack
    }()
    
    lazy var descriptionOfDeath: UITextView = {
        let view  = UITextView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = CGColor.init(red: 256, green: 0, blue: 0, alpha: 100)
        view.layer.cornerRadius = 8.0
        view.layer.borderWidth = 1.0
        view.backgroundColor = UIColor.black
        view.textColor = .lightGray
        view.text = "How he will die?"
        return view
    }()
    
    var delegate: AddItemDelegate?
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isTranslucent = false
        title = "Add a Person"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(action))
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    private func printPersonData(person: PersonModel) {
        print("The name of the victim is: \(person.name)")
        print("It will die on: \(person.date)")
        print("by \(person.howToDie)")
    }
    
    private func setPersonData(text: String?, date: String, cause: String?) -> PersonModel? {
        guard let name = text,
           !name.isEmpty else {
            return nil
        }
        let descriptionEmpty = cause?.isEmpty ?? true
        let cause = descriptionEmpty ? nil : cause
        let person = PersonModel(name: name, date: date, howToDie: cause)
        return person
    }
    
    private func formatDate(from date: UIDatePicker) -> String {
        let format = DateFormatter()
        format.dateFormat = "dd.MM.yyyy HH:mm"
        return format.string(from: date.date)
    }
    
    @objc func action(sender: UIBarButtonItem) {
        
        defer {
            navigationController?.popViewController(animated: true)
        }
        let dateString = formatDate(from: date)
        guard let person = setPersonData(text: name.text,
                                         date: dateString,
                                         cause: descriptionOfDeath.text) else {
            return
        }
        
        printPersonData(person: person)
        
        delegate?.addItem(from: person)
    }
    
    private func setupView() {
        view.backgroundColor = .black
        view.addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(name)
        view.addSubview(dateStackView)
        view.addSubview(date)
        view.addSubview(descriptionOfDeath)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                               constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                constant: -32),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                           constant: 32),

            name.widthAnchor.constraint(equalToConstant: view.frame.width / 2),

            date.leadingAnchor.constraint(lessThanOrEqualTo: stackView.leadingAnchor),
            date.trailingAnchor.constraint(lessThanOrEqualTo: stackView.trailingAnchor),
            date.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            date.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 12),
            date.heightAnchor.constraint(equalToConstant: 50),

            descriptionOfDeath.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            descriptionOfDeath.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            descriptionOfDeath.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 12),
            descriptionOfDeath.heightAnchor.constraint(equalToConstant: 300)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupNavigationBar()
        setupView()
        setupConstraints()
    }

}

extension AddItemViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing (_ textView: UITextView) {
            if descriptionOfDeath.text.isEmpty || descriptionOfDeath.text == "How he will die?" {
                descriptionOfDeath.text = nil
                descriptionOfDeath.textColor = .white
            }
        }
        func textViewDidEndEditing (_ textView: UITextView) {
            if descriptionOfDeath.text.isEmpty {
                descriptionOfDeath.textColor = UIColor.lightGray
                descriptionOfDeath.text =  "How he will die?"
            }
        }
}
