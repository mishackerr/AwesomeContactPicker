//
//  Bundle+ACPHelper.swift
//  AwesomeContactPicker
//
//  Created by Michael Guo on 7/21/19.
//

import Foundation

class ResourceHelper {
    static func resourceBundle() -> Bundle {
        let frameworkBundle = Bundle(for: AwesomeContactPicker.self)
        let resourceURL = frameworkBundle.url(forResource: "AwesomeContactPicker", withExtension: "bundle")
        return Bundle(url: resourceURL!)!
    }
    
    static func contactStoryBoard() -> UIStoryboard {
        return UIStoryboard(name: "Contact", bundle: self.resourceBundle())
    }
    
    static func contactNib() -> UINib {
        return UINib(nibName: "ContactTableViewCell", bundle: self.resourceBundle())
    }
    
    static func image(named name: String) -> UIImage? {
        return UIImage(named: name, in: self.resourceBundle(), compatibleWith: nil)
    }

}
