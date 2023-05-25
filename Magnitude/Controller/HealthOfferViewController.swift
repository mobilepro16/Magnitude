//
//  HealthOfferViewController.swift
//  Magnitude
//
//  Created by admin on 7/23/21.
//

import UIKit
import AppsFlyerLib

class HealthOfferViewController: UIViewController {

  @IBOutlet weak var quote1Btn: UIButton!
  @IBOutlet weak var quote2Btn: UIButton!
  @IBOutlet weak var quote3Btn: UIButton!
  @IBOutlet weak var call1Button: UIButton!
  @IBOutlet weak var call2Button: UIButton!
  @IBOutlet weak var call3Button: UIButton!
  @IBOutlet weak var specialButton1: UIButton!
  @IBOutlet weak var specialButton2: UIButton!
  @IBOutlet weak var callButton: UIButton!
  @IBOutlet weak var offer1View: UIView!
  @IBOutlet weak var offer2View: UIView!
  @IBOutlet weak var offer3View: UIView!
  
  override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
    
        specialButton1.layer.cornerRadius = 3
        specialButton1.layer.masksToBounds = true
        
        specialButton2.layer.cornerRadius = 3
        specialButton2.layer.masksToBounds = true
        
        quote1Btn.layer.cornerRadius = quote1Btn.bounds.height / 2
        quote1Btn.layer.masksToBounds = true
        
        quote2Btn.layer.cornerRadius = quote2Btn.bounds.height / 2
        quote2Btn.layer.masksToBounds = true
        
        quote3Btn.layer.cornerRadius = quote3Btn.bounds.height / 2
        quote3Btn.layer.masksToBounds = true
    
        callButton.layer.cornerRadius = callButton.bounds.height / 2
        callButton.layer.masksToBounds = true
        
        call1Button.layer.cornerRadius = call1Button.bounds.height / 2
        call1Button.layer.masksToBounds = true
        
        call2Button.layer.cornerRadius = call2Button.bounds.height / 2
        call2Button.layer.masksToBounds = true
        
        call3Button.layer.cornerRadius = call3Button.bounds.height / 2
        call3Button.layer.masksToBounds = true
    
        offer1View.layer.cornerRadius = 30.0
        offer1View.layer.masksToBounds = true
        
        offer2View.layer.cornerRadius = 30.0
        offer2View.layer.masksToBounds = true
        
        offer3View.layer.cornerRadius = 30.0
        offer3View.layer.masksToBounds = true
    
        // Do any additional setup after loading the view.
    }
  override func viewWillDisappear(_ animated: Bool) {
      self.navigationController?.setNavigationBarHidden(false, animated: animated);
      super.viewWillDisappear(animated)
  }
  override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }
  @IBAction func settingClicked(_ sender: Any) {
      let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
      self.navigationController?.pushViewController(vc, animated: true)
  }
  @IBAction func backClicked(_ sender: Any) {
      self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func logoTapped(_ sender: Any) {
      self.navigationController?.popToRootViewController(animated: true)
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
  @IBAction func quoteTapped(_ sender: Any) {
      let vc = self.storyboard?.instantiateViewController(withIdentifier: "GetFreeQuoteViewController") as! GetFreeQuoteViewController
      vc.modalPresentationStyle = .overFullScreen
      self.navigationController?.pushViewController(vc, animated: true)
  }
  @IBAction func quote2Tapped(_ sender: Any) {
      let vc = self.storyboard?.instantiateViewController(withIdentifier: "GetFreeQuoteViewController") as! GetFreeQuoteViewController
      vc.modalPresentationStyle = .overFullScreen
      self.navigationController?.pushViewController(vc, animated: true)
  }
  @IBAction func quote3Tapped(_ sender: Any) {
      let vc = self.storyboard?.instantiateViewController(withIdentifier: "GetFreeQuoteViewController") as! GetFreeQuoteViewController
      vc.modalPresentationStyle = .overFullScreen
      self.navigationController?.pushViewController(vc, animated: true)
  }
  @IBAction func call1Clicked(_ sender: Any) {
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
  @IBAction func call2Clicked(_ sender: Any) {
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
  @IBAction func call3Clicked(_ sender: Any) {
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
  /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
