//
//  Router.swift
//  CoreData-Names
//
//  Created by User on 13.11.2022.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: BuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showDetailedPerson(person: Person)
    func popToRoot()
}

class Router: RouterProtocol {

    var navigationController: UINavigationController?
    var assemblyBuilder: BuilderProtocol?

    init(navigationController: UINavigationController, assemblyBuilder: BuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }

    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = assemblyBuilder?.createMainModule(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }

    func showDetailedPerson(person: Person) {
        if let navigationController = navigationController {
            guard let detailedViewController = assemblyBuilder?.createDetailedModule(person: person, router: self) else { return }
            navigationController.pushViewController(detailedViewController, animated: true)
        }
    }

    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
