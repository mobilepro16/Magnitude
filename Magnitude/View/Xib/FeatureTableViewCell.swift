//
//  FeatureTableViewCell.swift
//  Magnitude
//
//  Created by admin on 7/27/21.
//

import UIKit

class FeatureTableViewCell: UITableViewCell {

  @IBOutlet weak var featureLabel: UILabel!
  @IBOutlet weak var featureImage: UIImageView!
  @IBOutlet weak var checkedImage: UIImageView!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
