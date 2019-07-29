import UIKit

public protocol AwesomeContactPickerProtocol: class {
    func didDismiss(with type: AwesomeContactPicker.DismissType, contacts: Set<String>?)
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
