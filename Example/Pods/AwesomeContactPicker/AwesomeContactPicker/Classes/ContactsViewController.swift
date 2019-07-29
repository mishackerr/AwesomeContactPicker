//
//  ContactsViewController.swift
//  AwesomeContactPicker
//
//  Created by Michael Guo on 7/21/19.
//

import UIKit
import Contacts

class ContactsViewController: UIViewController {
    
    @IBOutlet weak var topContainerView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    let contactStore = CNContactStore()
    let contactCellReuseID = "ContactCellReuseID"
    let unkownKey = "unkown"
    let contactDictKeys = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    weak var delegate: AwesomeContactPickerProtocol?
    var contacts = [CNContact]()
    var displayContacts = [DisplayContact]()
    var filteredContacts = [DisplayContact]()
    var sortedContactDictKeys: [String] {
        return contactDict.keys.sorted()
    }
    
    var contactDict: [String: [DisplayContact]] {
        get {
            var res = [String: [DisplayContact]]()
            let contacts = filteredContacts
            for contact in contacts {
                let key = contact.sectionKey
                if contactDictKeys.contains(key) {
                    if res[key] == nil {
                        res[key] = [contact]
                    } else {
                        res[key]!.append(contact)
                    }
                } else {
                    if res[unkownKey] == nil {
                        res[unkownKey] = [contact]
                    } else {
                        res[unkownKey]!.append(contact)
                    }
                }
            }
            return res
        }
    }
    var selectedContacts: Set<String> = AwesomeContactSettings.preSelectedContacts
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBarItems()
        setupSearchTextField()
        setupTableView()
        fetchContacts()
    }
    
    func setupNavBarItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancel(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone(_:)))
    }
    
    func setupSearchTextField() {
        searchTextField.addTarget(self, action: #selector(searchTextFieldDidChanged(_:)), for: .editingChanged)
        searchTextField.layer.shadowPath =
            UIBezierPath(roundedRect: searchTextField.bounds,
                         cornerRadius: searchTextField.layer.cornerRadius).cgPath
        searchTextField.layer.shadowColor = UIColor(white: 200/255.0, alpha: 0.5).cgColor
        searchTextField.layer.shadowOpacity = 0.5
        searchTextField.layer.shadowOffset = CGSize(width: 0, height: 1)
        searchTextField.layer.shadowRadius = 2
        searchTextField.layer.masksToBounds = false
    }
    
    func setupTableView() {
        tableView.register(ResourceHelper.contactNib(), forCellReuseIdentifier: contactCellReuseID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionIndexColor = AwesomeContactSettings.sectionIndexColor
    }
    
    func contact(of indexPath: IndexPath) -> DisplayContact? {
        let key = sortedContactDictKeys[indexPath.section]
        return contactDict[key]?[indexPath.row]
    }
    
}

// MARK: Contacts Fecther
extension ContactsViewController {
    func fetchContacts() {
        contactStore.requestAccess(for: .contacts) { [weak self] (success, error) in
            if !success || error != nil {
                print("Unable to fetch contacts: \(error?.localizedDescription ?? "Unknown")")
            }
            
            DispatchQueue.global(qos: .background).async {
                if let strongSelf = self {
                    let keys = [CNContactIdentifierKey,
                                CNContactGivenNameKey,
                                CNContactMiddleNameKey,
                                CNContactFamilyNameKey,
                                CNContactThumbnailImageDataKey] as [CNKeyDescriptor]
                    let request = CNContactFetchRequest(keysToFetch: keys)
                    request.sortOrder = CNContactSortOrder.familyName
                    
                    do {
                        try strongSelf.contactStore.enumerateContacts(with: request, usingBlock: { (contact, stop) in
                            strongSelf.contacts.append(contact)
                            
                            let displayContact = DisplayContact(identifier: contact.identifier, givenName: contact.givenName, middleName: contact.middleName, familyName: contact.familyName, thumnailData: contact.thumbnailImageData)
                            strongSelf.displayContacts.append(displayContact)
                        })
                        strongSelf.filteredContacts = strongSelf.displayContacts
                        DispatchQueue.main.async {
                            strongSelf.tableView.reloadData()
                        }
                    } catch {
                        print("Unable to fetch contacts")
                    }
                }
            }
        }
    }
}

// MARK: Nav Actions
extension ContactsViewController {
    @objc func didTapCancel(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true) { [weak self] in
            if let strongSelf = self {
                strongSelf.delegate?.didDismiss(with: .cancel, contacts: nil)
            }
        }
    }
    
    @objc func didTapDone(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true) { [weak self] in
            if let strongSelf = self {
                strongSelf.delegate?.didDismiss(with: .done, contacts: strongSelf.selectedContacts)
            }
        }
    }
}

// MARK: SearchTextField
extension ContactsViewController {
    @objc func searchTextFieldDidChanged(_ sender: UITextField) {
        let query = sender.text ?? ""
        if query == "" {
            filteredContacts = displayContacts
        } else {
            filteredContacts = displayContacts.filter({ $0.fullName.lowercased().contains(query.lowercased()) })
        }
        tableView.reloadData()
    }
}

extension ContactsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return contactDict.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = sortedContactDictKeys[section]
        return contactDict[key]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: contactCellReuseID, for: indexPath) as? ContactTableViewCell,
            let contact = contact(of: indexPath) {
            cell.displayContact = contact
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let key = sortedContactDictKeys[section]
        return key != unkownKey ? key : "#"
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return AwesomeContactSettings.sectionIndexHidden ? nil : contactDictKeys + ["#"]
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        let key = title == "#" ? unkownKey : title
        return sortedContactDictKeys.firstIndex(of: key) ?? -1
    }
}

extension ContactsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let contact = contact(of: indexPath) {
            selectedContacts.insert(contact.identifier)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let contact = contact(of: indexPath) {
            selectedContacts.remove(contact.identifier)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let contact = contact(of: indexPath),
            selectedContacts.contains(contact.identifier) {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
    }
}

extension ContactsViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}

struct DisplayContact {
    var identifier: String
    var givenName: String
    var middleName: String
    var familyName: String
    var thumnailData: Data?
    var fullName: String {
        get {
            let names = [givenName, middleName, familyName]
            return names.filter({ (name) -> Bool in
                return name != ""
            }).joined(separator: " ")
        }
    }
    var sectionKey: String {
        get {
            if familyName.count > 0 {
                return String(familyName.first!)
            } else if givenName.count > 0 {
                return String(givenName.first!)
            } else {
                return "unknown"
            }
        }
    }
}
