//
//  ProfileHistoryCell.swift
//  TeamUp
//
//  Created by Apple on 08/10/21.
//

import UIKit

class ProfileHistoryCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imgProfile.layer.cornerRadius = self.imgProfile.frame.size.height/2
        self.imgProfile.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
