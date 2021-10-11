//
//  ProfileRatingsCell.swift
//  TeamUp
//
//  Created by Apple on 08/10/21.
//

import UIKit

class ProfileRatingsCell: UITableViewCell {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var ratingView: FloatRatingView!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    
    
    
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
