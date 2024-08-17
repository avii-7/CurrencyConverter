//
//  SceneDelegate.swift
//  CurrencyConverter
//
//  Created by Arun on 14/08/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        configureWindow()
    }
    
    private func configureWindow() {
        let navigationController = UINavigationController(rootViewController: makeRootViewController())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    private func makeRootViewController() -> UIViewController {
        ExchangeRatesFactory.makeModule()
    }
}

