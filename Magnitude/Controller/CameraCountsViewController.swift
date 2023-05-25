//
//  CameraCountsViewController.swift
//  Magnitude
//
//  Created by admin on 7/9/21.
//

import UIKit
import SideMenu
import AppsFlyerLib

class CameraCountsViewController: UIViewController {

  @IBOutlet weak var backBtn: UIButton!
  @IBOutlet weak var callBtn: UIButton!
  @IBOutlet weak var continueBtn: UIButton!
  @IBOutlet weak var cameraCount: UITextField!
  var menu: SideMenuNavigationController?
  var count = 0
  override func viewDidLoad() {
        super.viewDidLoad()
        continueBtn.layer.cornerRadius = 8.0
        continueBtn.layer.masksToBounds = true
        
        cameraCount.layer.cornerRadius = 8.0
        cameraCount.layer.masksToBounds = true
        cameraCount.text = String(count)
        self.hideKeyboardWhenTappedAround()
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
  @IBAction func continueTapped(_ sender: Any) {
      Quote.sharedInstance.cameraAmount = cameraCount.text
      let vc = self.storyboard?.instantiateViewController(withIdentifier: "AutomatingSettingViewController") as! AutomatingSettingViewController
      self.navigationController?.pushViewController(vc, animated: true)
  }
  @IBAction func plusTapped(_ sender: Any) {
      count += 1
      cameraCount.text = String(count)
  }
  @IBAction func minusTapped(_ sender: Any) {
      if(count == 0){
         return
      }
      count -= 1
      cameraCount.text = String(count)
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
