//
//  HomeTypeViewController.swift
//  Magnitude
//
//  Created by admin on 6/18/21.
//

import UIKit
import Firebase
import PKHUD
import AppsFlyerLib

class HomeTypeViewController: UIViewController {

  @IBOutlet weak var myView: UIView!
  @IBOutlet weak var renterBtn: UIButton!
  @IBOutlet weak var ownerBtn: UIButton!
  @IBOutlet weak var commericalBtn: UIButton!
  @IBOutlet weak var healthBtn: UIButton!
  @IBOutlet weak var callBtn: UIButton!
  
  override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        callBtn.layer.cornerRadius = callBtn.bounds.height / 2
        callBtn.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
  @IBAction func settingClicked(_ sender: Any) {
      let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
      self.navigationController?.pushViewController(vc, animated: true)
  }
  override func viewWillDisappear(_ animated: Bool) {
      self.navigationController?.setNavigationBarHidden(false, animated: animated);
      super.viewWillDisappear(animated)
  }
  @IBAction func backClicked(_ sender: Any) {
      self.navigationController?.popViewController(animated: true)
  }
  @IBAction func logoClicked(_ sender: Any) {
      self.navigationController?.popToRootViewController(animated: true)
  }
  override func viewWillAppear(_ animated: Bool) {
      self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }
  func setType() {

    if (Profile.sharedInstance.type == "" || Profile.sharedInstance.type == nil) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeTypeViewController") as! HomeTypeViewController
        self.present(vc, animated: true, completion: nil)
    }
  }
  @IBAction func privacyClicked(_ sender: Any) {
      let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebContentViewController") as! WebContentViewController
      vc.urlString = "https://magnitudedigital.com/en/privacy"
      self.navigationController?.pushViewController(vc, animated: true)
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
  @IBAction func renterBtnTapped(_ sender: Any) {
      Profile.sharedInstance.type = "Home Security"
      AppsFlyerLib.shared().logEvent(name: "Home Security is Selected", values: ["id": Profile.sharedInstance.uid ?? "unknown", "First Name": Profile.sharedInstance.firstName ?? "unknown", "Last Name": Profile.sharedInstance.lastName ?? "unknown", "Email Address": Profile.sharedInstance.emailAddress ?? "unknown", "Phone": Profile.sharedInstance.phoneNumber ?? "unknown", "Zip Code": Profile.sharedInstance.zipCode ?? "unknown"], completionHandler: { (response: [String : Any]?, error: Error?) in
                 if let response = response {
                   print("In app event callback Success: ", response)
                 }
                 if let error = error {
                   print("In app event callback ERROR:", error)
                 }
               })
    
      let vc = self.storyboard?.instantiateViewController(withIdentifier: "OfferSeclectViewController") as! OfferSeclectViewController
      vc.modalPresentationStyle = .overFullScreen
      vc.headerText = "Home Security"
      self.navigationController?.pushViewController(vc, animated: true)
  
  }
  @IBAction func ownerBtnTapped(_ sender: Any) {
      Profile.sharedInstance.type = "Small Business"
      AppsFlyerLib.shared().logEvent(name: "Small Business is Selected", values: ["id": Profile.sharedInstance.uid ?? "unknown", "First Name": Profile.sharedInstance.firstName ?? "unknown", "Last Name": Profile.sharedInstance.lastName ?? "unknown", "Email Address": Profile.sharedInstance.emailAddress ?? "unknown", "Phone": Profile.sharedInstance.phoneNumber ?? "unknown", "Zip Code": Profile.sharedInstance.zipCode ?? "unknown"], completionHandler: { (response: [String : Any]?, error: Error?) in
                 if let response = response {
                   print("In app event callback Success: ", response)
                 }
                 if let error = error {
                   print("In app event callback ERROR:", error)
                 }
               })
      let vc = self.storyboard?.instantiateViewController(withIdentifier: "OfferSeclectViewController") as! OfferSeclectViewController
      vc.modalPresentationStyle = .overFullScreen
      vc.headerText = "Small Business"
      self.navigationController?.pushViewController(vc, animated: true)
  }
  @IBAction func commericalBtnTapped(_ sender: Any) {
      Profile.sharedInstance.type = "Commercial"
      AppsFlyerLib.shared().logEvent(name: "Commercial is Selected", values: ["id": Profile.sharedInstance.uid ?? "unknown", "First Name": Profile.sharedInstance.firstName ?? "unknown", "Last Name": Profile.sharedInstance.lastName ?? "unknown", "Email Address": Profile.sharedInstance.emailAddress ?? "unknown", "Phone": Profile.sharedInstance.phoneNumber ?? "unknown", "Zip Code": Profile.sharedInstance.zipCode ?? "unknown"], completionHandler: { (response: [String : Any]?, error: Error?) in
                 if let response = response {
                   print("In app event callback Success: ", response)
                 }
                 if let error = error {
                   print("In app event callback ERROR:", error)
                 }
               })
      let vc = self.storyboard?.instantiateViewController(withIdentifier: "OfferSeclectViewController") as! OfferSeclectViewController
      vc.modalPresentationStyle = .overFullScreen
      vc.headerText = "Commercial"
      self.navigationController?.pushViewController(vc, animated: true)
  }
  @IBAction func healthBtnTapped(_ sender: Any) {
      Profile.sharedInstance.type = "Medical Alert"
      AppsFlyerLib.shared().logEvent(name: "Medical Alert is Selected", values: ["id": Profile.sharedInstance.uid ?? "unknown", "First Name": Profile.sharedInstance.firstName ?? "unknown", "Last Name": Profile.sharedInstance.lastName ?? "unknown", "Email Address": Profile.sharedInstance.emailAddress ?? "unknown", "Phone": Profile.sharedInstance.phoneNumber ?? "unknown", "Zip Code": Profile.sharedInstance.zipCode ?? "unknown"], completionHandler: { (response: [String : Any]?, error: Error?) in
                 if let response = response {
                   print("In app event callback Success: ", response)
                 }
                 if let error = error {
                   print("In app event callback ERROR:", error)
                 }
               })
    
      let vc = self.storyboard?.instantiateViewController(withIdentifier: "HealthOfferViewController") as! HealthOfferViewController
      vc.modalPresentationStyle = .overFullScreen
      Quote.sharedInstance.planType = "Today's Offers"
      self.navigationController?.pushViewController(vc, animated: true)
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
