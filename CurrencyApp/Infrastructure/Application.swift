//
//  Application.swift
//  CurrencyApp
//
//  Created by Aitor Pagán on 16/1/19.
//  Copyright © 2019 polenoso. All rights reserved.
//

import Foundation
import UIKit

final class Application: NSObject {
    
    static let shared: Application = Application()
    
    private override init() {}
    
    func configure(_ window: UIWindow) {
        
        let mainvc = MainViewController()
        let nc = UINavigationController(rootViewController: mainvc)
        window.rootViewController = nc
        window.makeKeyAndVisible()
    }
}
