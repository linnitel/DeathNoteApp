//
//  DeathListViewController.swift
//  DeathNoteApp
//
//  Created by Yuliya Martsenko on 18.01.2022.
//

import UIKit

class DeathListViewController: UIViewController {
    
    static let cellId = "PersonCell"

    var data: [PersonModel] = [PersonModel(name: "John Snow", date: "12.11.2021 9:50", howToDie: "Killed by frost"), PersonModel(name: "Anakin Skywalker", date: "23.07.2014 7:30", howToDie: "Fall in reactor"), PersonModel(name: "Severus Snape Snape Snape Snape", date: "9.09.2001 15:40", howToDie: "Bitten by snake to death several times severly and hard with letal consiquenses out of range of living and strength with blood in his neck and tears")]
    
    private var table: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor.black
        table.allowsSelection = false
        table.register(PersonCell.self, forCellReuseIdentifier: "PersonCell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.isTranslucent = false
        title = "Death List"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .done, target: self, action: #selector(action))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
    }
    
    @objc func action(sender: UIBarButtonItem) {
        let addItem = AddItemViewController()
        addItem.delegate = self
        navigationController?.pushViewController(addItem, animated: true)
    }
    
    private func setupView() {
        table.dataSource = self
        table.delegate = self
        view.addSubview(table)
    }
    
    private func setupConstraints() {
//        table.frame = view.bounds
        NSLayoutConstraint.activate([
            table.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    override func viewDidLayoutSubviews() {
//        table.layoutIfNeeded()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
        setupConstraints()
    }

}

extension DeathListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath) as? PersonCell else {
            return UITableViewCell()
        }
//        let currentData = data[indexPath.row]
        cell.name.text = data[indexPath.row].name
        cell.date.text = data[indexPath.row].date
        cell.howToDie.text = data[indexPath.row].howToDie
//        cell.setupCell(data: currentData)
//        cell.setupConstraints()
        return cell
    }
    
}

extension DeathListViewController: UITableViewDelegate {}

extension DeathListViewController: AddItemDelegate {
    
    func addItem(from model: PersonModel) {
        data.append(model)
        table.reloadData()
    }
    
}
