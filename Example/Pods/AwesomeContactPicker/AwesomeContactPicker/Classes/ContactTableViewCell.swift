//
//  ContactTableViewCell.swift
//  AwesomeContactPicker
//
//  Created by Michael Guo on 7/21/19.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var selectionImageView: UIImageView!
    @IBOutlet weak var thumnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var displayContact: DisplayContact! {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        thumnailImageView.layer.cornerRadius = thumnailImageView.frame.size.width / 2
        thumnailImageView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        selectionImageView.image = selected ? ResourceHelper.image(named: "check") : ResourceHelper.image(named: "circle")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        thumnailImageView.image = nil
        nameLabel.text = nil
    }
    
    func updateUI() {
        if let thumnailData = displayContact.thumnailData {
            thumnailImageView.image = UIImage(data: thumnailData)
        } else {
            thumnailImageView.image = ResourceHelper.image(named: "avatar")
        }
        nameLabel.text = displayContact.fullName
    }
    
}
