//
//  IntroZipCodeViewController.swift
//  Magnitude
//
//  Created by admin on 7/9/21.
//

import UIKit
import AppsFlyerLib

class IntroZipCodeViewController: UIViewController {

  @IBOutlet weak var callBtn: UIButton!
  @IBOutlet weak var backBtn: UIButton!
  @IBOutlet weak var firstNameLabel: UILabel!
  @IBOutlet weak var zipCode: UITextField!
  @IBOutlet weak var continueBtn: UIButton!
  override func viewDidLoad() {
        super.viewDidLoad()
        continueBtn.layer.cornerRadius = 8.0
        continueBtn.layer.masksToBounds = true
    
        zipCode.layer.cornerRadius = 8.0
        zipCode.layer.masksToBounds = true
        zipCode.setLeftPaddingPoints(10)
        zipCode.setRightPaddingPoints(10)
        
        firstNameLabel.text = "Hi, " + Profile.sharedInstance.firstName! + "!"
        if(Profile.sharedInstance.zipCode != "" && Profile.sharedInstance.zipCode != nil){
          zipCode.text = Profile.sharedInstance.zipCode
        }
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
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
      Profile.sharedInstance.zipCode = zipCode.text
      let vc = self.storyboard?.instantiateViewController(withIdentifier: "navVC") as! UINavigationController
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
