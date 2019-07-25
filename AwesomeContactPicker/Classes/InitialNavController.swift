//
//  InitialNavController.swift
//  AwesomeContactPicker
//
//  Created by Michael Guo on 7/21/19.
//

import UIKit

class InitialNavController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.barTintColor = AwesomeContactSettings.navBarBarTintColor
        navigationBar.tintColor = AwesomeContactSettings.navBarTintColor
        navigationBar.titleTextAttributes = AwesomeContactSettings.navBarTitleTextAttributes
    }

}
