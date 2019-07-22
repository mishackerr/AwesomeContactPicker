import UIKit

open class AwesomeContactPicker {
    
    public static let shared = AwesomeContactPicker()
    
    open func openContacts(with hostViewController: UIViewController) {
        let vc = ResourceHelper.contactStoryBoard().instantiateViewController(withIdentifier: String(describing: InitialNavController.self)) as! InitialNavController
        hostViewController.present(vc, animated: true, completion: nil)
    }
}
