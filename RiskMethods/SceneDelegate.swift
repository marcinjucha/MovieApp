//
//  SceneDelegate.swift
//  RiskMethods
//
//  Created by jucham01 on 16/05/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: scene)
        window?.rootViewController = UINavigationController(
            rootViewController: ContainerViewController(
                model: .init(serviceProvider: .init())
            )
        )
        window?.makeKeyAndVisible()
    }
}

