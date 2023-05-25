//
//  HomeViewController.swift
//  Magnitude
//
//  Created by admin on 6/17/21.
//

import UIKit
import Firebase
import AppsFlyerLib

class HomeViewController: UIViewController {
  
  override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated);
        super.viewWillDisappear(animated)
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
          
        AppsFlyerLib.shared().logEvent(name: "How many opened the app?", values: ["id": Profile.sharedInstance.uid ?? "unknown", "First Name": Profile.sharedInstance.firstName ?? "unknown", "Last Name": Profile.sharedInstance.lastName ?? "unknown", "Email Address": Profile.sharedInstance.emailAddress ?? "unknown", "Phone": Profile.sharedInstance.phoneNumber ?? "unknown", "Zip Code": Profile.sharedInstance.zipCode ?? "unknown"], completionHandler: { (response: [String : Any]?, error: Error?) in
                   if let response = response {
                     print("In app event callback Success: ", response)
                   }
                   if let error = error {
                     print("In app event callback ERROR:", error)
                   }
                 })
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
           // Your code with navigate to another controller
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "GetStartedViewController") as! GetStartedViewController
            vc.modalPresentationStyle = .overFullScreen
            self.navigationController?.pushViewController(vc, animated: true)
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
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
  
  func showAlert(title: String? = nil, message: String? = nil){
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
      alert.addAction(ok)
      DispatchQueue.main.async {
          self.present(alert, animated: true)
      }
  }
}
