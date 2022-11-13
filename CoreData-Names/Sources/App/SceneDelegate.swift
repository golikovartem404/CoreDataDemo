//
//  SceneDelegate.swift
//  CoreData-Names
//
//  Created by User on 13.11.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let navVC = UINavigationController(rootViewController: MainViewController())
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
}

