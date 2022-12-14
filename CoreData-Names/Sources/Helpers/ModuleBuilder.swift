//
//  ModuleBuilder.swift
//  CoreData-Names
//
//  Created by User on 13.11.2022.
//

import UIKit

protocol BuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createDetailedModule(person: Person, router: RouterProtocol) -> UIViewController
}

class ModuleBuilder: BuilderProtocol {

    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let presenter = MainPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }

    func createDetailedModule(person: Person, router: RouterProtocol) -> UIViewController {
        let person = person
        let view = DetailedViewController()
        let presenter = DetailedPresenter(view: view, person: person, router: router)
        view.presenter = presenter
        return view
    }
}
