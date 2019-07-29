//
//  ViewController.swift
//  AwesomeContactPicker
//
//  Created by xygmeetouts on 07/20/2019.
//  Copyright (c) 2019 xygmeetouts. All rights reserved.
//

import UIKit
import AwesomeContactPicker

class ViewController: UIViewController {

    @IBAction func didTapOpenContactsButton(_ sender: UIButton) {
        AwesomeContactPicker.shared.openContacts(with: self, delegate: self)
    }
    
}

extension ViewController: AwesomeContactPickerProtocol {
    func didDismiss(with type: AwesomeContactPicker.DismissType, contacts: Set<String>?) {
        switch type {
        case .done:
            print(contacts!)
        default:
            break
        }
    }
}

