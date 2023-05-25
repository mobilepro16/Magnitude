//
//  BusinessSizeTableViewCell.swift
//  Magnitude
//
//  Created by admin on 7/31/21.
//

import UIKit

class BusinessSizeTableViewCell: UITableViewCell {

  @IBOutlet weak var selectIcon: UIImageView!
  @IBOutlet weak var selectLabel: UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
        selectLabel.layer.cornerRadius = selectLabel.bounds.height / 2
        selectLabel.layer.masksToBounds = true
    
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
