//
//  MainPresenter.swift
//  CoreData-Names
//
//  Created by User on 13.11.2022.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func reloadTable()
}

protocol MainPresenterProtocol: AnyObject {
    func fetchUsers()
    func numberOfRows() -> Int
    func getName(forIndex index: IndexPath) -> String
    func savePerson(withName name: String)
    func deleteTableCell(byIndex index: IndexPath)
    func showDetailedPerson(for index: IndexPath)
}

class MainPresenter: MainPresenterProtocol {

    var persons: [Person]?
    weak var view: MainViewProtocol?
    var router: RouterProtocol?

    required init(view: MainViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }

    func fetchUsers() {
        persons = CoreDataService.shared.fetchUsers()
        view?.reloadTable()
    }

    func numberOfRows() -> Int {
        if let persons = persons {
            return persons.count
        } else {
            return 0
        }
    }

    func getName(forIndex index: IndexPath) -> String {
        return persons?[index.row].name ?? ""
    }

    func savePerson(withName name: String) {
        CoreDataService.shared.savePerson(withName: name)
        fetchUsers()
    }

    func deleteTableCell(byIndex index: IndexPath) {
        guard let person = persons?[index.row] else { return }
        CoreDataService.shared.delete(person: person)
        persons?.remove(at: index.row)
    }

    func showDetailedPerson(for index: IndexPath) {
        guard let person = persons?[index.row] else { return }
        router?.showDetailedPerson(person: person)
    }
}
