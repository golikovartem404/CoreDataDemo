//
//  ViewController.swift
//  CoreData-Names
//
//  Created by User on 13.11.2022.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.setLeftPaddingPoints(10)
        textField.placeholder = "Print your name here"
        textField.backgroundColor = .systemGray5
        textField.layer.cornerRadius = 10
        textField.clipsToBounds = true
        return textField
    }()

    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add name", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(
            self,
            action: #selector(addName),
            for: .touchUpInside
        )
        return button
    }()

    private lazy var table: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "cell"
        )
        table.dataSource = self
        table.delegate = self
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupNavBar()
        setupHierarchy()
        setupLayout()
    }

    private func setupNavBar() {
        title = "Users"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupHierarchy() {
        view.addSubview(textField)
        view.addSubview(button)
        view.addSubview(table)
    }

    private func setupLayout() {

        textField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.height.equalTo(48)
        }

        button.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
            make.height.equalTo(48)
        }

        table.snp.makeConstraints { make in
            make.top.equalTo(button.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalTo(view)
        }
    }

    @objc private func addName() {

    }

}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}
