//
//  Quote.swift
//  Magnitude
//
//  Created by admin on 6/28/21.
//

import Foundation
import UIKit

class Quote: NSObject {
    
    static let sharedInstance: Quote = Quote()
    
    var planType : String?
    var windowsAmount : String?
    var windowsDevice = [String]()
    var doorsDevice = [String]()
    var isSubmitted : Bool?
    var cameraAmount : String?
    var automating : Bool?
    var quoteType : String?
    var features : String?
    var businessSize : String?
    var squareFootage : String?
    var rentProperty : String?
    var doorsAmount : String?
    var homeSize : String?
    var homeSecurity : String?
    var businessType : String?
  
    override private init() {
        super.init()
        
    }
}
