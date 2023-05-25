//
//  IntroNameViewController.swift
//  Magnitude
//
//  Created by admin on 7/9/21.
//

import UIKit
import AppsFlyerLib

class IntroNameViewController: UIViewController {

  @IBOutlet weak var callBtn: UIButton!
  @IBOutlet weak var backBtn: UIButton!
  @IBOutlet weak var firstName: UITextField!
  @IBOutlet weak var lastName: UITextField!
  @IBOutlet weak var continueBtn: UIButton!
  override func viewDidLoad() {
        super.viewDidLoad()
        continueBtn.layer.cornerRadius = 8.0
        continueBtn.layer.masksToBounds = true
    
        firstName.layer.cornerRadius = 8.0
        firstName.layer.masksToBounds = true
        firstName.setLeftPaddingPoints(10)
        firstName.setRightPaddingPoints(10)
        
        lastName.layer.cornerRadius = 8.0
        lastName.layer.masksToBounds = true
        lastName.setLeftPaddingPoints(10)
        lastName.setRightPaddingPoints(10)
        // Do any additional setup after loading the view.
        if(Profile.sharedInstance.firstName != "" && Profile.sharedInstance.firstName != nil){
          firstName.text = Profile.sharedInstance.firstName
        }
        if(Profile.sharedInstance.lastName != "" && Profile.sharedInstance.lastName != nil){
          lastName.text = Profile.sharedInstance.lastName
        }
      self.hideKeyboardWhenTappedAround()
    }
  @IBAction func backTapped(_ sender: Any) {
      self.dismiss(animated: true, completion: nil)
  }
  @IBAction func callTapped(_ sender: Any) {
    AppsFlyerLib.shared().logEvent(name: "Click to Call", values: ["id": Profile.sharedInstance.uid ?? "unknown", "First Name": Profile.sharedInstance.firstName ?? "unknown", "Last Name": Profile.sharedInstance.lastName ?? "unknown", "Email Address": Profile.sharedInstance.emailAddress ?? "unknown", "Phone": Profile.sharedInstance.phoneNumber ?? "unknown", "Zip Code": Profile.sharedInstance.zipCode ?? "unknown"], completionHandler: { (response: [String : Any]?, error: Error?) in
                 if let response = response {
                   print("In app event callback Success: ", response)
                 }
                 if let error = error {
                   print("In app event callback ERROR:", error)
                 }
               })
    UIApplication.shared.open(URL(string: "tel://+1(844)492-6092")!)
  }
  
  @IBAction func continueTapped(_ sender: Any) {
      let firstName = self.firstName.text
      let lastName = self.lastName.text
      if (firstName == ""){
          self.showAlert(title: "Warning", message: "First name cannot be empty.")
          return
      }
      if (lastName == ""){
          self.showAlert(title: "Warning", message: "Last name cannot be empty.")
          return
      }
      Profile.sharedInstance.firstName = firstName
      Profile.sharedInstance.lastName = lastName
      let vc = self.storyboard?.instantiateViewController(withIdentifier: "IntroZipCodeViewController") as! IntroZipCodeViewController
      vc.modalPresentationStyle = .overFullScreen
      self.present(vc, animated: true, completion: nil)
  }
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
