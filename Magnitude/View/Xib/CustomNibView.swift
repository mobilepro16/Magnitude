//
//  CustomNibView.swift
//  Magnitude
//
//  Created by admin on 6/6/21.
//  Copyright © 2021. All rights reserved.
//

import UIKit

class CustomNibView: UIView {

    var contentView: UIView!
    
    var nibName: String {
        return String(describing: type(of: self))
    }
    
    
    //MARK:
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        loadViewFromNib()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        loadViewFromNib()
        setup()
    }
    
    //MARK:
    func loadViewFromNib() {
        contentView = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?[0] as? UIView
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    func setup(){
        // should override
    }
}
