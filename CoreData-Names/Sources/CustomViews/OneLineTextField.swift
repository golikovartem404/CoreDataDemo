//
//  OneLineTextField.swift
//  CoreData-Names
//
//  Created by User on 13.11.2022.
//

import UIKit

class OneLineTextField: UITextField {

    convenience init(placeholder: String) {
        self.init()
        self.placeholder = placeholder
        self.borderStyle = .none
        self.textColor = .black
        self.tintColor = .black
        self.returnKeyType = .done
        self.isEnabled = false

        let bottomView = UIView()
        bottomView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        bottomView.backgroundColor = .systemGray4
        self.addSubview(bottomView)

        bottomView.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.bottom.equalTo(self.snp.bottom)
            make.height.equalTo(1)
        }
    }
}