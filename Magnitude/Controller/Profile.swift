//
//  Profile.swift
//  Magnitude
//
//  Created by admin on 6/29/21.
//
import Foundation
import UIKit

class Profile: NSObject {
    
    static let sharedInstance: Profile = Profile()
    var uid : String?
    var firstName : String?
    var lastName : String?
    var emailAddress : String?
    var phoneNumber :  String?
    var type : String?
    var zipCode : String?
  
    override private init() {
        super.init()
    }
}
