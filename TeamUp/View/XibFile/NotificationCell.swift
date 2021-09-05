//
//  NotificationCell.swift
//  TeamUp
//
//  Created by Apple on 04/09/21.
//

import UIKit

class NotificationCell: UITableViewCell {

    @IBOutlet weak var btnReject: UIButton!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var btnAccept: UIButton!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.imgProfile.layer.cornerRadius = self.imgProfile.frame.height/2
        self.imgProfile.clipsToBounds = true
       
        self.btnReject.layer.borderWidth = 1
        self.btnReject.layer.borderColor = UIColor.black.cgColor

    }
    
    @IBAction func btnAccept(_ sender: Any) {
        
    }
    
    @IBAction func btnReject(_ sender: Any) {
        
    }
    
    
}
