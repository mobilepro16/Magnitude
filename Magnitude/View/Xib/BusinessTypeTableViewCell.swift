//
//  BusinessTypeTableViewCell.swift
//  Magnitude
//
//  Created by admin on 7/31/21.
//

import UIKit

class BusinessTypeTableViewCell: UITableViewCell {

  @IBOutlet weak var checkIcon: UIImageView!
  @IBOutlet weak var checkLabel: UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
