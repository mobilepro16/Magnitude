//
//  GetStartedViewController.swift
//  Magnitude
//
//  Created by admin on 7/8/21.
//

import UIKit
import AppsFlyerLib

class GetStartedViewController: UIViewController {

  @IBOutlet weak var continueBtn: UIButton!
  @IBOutlet weak var callBtn: UIButton!
  override func viewDidLoad() {
        super.viewDidLoad()
        continueBtn.layer.cornerRadius = continueBtn.bounds.height / 2
        continueBtn.layer.masksToBounds = true
    
        callBtn.layer.cornerRadius = callBtn.bounds.height / 2
        callBtn.layer.masksToBounds = true
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
  @IBAction func logoClicked(_ sender: Any) {
      self.navigationController?.popViewController(animated: true)
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
  @IBAction func continueTapped(_ sender: Any) {
      let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeTypeViewController") as! HomeTypeViewController
      vc.modalPresentationStyle = .overFullScreen
      self.navigationController?.pushViewController(vc, animated: true)
  }
  @IBAction func specialOffersTapped(_ sender: Any) {
      let menu = UIAlertController(title: "Today's Special Offers", message: "Which kind of offers would you like to see?", preferredStyle: .actionSheet)
      let securityOffers = UIAlertAction(title: "Security Offers", style: .default) { (action) in
          let vc = self.storyboard?.instantiateViewController(withIdentifier: "SpecialOfferViewController") as! SpecialOfferViewController
          vc.modalPresentationStyle = .overFullScreen
          Profile.sharedInstance.type = "Today's Special Offers"
          Quote.sharedInstance.planType = "Security Offers"
          self.navigationController?.pushViewController(vc, animated: true)
      }
      menu.addAction(securityOffers)
      let healthOffers = UIAlertAction(title: "Health Offers", style: .default) { (action) in
          let vc = self.storyboard?.instantiateViewController(withIdentifier: "HealthOfferViewController") as! HealthOfferViewController
          vc.modalPresentationStyle = .overFullScreen
          Profile.sharedInstance.type = "Today's Special Offers"
          Quote.sharedInstance.planType = "Health Offers"
          self.navigationController?.pushViewController(vc, animated: true)
      }
      menu.addAction(healthOffers)
      let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
      menu.addAction(cancel)
      DispatchQueue.main.async {
          self.present(menu, animated: true, completion: nil)
      }
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
