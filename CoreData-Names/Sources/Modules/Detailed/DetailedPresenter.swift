//
//  DetailedPresenter.swift
//  CoreData-Names
//
//  Created by User on 13.11.2022.
//

import Foundation

protocol DetailedViewProtocol: AnyObject {
    func setupDetailedView(withName name: String, date: Date?, gender: String?, image: Data?)
}

protocol DetailedPresenterProtocol: AnyObject {
    func setData()
    func goToMainView()
    func updateData(withName name: String?, date: Date?, gender: String?, image: Data?)
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

    func setData() {
        let name = person.name ?? ""
        let date = person.dateOfBirth ?? nil
        let gender = person.gender ?? nil
        let image = person.image ?? nil
        self.view?.setupDetailedView(
            withName: name,
            date: date,
            gender: gender,
            image: image
        )
    }

    func updateData(withName name: String?, date: Date?, gender: String?, image: Data?) {
        CoreDataService.shared.updatePerson(
            withName: name ?? "",
            date: date ?? nil,
            gender: gender ?? nil,
            image: image ?? nil
        )
    }

    func goToMainView() {
        router?.popToRoot()
    }
}
