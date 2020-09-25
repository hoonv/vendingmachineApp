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
        guard let load = defaults.object(forKey: "vending") as? Data
        else {
            vendingMachine = VendingMachine()
            return
        }
        do {
            let loadedMachine = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(load) as? VendingMachine
            vendingMachine = loadedMachine
        } catch {
            vendingMachine = VendingMachine()
        }
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneWillResignActive(_ scene: UIScene) {
        let defaults = UserDefaults.standard
        defaults.set(NSKeyedArchiver.archivedData(withRootObject: vendingMachine), forKey: "vending")
    }
}

