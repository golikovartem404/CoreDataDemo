//
//  Constants.swift
//  CoreData-Names
//
//  Created by User on 13.11.2022.
//

import UIKit

enum Constants {

    enum Strings {
        enum CoreData {
            static let entity = "Person"
            static let entityGettingError = "Error while getting entity"
            static let predicateFormat = "name == %@"
            static let nameKey = "name"
            static let dateOfBirthKey = "dateOfBirth"
            static let genderKey = "gender"
            static let imageKey = "image"
        }

        enum DateFormatter {
            static let dateFormat = "dd.MM.yyyy"
        }

        enum TextFieldPlaceholders {
            static let mainTextField = "Print your name here"
            static let nameTextField = "Name"
            static let dateTextField = "Date"
            static let genderTextField = "Gender"
        }

        enum Buttons {
            static let addNameButton = "Add name"
            static let editButton = "Edit"
            static let saveButton = "Save"
        }

        enum Images {
            static let backButton = "arrow.backward"
            static let name = "person"
            static let dateOfBirth = "calendar"
            static let gender = "person.2.circle"
        }

        enum CellsIdentifiers {
            static let cell = "cell"
        }
    }

    enum Constraints {
        enum OneLineTextField {
            static let frameX = 0
            static let frameY = 0
            static let frameWidth = 0
            static let frameHeight = 0
            static let bottomViewHeight = 1
        }

        enum DetailedView {
            static let buttonStackCenterY = 0.35
            static let buttonStackWidth = 0.9
            static let editButtonWidth = 80
            static let photoButtonCenterY = 0.7
            static let photoButtonWidthHeight = 140
            static let textFieldsWidth = 0.9
            static let textFieldsHeight = 48
            static let nameTextFieldTop = 100
            static let dateTextFieldTop = 30
            static let genderTextFieldTop = 30
        }

        enum MainView {
            static let textFieldWidth = 0.9
            static let textFieldHeight = 48
            static let buttonTop = 20
            static let buttonWidth = 0.9
            static let buttonHeight = 48
            static let tableTop = 15
        }
    }
}
