//
//  AutomatingSettingViewController.swift
//  Magnitude
//
//  Created by admin on 7/9/21.
//

import UIKit
import SideMenu
import AppsFlyerLib

class AutomatingSettingViewController: UIViewController {

  @IBOutlet weak var callbtn: UIButton!
  @IBOutlet weak var backBtn: UIButton!
  @IBOutlet weak var yesBtn: UIButton!
  @IBOutlet weak var noBtn: UIButton!
  var menu: SideMenuNavigationController?
  
  override func viewDidLoad() {
        super.viewDidLoad()

        yesBtn.layer.cornerRadius = 8.0
        yesBtn.layer.masksToBounds = true
        
        noBtn.layer.cornerRadius = 8.0
        noBtn.layer.masksToBounds = true
    
        // Do any additional setup after loading the view.
        menu = self.storyboard?.instantiateViewController(withIdentifier: "menuVC") as? SideMenuNavigationController
        menu?.leftSide = true
        menu?.menuWidth = 280
        menu?.setNavigationBarHidden(true, animated: false)
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        menu?.statusBarEndAlpha = 0

  }
  @IBAction func menuTapped(_ sender: Any) {
  self.present(menu!, animated: true, completion: nil)
  }
    
  @IBAction func backTapped(_ sender: Any) {
      self.navigationController?.popViewController(animated: true)
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
  @IBAction func yesTapped(_ sender: Any) {
      Quote.sharedInstance.automating = true
      let vc = self.storyboard?.instantiateViewController(withIdentifier: "QuoteViewController") as! QuoteViewController
      self.navigationController?.pushViewController(vc, animated: true)
  }
  
  @IBAction func noTapped(_ sender: Any) {
      Quote.sharedInstance.automating = false
      let vc = self.storyboard?.instantiateViewController(withIdentifier: "QuoteViewController") as! QuoteViewController
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
