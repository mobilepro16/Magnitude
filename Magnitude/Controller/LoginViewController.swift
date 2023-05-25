//
//  LoginViewController.swift
//  Magnitude
//
//  Created by admin on 6/18/21.
//

import UIKit
import Firebase
import PKHUD

class LoginViewController: UIViewController {

  @IBOutlet weak var emailAddress: UITextField!
  @IBOutlet weak var password: UITextField!
  @IBOutlet weak var signInBtn: UIButton!
  @IBOutlet weak var signUpBtn: UIButton!
  @IBOutlet weak var forgotPasswordBtn: UIButton!
  @IBOutlet weak var googleSignBtn: UIButton!
  @IBOutlet weak var facebookSignBtn: UIButton!
  @IBOutlet weak var myView: UIView!
  var backType = ""
  
  override func viewDidLoad() {
        super.viewDidLoad()
        emailAddress.layer.cornerRadius = 8.0
        emailAddress.layer.masksToBounds = true
        emailAddress.setLeftPaddingPoints(10)
        emailAddress.setRightPaddingPoints(10)
    
        password.layer.cornerRadius = 8.0
        password.layer.masksToBounds = true
        password.setLeftPaddingPoints(10)
        password.setRightPaddingPoints(10)
        
        signInBtn.layer.cornerRadius = 8.0
        signInBtn.layer.masksToBounds = true
        
        signUpBtn.layer.cornerRadius = 8.0
        signUpBtn.layer.masksToBounds = true
    
        myView.layer.cornerRadius = 24.0
        myView.layer.masksToBounds = true
    
        googleSignBtn.layer.cornerRadius = 10.0
        googleSignBtn.layer.masksToBounds = true
        googleSignBtn.layer.borderWidth = 0.5
        googleSignBtn.layer.borderColor = UIColor.lightGray.cgColor
    
        facebookSignBtn.layer.cornerRadius = 10.0
        facebookSignBtn.layer.masksToBounds = true
        facebookSignBtn.layer.borderWidth = 0.5
        facebookSignBtn.layer.borderColor = UIColor.lightGray.cgColor
        if (Profile.sharedInstance.emailAddress != "" && Profile.sharedInstance.emailAddress != nil) {
          emailAddress.text = Profile.sharedInstance.emailAddress
        }
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
  @IBAction func closeTapped(_ sender: Any) {
      self.dismiss(animated: true, completion: nil)
  }
  @IBAction func signinTapped(_ sender: Any) {
    
      let emailAddress = self.emailAddress.text
      let password = self.password.text
      
      if (emailAddress == ""){
          self.showAlert(title: "Warning", message: "Email address cannot be empty.")
          return
      }
      if (password == ""){
          self.showAlert(title: "Warning", message: "Password cannot be empty.")
          return
      }
      if (!isValidEmail(email: emailAddress!)){
          self.showAlert(title: "Warning", message: "Invalid email address.")
          return
      }
      PKHUD.sharedHUD.show()
      Auth.auth().signIn(withEmail: emailAddress!, password: password!) { (authResult, error) in
        if let error = error as NSError? {
            PKHUD.sharedHUD.hide()
            switch AuthErrorCode(rawValue: error.code) {
              case .operationNotAllowed:
                  // Error: Indicates that email and password accounts are not enabled. Enable them in the Auth section of the Firebase console.
                  self.showAlert(title: "Warning", message: "Indicates that email and password accounts are not enabled.")
                  return
              case .userDisabled:
                  // Error: The user account has been disabled by an administrator.
                  self.showAlert(title: "Warning", message: "The user account has been disabled by an administrator.")
                  return
              case .wrongPassword:
                  // Error: The password is invalid or the user does not have a password.
                  self.showAlert(title: "Warning", message: "The password is invalid")
                  return
              case .invalidEmail:
                  // Error: Indicates the email address is malformed.
                  self.showAlert(title: "Warning", message: "Indicates the email address is malformed.")
                  return
              default:
                  print("Error: \(error.localizedDescription)")
                  self.showAlert(title: "Warning", message: "Invalid email or password.")
                  return
              }
            } else {
              print("User signs in successfully")
              let userInfo = Auth.auth().currentUser
              let db = Firestore.firestore()
              let docRef = db.collection("user").document(userInfo!.uid)
              docRef.getDocument { document, error in
                  if let error = error as NSError? {
                      print("Error getting document: \(error.localizedDescription)")
                  }
                  else {
                    if let document = document {
                      let id = document.documentID
                      let data = document.data()
                      Profile.sharedInstance.uid = id
                      Profile.sharedInstance.firstName = data?["first"] as? String ?? ""
                      Profile.sharedInstance.lastName = data?["last"] as? String ?? ""
                      Profile.sharedInstance.emailAddress = data?["email"] as? String ?? ""
                      Profile.sharedInstance.phoneNumber = data?["phone"] as? String ?? ""
                      Profile.sharedInstance.type = data?["type"] as? String ?? ""
                      Profile.sharedInstance.zipCode = data?["zip"] as? String ?? ""
                    }
                }
              }
              PKHUD.sharedHUD.hide()
              self.dismiss(animated: true, completion: nil)
          }
      }
  }
  func isValidEmail(email: String) -> Bool {
      let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
      let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
      return emailTest.evaluate(with: email)
  }
  @IBAction func signupTapped(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.backType = self.backType
        self.present(vc, animated: true, completion: nil)
  }
  @IBAction func forgotPasswordTapped(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
  }
  @IBAction func googleSignTapped(_ sender: Any) {
  }
  @IBAction func facebookSignTapped(_ sender: Any) {
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
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
