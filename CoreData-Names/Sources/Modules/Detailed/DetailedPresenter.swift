//
//  DetailedPresenter.swift
//  CoreData-Names
//
//  Created by User on 13.11.2022.
//

import Foundation

protocol DetailedViewProtocol: AnyObject {
    
}

protocol DetailedPresenterProtocol: AnyObject {

}

class DetailedPresenter: DetailedPresenterProtocol {

    var person: Person
    weak var view: DetailedViewProtocol?
    var router: RouterProtocol?

    required init(view: DetailedViewProtocol, person: Person, router: RouterProtocol) {
        self.view = view
        self.router = router
        self.person = person
    }
}
