//
//  GetFreeQuoteViewController.swift
//  Magnitude
//
//  Created by admin on 7/23/21.
//

import UIKit
import PKHUD
import Firebase
import AppsFlyerLib

class GetFreeQuoteViewController: UIViewController, UITextFieldDelegate {

  @IBOutlet weak var firstName: UITextField!
  @IBOutlet weak var lastName: UITextField!
  @IBOutlet weak var phoneNumber: UITextField!
  @IBOutlet weak var emailAddress: UITextField!
  @IBOutlet weak var zipCode: UITextField!
  @IBOutlet weak var getFreeQuoteBtn: UIButton!
  @IBOutlet weak var myView: UIView!
  @IBOutlet weak var callButton: UIButton!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
        callButton.layer.cornerRadius = callButton.bounds.height / 2
        callButton.layer.masksToBounds = true
    
        firstName.layer.cornerRadius = firstName.bounds.height / 2
        firstName.layer.masksToBounds = true
        firstName.setLeftPaddingPoints(21)
        firstName.setRightPaddingPoints(21)
        
        phoneNumber.layer.cornerRadius = phoneNumber.bounds.height / 2
        phoneNumber.layer.masksToBounds = true
        phoneNumber.setLeftPaddingPoints(21)
        phoneNumber.setRightPaddingPoints(21)
        phoneNumber.delegate = self
    
        emailAddress.layer.cornerRadius = emailAddress.bounds.height / 2
        emailAddress.layer.masksToBounds = true
        emailAddress.setLeftPaddingPoints(21)
        emailAddress.setRightPaddingPoints(21)
        
        zipCode.layer.cornerRadius = zipCode.bounds.height / 2
        zipCode.layer.masksToBounds = true
        zipCode.setLeftPaddingPoints(21)
        zipCode.setRightPaddingPoints(21)
    
        getFreeQuoteBtn.layer.cornerRadius = getFreeQuoteBtn.bounds.height / 2
        getFreeQuoteBtn.layer.masksToBounds = true
    
        if (Profile.sharedInstance.firstName != "" && Profile.sharedInstance.firstName != nil) {
          firstName.text = Profile.sharedInstance.firstName
        }
        if (Profile.sharedInstance.phoneNumber != "" && Profile.sharedInstance.phoneNumber != nil) {
          phoneNumber.text = Profile.sharedInstance.phoneNumber
        }
        if (Profile.sharedInstance.emailAddress != "" && Profile.sharedInstance.emailAddress != nil) {
          emailAddress.text = Profile.sharedInstance.emailAddress
        }
        if (Profile.sharedInstance.zipCode != "" && Profile.sharedInstance.zipCode != nil) {
          zipCode.text = Profile.sharedInstance.zipCode
        }
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.hideKeyboardWhenTappedAround()
    
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
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if (textField == self.phoneNumber){
              let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
              let components = newString.components(separatedBy: NSCharacterSet.decimalDigits.inverted)

              let decimalString = components.joined(separator: "") as NSString
              let length = decimalString.length
              let hasLeadingOne = length > 0 && decimalString.character(at: 0) == (1 as unichar)

              if length == 0 || (length > 10 && !hasLeadingOne) || length > 11 {
                  let newLength = (textField.text! as NSString).length + (string as NSString).length - range.length as Int

                  return (newLength > 10) ? false : true
              }
              var index = 0 as Int
              let formattedString = NSMutableString()

              if hasLeadingOne {
                  formattedString.append("1 ")
                  index += 1
              }
              if (length - index) > 3 {
                  let areaCode = decimalString.substring(with: NSMakeRange(index, 3))
                  formattedString.appendFormat("(%@)", areaCode)
                  index += 3
              }
              if length - index > 3 {
                  let prefix = decimalString.substring(with: NSMakeRange(index, 3))
                  formattedString.appendFormat("%@-", prefix)
                  index += 3
              }

              let remainder = decimalString.substring(from: index)
              formattedString.append(remainder)
              textField.text = formattedString as String
              return false
          } else {
              return true
          }
      }
  @IBAction func getFreeQuoteTapped(_ sender: Any) {
      let emailAddress = self.emailAddress.text
      let zipCode = self.zipCode.text
      let firstName = self.firstName.text
      let phoneNumber = self.phoneNumber.text
      
      if (firstName == ""){
          self.showAlert(title: "Warning", message: "Please enter your full name.")
          return
      }
      if (phoneNumber == ""){
          self.showAlert(title: "Warning", message: "Please enter your phone number.")
          return
      }
      if (emailAddress == ""){
          self.showAlert(title: "Warning", message: "Please enter your email address.")
          return
      }
      if (zipCode == ""){
          self.showAlert(title: "Warning", message: "Please enter your zip code.")
          return
      }
      if (!isValidEmail(email: emailAddress!)){
          self.showAlert(title: "Warning", message: "Invalid email address.")
          return
      }
      Profile.sharedInstance.firstName = firstName
      Profile.sharedInstance.phoneNumber = phoneNumber
      Profile.sharedInstance.emailAddress = emailAddress
      Profile.sharedInstance.zipCode = zipCode
      
      let db = Firestore.firestore()
      var zipCodeApproved = false
      let group = DispatchGroup()
    
      Auth.auth().signInAnonymously { (authResult, error) in
        guard let user = authResult?.user else { return }
        let uid = user.uid
        group.enter()
        db.collectionGroup("approvedZipCodes").whereField("code", isEqualTo: zipCode!).getDocuments { (snapshot, error) in
          if let err = error {
               print(err)
            } else {
              for _ in snapshot!.documents{
                 zipCodeApproved = true
              }
            }
            group.leave()
        }
        group.notify(queue: DispatchQueue.main){
            if (zipCodeApproved != true){
                self.showAlert(title: "Warning", message: "The Zip Code is not in our service area.")
                return
            }
            PKHUD.sharedHUD.show()
            let db = Firestore.firestore()
            let dict = ["client" : db.document(db.collection("client").document("EvNZ4sYmX3Ul4FaIU8mJ").path),
                      "date" : Date(),
                      "user" : uid,
                      "fullName" : Profile.sharedInstance.firstName!,
                      "email" : Profile.sharedInstance.emailAddress!,
                      "phone" : Profile.sharedInstance.phoneNumber!,
                      "zipCode" : Profile.sharedInstance.zipCode!,
                      "type" : Profile.sharedInstance.type ?? "",
                      "quoteType" : Quote.sharedInstance.planType ?? "",
                      "responses" : [
                        [
                          "input" : Quote.sharedInstance.features ?? "",
                          "question" : "What features are you most interested in?",
                        ],
                        [
                          "input" : Quote.sharedInstance.rentProperty ?? "",
                          "question" : "Do you own or rent your property?",
                        ],
                        [
                          "input" : Quote.sharedInstance.doorsAmount ?? "",
                          "question" : "How many exterior doors does your home have?",
                        ],
                        [
                          "input" : Quote.sharedInstance.homeSize ?? "",
                          "question" : "What is the approximate size of your home?",
                        ],
                        [
                          "input" : Quote.sharedInstance.homeSecurity ?? "",
                          "question" : "How would you like to set up your Home Security System?",
                        ],
                        [
                          "input" : Quote.sharedInstance.businessSize ?? "",
                          "question" : "What is the approximate size of your business?",
                        ],
                        [
                          "input" : Quote.sharedInstance.squareFootage ?? "",
                          "question" : "What is the approximate square footage of your business?",
                        ],
                        [
                          "input" : Quote.sharedInstance.businessType ?? "",
                          "question" : "What is your business type?",
                        ]
                      ]] as [String : Any]

            db.collection("response").document().setData(dict as [String : Any])
            AppsFlyerLib.shared().logEvent(name: "Submits for a Quote", values: ["id": Profile.sharedInstance.uid ?? "unknown", "First Name": Profile.sharedInstance.firstName ?? "unknown", "Last Name": Profile.sharedInstance.lastName ?? "unknown", "Email Address": Profile.sharedInstance.emailAddress ?? "unknown", "Phone": Profile.sharedInstance.phoneNumber ?? "unknown", "Zip Code": Profile.sharedInstance.zipCode ?? "unknown"], completionHandler: { (response: [String : Any]?, error: Error?) in
                       if let response = response {
                         print("In app event callback Success: ", response)
                       }
                       if let error = error {
                         print("In app event callback ERROR:", error)
                       }
                     })
          
            PKHUD.sharedHUD.hide()
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "QuoteSubmittedViewController") as! QuoteSubmittedViewController
            vc.modalPresentationStyle = .overFullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
  }
  
  @IBAction func privacyClicked(_ sender: Any) {
      let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebContentViewController") as! WebContentViewController
      vc.urlString = "https://magnitudedigital.com/en/privacy"
      self.navigationController?.pushViewController(vc, animated: true)
  }
  func isValidPhone(phone: String) -> Bool {
      let phoneRegex = "^\\d{3}-\\d{3}-\\d{4}$"
      let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
      return phoneTest.evaluate(with: phone)
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
