//
//  ForgotPasswordViewController.swift
//  Magnitude
//
//  Created by admin on 6/18/21.
//

import UIKit
import Firebase
import PKHUD

class ForgotPasswordViewController: UIViewController {

  @IBOutlet weak var emailAddress: UITextField!
  @IBOutlet weak var sendBtn: UIButton!
  @IBOutlet weak var myView: UIView!
  override func viewDidLoad() {
        super.viewDidLoad()

        myView.layer.cornerRadius = 24.0
        myView.layer.masksToBounds = true
        
        emailAddress.layer.cornerRadius = 8.0
        emailAddress.layer.masksToBounds = true
        emailAddress.setLeftPaddingPoints(10)
        emailAddress.setRightPaddingPoints(10)
        
        sendBtn.layer.cornerRadius = 8.0
        sendBtn.layer.masksToBounds = true
    
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
  @IBAction func sendTapped(_ sender: Any) {
      let emailAddress = self.emailAddress.text
      
      if (emailAddress == ""){
          self.showAlert(title: "Warning", message: "Email address cannot be empty.")
          return
      }
      if (!isValidEmail(email: emailAddress!)){
          self.showAlert(title: "Warning", message: "Invalid email address.")
          return
      }
      PKHUD.sharedHUD.show()
      Auth.auth().sendPasswordReset(withEmail: emailAddress!) { (error) in
        if let error = error as NSError? {
          PKHUD.sharedHUD.hide()
          switch AuthErrorCode(rawValue: error.code) {
          case .userNotFound:
            // Error: The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section.
            self.showAlert(title: "Warning", message: "User not found.")
            return
          case .invalidEmail:
            // Error: The email address is badly formatted.
            self.showAlert(title: "Warning", message: "Invalid email address.")
            return
          case .invalidRecipientEmail:
            // Error: Indicates an invalid recipient email was sent in the request.
            self.showAlert(title: "Warning", message: "Invalid email address.")
            return
          case .invalidSender:
            // Error: Indicates an invalid sender email is set in the console for this action.
            self.showAlert(title: "Warning", message: "Invalid email address.")
            return
          case .invalidMessagePayload:
            // Error: Indicates an invalid email template for sending update email.
            self.showAlert(title: "Warning", message: "Invalid email address.")
            return
          default:
            print("Error message: \(error.localizedDescription)")
            self.showAlert(title: "Warning", message: "Invalid email address.")
            return
          }
        } else {
            print("Reset password email has been successfully sent")
            PKHUD.sharedHUD.hide()
            let alert = UIAlertController(title: "Magnitude", message: "Reset password email has been successfully sent.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(ok)
            DispatchQueue.main.async {
                self.present(alert, animated: true)
            }
        }
      }
  }
  @IBAction func closeTapped(_ sender: Any) {
      self.dismiss(animated: true, completion: nil)
  }
  func isValidEmail(email: String) -> Bool {
      let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
      let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
      return emailTest.evaluate(with: email)
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
