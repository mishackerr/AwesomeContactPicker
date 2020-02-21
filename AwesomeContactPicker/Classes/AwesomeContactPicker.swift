import UIKit

public protocol AwesomeContactPickerProtocol: class {
    func contactPicker(_ contactPicker: UIViewController, didDismissWithType type: AwesomeContactPicker.DismissType, contacts: Set<String>?)
    func contactPicker(_ contactPicker: UIViewController, didSelectContactWithIdentifierKey identifierKey: String, completion: @escaping (Bool) -> ())
    func contactPicker(_ contactPicker: UIViewController, didDeselectContactWithIdentifierKey identifierKey: String, completion: @escaping (Bool) -> ())
}

open class AwesomeContactPicker {
    
    public enum DismissType {
        case cancel, done
    }
    
    public static let shared = AwesomeContactPicker()
    
    open func openContacts(with hostViewController: UIViewController, delegate: AwesomeContactPickerProtocol?) {
        let navController = ResourceHelper.contactStoryBoard().instantiateViewController(withIdentifier: String(describing: InitialNavController.self)) as! InitialNavController
        if let contactVC = navController.topViewController as? ContactsViewController {
            contactVC.delegate = delegate
        }
        hostViewController.present(navController, animated: true, completion: nil)
    }
}
