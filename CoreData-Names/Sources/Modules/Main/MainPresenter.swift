//
//  MainPresenter.swift
//  CoreData-Names
//
//  Created by User on 13.11.2022.
//

import Foundation

protocol MainViewProtocol: AnyObject {

}

protocol MainPresenterProtocol: AnyObject {

}

class MainPresenter: MainPresenterProtocol {

    weak var view: MainViewProtocol?
    var router: RouterProtocol?

    required init(view: MainViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
}
