//
//  VenueTVC.swift
//  nearby
//
//  Created by Manoj Chvan on 01/06/24.
//

import UIKit

class VenueTVC: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    var venue: Venue?{
        didSet{
            titleLbl.text = venue?.name
            addressLbl.text = venue?.address
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        img.layer.cornerRadius = 4
    }

    
}
