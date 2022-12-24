//
//  DetailedViewController.swift
//  CoreData-Names
//
//  Created by User on 13.11.2022.
//

import UIKit

class DetailedViewController: UIViewController {

    // MARK: - Properties

    var presenter: DetailedPresenterProtocol?
    let datePicker = UIDatePicker()
    let dateFormatter = DateFormatter()
    var isEnabled = false
    let genders = ["Male", "Female", "Other"]

    // MARK: - Outlets

    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: Constants.Strings.Images.backButton), for: .normal)
        button.tintColor = .black
        button.addTarget(
            self,
            action: #selector(goBack),
            for: .touchUpInside
        )
        return button
    }()

    private lazy var editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Constants.Strings.Buttons.editButton, for: .normal)
        button.setTitleColor(UIColor.systemGray, for: .normal)
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 7
        button.clipsToBounds = true
        button.addTarget(
            self,
            action: #selector(editButtonPressed),
            for: .touchUpInside
        )
        return button
    }()

    private lazy var buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        return stack
    }()

    private lazy var photoButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.contentMode = .scaleAspectFill
        button.addTarget(
            self,
            action: #selector(chooseImage),
            for: .touchUpInside
        )
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 0.3
        button.layer.cornerRadius = 70
        button.clipsToBounds = true
        return button
    }()

    private lazy var nameTextField: OneLineTextField = {
        let textField = OneLineTextField(placeholder: Constants.Strings.TextFieldPlaceholders.nameTextField)
        if let image = UIImage(systemName: Constants.Strings.Images.name) {
            textField.setLeftIcon(image)
        }
        return textField
    }()

    private lazy var dateTextField: OneLineTextField = {
        let textField = OneLineTextField(placeholder: Constants.Strings.TextFieldPlaceholders.dateTextField)
        if let image = UIImage(systemName: Constants.Strings.Images.dateOfBirth) {
            textField.setLeftIcon(image)
        }
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: nil,
            action: #selector(donePressed)
        )
        toolbar.setItems([doneButton], animated: true)
        textField.inputAccessoryView = toolbar
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.maximumDate = Date()
        datePicker.datePickerMode = .date
        textField.inputView = datePicker
        return textField
    }()

    private lazy var genderTextField: OneLineTextField = {
        let textField = OneLineTextField(placeholder: Constants.Strings.TextFieldPlaceholders.genderTextField)
        if let image = UIImage(systemName: Constants.Strings.Images.gender) {
            textField.setLeftIcon(image)
        }
        let genderPicker = UIPickerView()
        genderPicker.delegate = self
        genderPicker.dataSource = self
        textField.inputView = genderPicker
        return textField
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
        setupInterface()
        presenter?.setData()
    }

    // MARK: - Setups

    private func setupView() {
        view.backgroundColor = .white
        self.navigationItem.hidesBackButton = true
    }

    private func setupHierarchy() {
        view.addSubview(buttonStack)
        buttonStack.addArrangedSubview(backButton)
        buttonStack.addArrangedSubview(editButton)
        view.addSubview(photoButton)
        view.addSubview(nameTextField)
        view.addSubview(dateTextField)
        view.addSubview(genderTextField)
    }

    private func setupLayout() {

        buttonStack.snp.makeConstraints { make in
            make.centerY.equalTo(view).multipliedBy(Constants.Constraints.DetailedView.buttonStackCenterY)
            make.centerX.equalTo(view)
            make.width.equalTo(view.snp.width).multipliedBy(Constants.Constraints.DetailedView.buttonStackWidth)
        }

        editButton.snp.makeConstraints { make in
            make.width.equalTo(Constants.Constraints.DetailedView.editButtonWidth)
        }

        photoButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view.snp.centerY).multipliedBy(Constants.Constraints.DetailedView.photoButtonCenterY)
            make.width.height.equalTo(Constants.Constraints.DetailedView.photoButtonWidthHeight)
        }

        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(photoButton.snp.bottom).offset(Constants.Constraints.DetailedView.nameTextFieldTop)
            make.centerX.equalTo(view)
            make.width.equalTo(view.snp.width).multipliedBy(Constants.Constraints.DetailedView.textFieldsWidth)
            make.height.equalTo(Constants.Constraints.DetailedView.textFieldsHeight)
        }

        dateTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(Constants.Constraints.DetailedView.dateTextFieldTop)
            make.centerX.equalTo(view)
            make.width.equalTo(view.snp.width).multipliedBy(Constants.Constraints.DetailedView.textFieldsWidth)
            make.height.equalTo(Constants.Constraints.DetailedView.textFieldsHeight)
        }

        genderTextField.snp.makeConstraints { make in
            make.top.equalTo(dateTextField.snp.bottom).offset(Constants.Constraints.DetailedView.genderTextFieldTop)
            make.centerX.equalTo(view)
            make.width.equalTo(view.snp.width).multipliedBy(Constants.Constraints.DetailedView.textFieldsWidth)
            make.height.equalTo(Constants.Constraints.DetailedView.textFieldsHeight)
        }
    }

    func setupInterface() {
        if isEnabled {
            nameTextField.isEnabled = true
            dateTextField.isEnabled = true
            genderTextField.isEnabled = true
            photoButton.isEnabled = true
            editButton.setTitle(Constants.Strings.Buttons.saveButton, for: .normal)
        } else {
            nameTextField.isEnabled = false
            dateTextField.isEnabled = false
            genderTextField.isEnabled = false
            photoButton.isEnabled = false
            editButton.setTitle(Constants.Strings.Buttons.editButton, for: .normal)
        }
    }

    // MARK: - Button actions

    @objc private func donePressed() {
        dateFormatter.dateFormat = Constants.Strings.DateFormatter.dateFormat
        dateTextField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }

    @objc private func goBack() {
        dateFormatter.dateFormat = Constants.Strings.DateFormatter.dateFormat
        let date = dateFormatter.date(from: dateTextField.text ?? "")
        presenter?.updateData(
            withName: nameTextField.text,
            date: date,
            gender: genderTextField.text,
            image: photoButton.imageView?.image?.pngData()
        )
        presenter?.goToMainView()
    }

    @objc private func editButtonPressed() {
        isEnabled.toggle()
        setupInterface()
        if !isEnabled {
            dateFormatter.dateFormat = Constants.Strings.DateFormatter.dateFormat
            let date = dateFormatter.date(from: dateTextField.text ?? "")
            presenter?.updateData(
                withName: nameTextField.text,
                date: date,
                gender: genderTextField.text,
                image: photoButton.imageView?.image?.pngData()
            )
        }
    }

    @objc private func chooseImage() {
        let viewController = UIImagePickerController()
        viewController.sourceType = .photoLibrary
        viewController.allowsEditing = true
        viewController.delegate = self
        present(viewController, animated: true)
    }
}

// MARK: - PickerView Extension

extension DetailedViewController: UIPickerViewDataSource, UIPickerViewDelegate {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genders.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genders[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderTextField.text = genders[row]
        genderTextField.resignFirstResponder()
    }
}

// MARK: - ImagePickerView Extension

extension DetailedViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            photoButton.setImage(image, for: .normal)
        }
        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

// MARK: - DetailedViewProtocol Extension

extension DetailedViewController: DetailedViewProtocol {
    func setupDetailedView(withName name: String, date: Date?, gender: String?, image: Data?) {
        self.nameTextField.text = name
        self.genderTextField.text = gender
        dateFormatter.dateFormat = Constants.Strings.DateFormatter.dateFormat
        if let date = date {
            self.dateTextField.text = dateFormatter.string(from: date)
        }
        if let image = image {
            self.photoButton.setImage(UIImage(data: image), for: .normal)
        }
    }
}

