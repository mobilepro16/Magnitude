//
//  DeviceListTableViewCell.swift
//  Magnitude
//
//  Created by admin on 6/28/21.
//

import UIKit

class DeviceListTableViewCell: UITableViewCell {
  
  @IBOutlet weak var checkImage: UIImageView!
  @IBOutlet weak var deviceName: UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
