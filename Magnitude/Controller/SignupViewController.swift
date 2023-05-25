//
//  SignupViewController.swift
//  Magnitude
//
//  Created by admin on 6/18/21.
//

import UIKit
import Firebase
import PKHUD

class SignupViewController: UIViewController {

  @IBOutlet weak var profilePhoto: UIImageView!
  @IBOutlet weak var firstName: UITextField!
  @IBOutlet weak var lastName: UITextField!
  @IBOutlet weak var phoneNumber: UITextField!
  @IBOutlet weak var emailAddress: UITextField!
  @IBOutlet weak var password: UITextField!
  @IBOutlet weak var confirmPassword: UITextField!
  @IBOutlet weak var signUpBtn: UIButton!
  @IBOutlet weak var myView: UIView!
  var backType = ""
  override func viewDidLoad() {
        super.viewDidLoad()

        firstName.layer.cornerRadius = 8.0
        firstName.layer.masksToBounds = true
        firstName.setLeftPaddingPoints(10)
        firstName.setRightPaddingPoints(10)
        
        lastName.layer.cornerRadius = 8.0
        lastName.layer.masksToBounds = true
        lastName.setLeftPaddingPoints(10)
        lastName.setRightPaddingPoints(10)
        
        phoneNumber.layer.cornerRadius = 8.0
        phoneNumber.layer.masksToBounds = true
        phoneNumber.setLeftPaddingPoints(10)
        phoneNumber.setRightPaddingPoints(10)
        
        emailAddress.layer.cornerRadius = 8.0
        emailAddress.layer.masksToBounds = true
        emailAddress.setLeftPaddingPoints(10)
        emailAddress.setRightPaddingPoints(10)
        
        password.layer.cornerRadius = 8.0
        password.layer.masksToBounds = true
        password.setLeftPaddingPoints(10)
        password.setRightPaddingPoints(10)
        
        confirmPassword.layer.cornerRadius = 8.0
        confirmPassword.layer.masksToBounds = true
        confirmPassword.setLeftPaddingPoints(10)
        confirmPassword.setRightPaddingPoints(10)
    
        signUpBtn.layer.cornerRadius = 8.0
        signUpBtn.layer.masksToBounds = true
    
        profilePhoto.layer.cornerRadius = 70.0
        profilePhoto.layer.masksToBounds = true
        profilePhoto.layer.borderWidth = 2.0
        profilePhoto.layer.borderColor = UIColor.white.cgColor
    
        myView.layer.cornerRadius = 24.0
        myView.layer.masksToBounds = true
    
        self.hideKeyboardWhenTappedAround()
    
        profilePhoto.isUserInteractionEnabled = true
        let profTap = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profilePhoto.addGestureRecognizer(profTap)
        // Do any additional setup after loading the view.
        if(Profile.sharedInstance.firstName != "" && Profile.sharedInstance.firstName != nil){
          firstName.text = Profile.sharedInstance.firstName
        }
        if(Profile.sharedInstance.lastName != "" && Profile.sharedInstance.lastName != nil){
          lastName.text = Profile.sharedInstance.lastName
        }
        if(Profile.sharedInstance.phoneNumber != "" && Profile.sharedInstance.phoneNumber != nil){
          phoneNumber.text = Profile.sharedInstance.phoneNumber
        }
        if(Profile.sharedInstance.emailAddress != "" && Profile.sharedInstance.emailAddress != nil){
          emailAddress.text = Profile.sharedInstance.emailAddress
        }
  }

  @objc func profileImageTapped(){
     
          let imageSheet = UIAlertController(title: "Upload new photo", message: nil, preferredStyle: .actionSheet)
          let camera = UIAlertAction(title: "Camera", style: .default) { (action) in
              self.uploadPhotoFrom(source: .camera)
          }
          let library = UIAlertAction(title: "Photo Library", style: .default) { (action) in
              self.uploadPhotoFrom(source: .photoLibrary)
          }
          let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in }
          imageSheet.addAction(camera)
          imageSheet.addAction(library)
          imageSheet.addAction(cancel)
          
          DispatchQueue.main.async {
              self.present(imageSheet, animated: true)
          }
      
  }
  func uploadPhotoFrom(source: UIImagePickerController.SourceType){
      let vc = UIImagePickerController()
      vc.sourceType = source
      vc.allowsEditing = true
      vc.delegate = self
      DispatchQueue.main.async {
          self.present(vc, animated: true)
      }
  }
  @IBAction func signUpTapped(_ sender: Any) {
      let emailAddress = self.emailAddress.text
      let password = self.password.text
      let confirmPassword = self.confirmPassword.text
      let firstName = self.firstName.text
      let lastName = self.lastName.text
      let phoneNumber = self.phoneNumber.text
      
      if (firstName == ""){
          self.showAlert(title: "Warning", message: "First name cannot be empty.")
          return
      }
      if (lastName == ""){
          self.showAlert(title: "Warning", message: "Last name cannot be empty.")
          return
      }
      if (phoneNumber == ""){
          self.showAlert(title: "Warning", message: "Phone number cannot be empty.")
          return
      }
      if (emailAddress == ""){
          self.showAlert(title: "Warning", message: "Email address cannot be empty.")
          return
      }
      if (password == ""){
          self.showAlert(title: "Warning", message: "Password cannot be empty.")
          return
      }
      if (confirmPassword != password){
          self.showAlert(title: "Warning", message: "Password and confirm password must be match.")
          return
      }
      if (!isValidEmail(email: emailAddress!)){
          self.showAlert(title: "Warning", message: "Invalid email address.")
          return
      }
      if (!isValidPhone(phone: phoneNumber!)){
          self.showAlert(title: "Warning", message: "Invalid phone number.")
          return
      }
      if (!isValidPassword(password!)){
        self.showAlert(title: "Warning", message: "The password must be 6 characters long or more.")
        return
      }
      PKHUD.sharedHUD.show()
      Auth.auth().createUser(withEmail: emailAddress!, password: password!) { authResult, error in
          if let error = error as NSError? {
              PKHUD.sharedHUD.hide()
              switch AuthErrorCode(rawValue: error.code) {
                case .operationNotAllowed:
                    // Error: The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section.
                    self.showAlert(title: "Warning", message: "The given sign-in provider is disabled for this Firebase project.")
                    return
                case .emailAlreadyInUse:
                    // Error: The email address is already in use by another account.
                    self.showAlert(title: "Warning", message: "The email address is already in use by another account.")
                    return
                case .invalidEmail:
                    // Error: The email address is badly formatted.
                    self.showAlert(title: "Warning", message: "The email address is badly formatted.")
                    return
                case .weakPassword:
                    // Error: The password must be 6 characters long or more.
                    self.showAlert(title: "Warning", message: "The password must be 6 characters long or more.")
                    return
                default:
                    print("Error: \(error.localizedDescription)")
              }
          } else {
              print("User signs up successfully")
              let newUserInfo = Auth.auth().currentUser
              Profile.sharedInstance.uid = newUserInfo?.uid
              Profile.sharedInstance.firstName = firstName
              Profile.sharedInstance.lastName = lastName
              Profile.sharedInstance.emailAddress = newUserInfo?.email
              Profile.sharedInstance.phoneNumber = phoneNumber
         
              if ( self.profilePhoto.image != nil){
                let imageName = UUID().uuidString
                let storageRef = Storage.storage().reference().child("user").child(newUserInfo!.uid).child("\(newUserInfo?.uid ?? imageName).jpg")
                if let uploadData = self.profilePhoto.image!.jpegData(compressionQuality: 0.1) {
                    storageRef.putData(uploadData, metadata: nil, completion: { (_, error) in
                        if let error = error {
                            print(error)
                        } else {
                            storageRef.downloadURL(completion: { (url, error) in
                                if let error = error {
                                    print(error)
                                }
                            })
                        }
                    })
                }
              }
              if (Profile.sharedInstance.type == nil) {
                Profile.sharedInstance.type = ""
              }
            
              let db = Firestore.firestore()
              let dict = ["first" : firstName,
                          "last" : lastName,
                          "phone" : phoneNumber,
                          "uid" : newUserInfo?.uid,
                          "email" : emailAddress,
                          "zip" : Profile.sharedInstance.zipCode,
                          "type" : Profile.sharedInstance.type,
                          "currentCheckpoint" : "marketing"]
            
              db.collection("user").document(newUserInfo!.uid).setData(dict as [String : Any])
              PKHUD.sharedHUD.hide()
              self.dismiss(animated: true, completion: nil)
          }
      }
  }
  func isValidPhone(phone: String) -> Bool {
      let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
      let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
      return phoneTest.evaluate(with: phone)
  }
  func isValidEmail(email: String) -> Bool {
      let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
      let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
      return emailTest.evaluate(with: email)
  }
  func isValidPassword(_ password: String) -> Bool {
      let minPasswordLength = 6
      return password.count >= minPasswordLength
  }
  @IBAction func closeTapped(_ sender: Any) {
      self.dismiss(animated: true, completion: nil)
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
extension SignupViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        self.profilePhoto.image = image
    }
}
