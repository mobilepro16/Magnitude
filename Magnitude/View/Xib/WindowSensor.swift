//
//  WindowSensor.swift
//  Magnitude
//
//  Created by admin on 6/28/21.
//

import UIKit

class WindowSensor: CustomNibView {

  @IBOutlet weak var productImage: UIImageView!
  @IBOutlet weak var quoteBtn: UIButton!
  @IBOutlet weak var checkView: UIImageView!
  @IBOutlet weak var amountView: UILabel!
  @IBOutlet weak var productTitle: UILabel!
  @IBOutlet weak var productSecondTitle: UILabel!
  @IBOutlet weak var firstOptionTitle: UILabel!
  @IBOutlet weak var firstOptionDescription: UILabel!
  @IBOutlet weak var secondOptionTitle: UILabel!
  @IBOutlet weak var secondOptionDescription: UILabel!
  /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
  override func setup(){
      quoteBtn.layer.cornerRadius = 3.0
      quoteBtn.layer.masksToBounds = true
  }
  @IBAction func quoteBtnTapped(_ sender: Any) {
    if (quoteBtn.isSelected == true) {
        quoteBtn.isSelected = false
        quoteBtn.backgroundColor = UIColor(named: "Primary")
    } else {
        quoteBtn.isSelected = true
        quoteBtn.backgroundColor = UIColor.brown
    }
  }
  
}
