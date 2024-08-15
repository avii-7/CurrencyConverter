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
        
        let vm = CurrencyViewModel()
        let vc = ViewController(viewModel: vm)

        let navigationController = UINavigationController(rootViewController: vc)
        window?.rootViewController = navigationController
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

