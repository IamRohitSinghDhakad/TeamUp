//
//  FavoritesCellTableViewCell.swift
//  TeamUp
//
//  Created by Apple on 03/09/21.
//

import UIKit

protocol myViewDelegate {
    func callViewProfile(index:Int)
}


class FavoritesCellTableViewCell: UITableViewCell {

    @IBOutlet weak var btnHard: UIButton!
    @IBOutlet weak var viewRating: FloatRatingView!
    @IBOutlet weak var lblKm: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblRupes: UILabel!
    @IBOutlet weak var hgtConstantHart: NSLayoutConstraint!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    var delegate:myViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containerView.setShadowOnViewWithRadious(UIColor.gray, shadowRadius: 4.0, shadowOffset: CGSize(width: 0, height: 1.5))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func btnHard(_ sender: Any) {
        
    }
    
    @IBAction func btnView(_ sender: Any) {
        self.delegate?.callViewProfile(index: 1)
    }
    
    
    
}
