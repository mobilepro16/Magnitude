//
//  OfferSeclectViewController.swift
//  Magnitude
//
//  Created by admin on 7/25/21.
//

import UIKit
import AppsFlyerLib

class OfferSeclectViewController: UIViewController {

  @IBOutlet weak var headerLabel: UILabel!
  @IBOutlet weak var shopTodayButton: UIButton!
  @IBOutlet weak var buildQuoteButton: UIButton!
  @IBOutlet weak var callButton: UIButton!
  @IBOutlet weak var myView: UIView!
  @IBOutlet weak var getOfferButton: UIButton!
  var headerText : String?
  override func viewDidLoad() {
        super.viewDidLoad()
       
        self.navigationItem.setHidesBackButton(true, animated: true)
        shopTodayButton.layer.cornerRadius = shopTodayButton.bounds.height / 2
        shopTodayButton.layer.masksToBounds = true
        shopTodayButton.layer.borderWidth = 1.0
        shopTodayButton.layer.borderColor = UIColor.black.cgColor
        
        buildQuoteButton.layer.cornerRadius = buildQuoteButton.bounds.height / 2
        buildQuoteButton.layer.masksToBounds = true
    
        getOfferButton.layer.cornerRadius = getOfferButton.bounds.height / 2
        getOfferButton.layer.masksToBounds = true
    
        callButton.layer.cornerRadius = callButton.bounds.height / 2
        callButton.layer.masksToBounds = true
    
        myView.layer.cornerRadius = 30.0
        myView.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
  override func viewWillDisappear(_ animated: Bool) {
      self.navigationController?.setNavigationBarHidden(false, animated: animated);
      super.viewWillDisappear(animated)
  }
  @IBAction func backClicked(_ sender: Any) {
      self.navigationController?.popViewController(animated: true)
  }
  @IBAction func settingClicked(_ sender: Any) {
      let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
      self.navigationController?.pushViewController(vc, animated: true)
  }
  @IBAction func privacyClicked(_ sender: Any) {
      let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebContentViewController") as! WebContentViewController
      vc.urlString = "https://magnitudedigital.com/en/privacy"
      self.navigationController?.pushViewController(vc, animated: true)
  }
  override func viewWillAppear(_ animated: Bool) {
      self.headerLabel.text = headerText
      super.viewWillAppear(animated)
      self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }
  
  @IBAction func getOfferClicked(_ sender: Any) {
      let vc = self.storyboard?.instantiateViewController(withIdentifier: "GetFreeQuoteViewController") as! GetFreeQuoteViewController
      vc.modalPresentationStyle = .overFullScreen
      Quote.sharedInstance.planType = "Today's Offers"
      self.navigationController?.pushViewController(vc, animated: true)
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
  
  @IBAction func shopTodayOfferTapped(_ sender: Any) {
      let vc = self.storyboard?.instantiateViewController(withIdentifier: "SpecialOfferViewController") as! SpecialOfferViewController
      vc.modalPresentationStyle = .overFullScreen
      Quote.sharedInstance.planType = "Today's Offers"
      self.navigationController?.pushViewController(vc, animated: true)
  }
  @IBAction func buildCustomQuoteTapped(_ sender: Any) {
      let vc = self.storyboard?.instantiateViewController(withIdentifier: "FeatureSelectViewController") as! FeatureSelectViewController
      vc.modalPresentationStyle = .overFullScreen
      Quote.sharedInstance.planType = "Custom Quote"
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
