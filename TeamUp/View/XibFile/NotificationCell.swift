//
//  NotificationCell.swift
//  TeamUp
//
//  Created by Apple on 04/09/21.
//

import UIKit

protocol sheduleAcceptDelegate {
    func mySheduleAccept(for cell: NotificationCell)
    func mySheduleReject(for cell: NotificationCell)
}

class NotificationCell: UITableViewCell {

    @IBOutlet weak var btnReject: UIButton!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var btnAccept: UIButton!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    var delegate:sheduleAcceptDelegate?
    
    var indexPath: IndexPath?
    
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
        let currentCell = self
        self.delegate?.mySheduleAccept(for: currentCell)
    }
    
    @IBAction func btnReject(_ sender: Any) {
        let currentCell = self
        self.delegate?.mySheduleReject(for: currentCell)
    }
    
    
}
