//
//  StartViewController.swift
//  Magnitude
//
//  Created by admin on 8/8/21.
//

import UIKit
import SideMenu
import AppsFlyerLib

class StartViewController: UIViewController {
    var menu: SideMenuNavigationController?
    override func viewDidLoad() {
        super.viewDidLoad()

        menu = self.storyboard?.instantiateViewController(withIdentifier: "menuVC") as? SideMenuNavigationController
        menu?.leftSide = true
        menu?.menuWidth = 280
        menu?.setNavigationBarHidden(true, animated: false)
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        menu?.statusBarEndAlpha = 0
      
        // Do any additional setup after loading the view.
    }
    
  @IBAction func callClicked(_ sender: Any) {
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
  @IBAction func buildPlanClicked(_ sender: Any) {
      Quote.sharedInstance.rentProperty = ""
      Quote.sharedInstance.businessType = ""
      Quote.sharedInstance.squareFootage = ""
      Quote.sharedInstance.businessSize = ""
      Quote.sharedInstance.homeSecurity = ""
      Quote.sharedInstance.homeSize = ""
      Quote.sharedInstance.doorsAmount = ""
      Quote.sharedInstance.features = ""
      Quote.sharedInstance.planType = ""
      Quote.sharedInstance.isSubmitted = false
      Profile.sharedInstance.type = ""
      let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeTypeViewController") as! HomeTypeViewController
      self.navigationController?.pushViewController(vc, animated: true)
  }
  @IBAction func myQuoteClicked(_ sender: Any) {
      let vc = self.storyboard?.instantiateViewController(withIdentifier: "QuoteViewController") as! QuoteViewController
      self.navigationController?.pushViewController(vc, animated: true)
  }
  @IBAction func menuClicked(_ sender: Any) {
      self.present(menu!, animated: true, completion: nil)
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
