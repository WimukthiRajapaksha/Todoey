//
//  AppDelegate.swift
//  todoey
//
//  Created by Wimukthi Rajapaksha on 1/8/18.
//  Copyright © 2018 Wimu. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
//
//        let data = Data()
//        data.name="wimukthi"
//        data.age=20
        do{
            _=try Realm()
//            try realm.write {
//                realm.add(data)
//            }
        }catch{
            print("Error initializing new realm \(error)")
        }
        return true
    }
}
