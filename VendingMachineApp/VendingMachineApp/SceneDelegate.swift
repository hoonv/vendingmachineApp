//
//  SceneDelegate.swift
//  VendingMachineApp
//
//  Created by 채훈기 on 2020/09/14.
//  Copyright © 2020 채훈기. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var vendingMachine: VendingMachine!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        let defaults = UserDefaults.standard
        if let vm = defaults.object(forKey: "vending") as? Data {
            let decoder = JSONDecoder()
            if let vending = try? decoder.decode(VendingMachine.self, from: vm) {
                vendingMachine = vending
            }
        }else {
            vendingMachine = VendingMachine()
        }

        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneWillResignActive(_ scene: UIScene) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(vendingMachine) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "vending")
        }
    }
}

