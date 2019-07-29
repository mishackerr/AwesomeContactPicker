//
//  AwesomeContactSettings.swift
//  AwesomeContactPicker
//
//  Created by Michael Guo on 7/24/19.
//

open class AwesomeContactSettings {
    // Pre selected contacts
    public static var preSelectedContacts: Set<String> = []
    
    // Nav bar
    public static var navBarBarTintColor: UIColor = .white
    public static var navBarTintColor: UIColor = .black
    public static var navBarTitleTextAttributes: [NSAttributedStringKey : Any] = [NSAttributedStringKey.foregroundColor: UIColor.black,
                                                                                  NSAttributedStringKey.font: UIFont.systemFont(ofSize: 27.0)]
    
    // Table view
    public static var sectionIndexHidden = false
    public static var sectionIndexColor: UIColor = .black
}
