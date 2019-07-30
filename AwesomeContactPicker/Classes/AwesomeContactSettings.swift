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
    public static var title: String = "Contacts"
    public static var navBarBarTintColor: UIColor = .white
    public static var navBarTintColor: UIColor = .black
    public static var navBarTitleTextAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor: UIColor.black,
                                                                                  NSAttributedString.Key.font: UIFont.systemFont(ofSize: 27.0)]
    
    // Search
    public static var searchTextFieldPlaceHolderText: String = "Search contacts"
    public static var searchTextFieldFont: UIFont = .systemFont(ofSize: 16)
    public static var searchTextFieldTextColor: UIColor = .black
    
    // Table view
    public static var sectionIndexHidden = false
    public static var sectionIndexColor: UIColor = .black
    public static var nameLabelFont: UIFont = .systemFont(ofSize: 13)
    public static var nameLabelTextColor: UIColor = .black
}
