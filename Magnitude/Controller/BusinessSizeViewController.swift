//
//  BusinessSizeViewController.swift
//  Magnitude
//
//  Created by admin on 7/31/21.
//

import UIKit
import AppsFlyerLib

class BusinessSizeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  var questionType = "businessSize"
  var businessSize = ["MULTISITE NATIONAL BUSINESS", "LARGE ENTERPRISE \n(1,000+ EMPLOYEES)", "MIDSIZE BUSINESS \n(100 - 999 EMPLOYEES)", "SMALL BUSINESS \n(<100 EMPLOYEES)"]
  var squareFootage = ["UNDER 1,000 SQ. FT.", "1,000 - 5,000 SQ. FT.", "5,000 - 10,000 SQ. FT.", "10,000+ SQ FT"]
  var rentProperty = ["OWN", "RENT"]
  var doorsAmount = ["1-2 DOORS", "3+ DOORS"]
  var homeSize = ["UNDER 1,000 SQ. FT.", "1,000 - 2,500 SQ. FT.", "2,500 - 4,999 SQ. FT.", "5,000+ SQ. FT."]
  var homeSecurity = ["PROFESSIONALLY INSTALLED", "DIY SETUP & CONFIGURATION"]
  var nextQuestion = "businessType"
  var datas : Array<String>?
  @IBOutlet weak var progressStatus: UIProgressView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var callButton: UIButton!
  override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        tableView.register(UINib(nibName: "BusinessSizeTableViewCell", bundle: nil), forCellReuseIdentifier: "BusinessSizeTableViewCell")

        tableView.dataSource = self
        tableView.delegate = self
        callButton.layer.cornerRadius = callButton.bounds.height / 2
        callButton.layer.masksToBounds = true
        progressStatus.layer.cornerRadius = progressStatus.bounds.height / 2
        progressStatus.layer.masksToBounds = true
        progressStatus.clipsToBounds = true
    
        progressStatus.layer.sublayers![1].cornerRadius = progressStatus.bounds.height / 2
        progressStatus.subviews[1].clipsToBounds = true
    
        if(questionType == "businessSize"){
            datas = businessSize
            nextQuestion = "squareFootage"
            titleLabel.text = "What is the approximate size of your business?"
            progressStatus.setProgress(0.4, animated: true)
        } else if(questionType == "squareFootage") {
            datas = squareFootage
            nextQuestion = "businessType"
            titleLabel.text = "What is the approximate square footage of your business?"
            progressStatus.setProgress(0.6, animated: true)
        } else if(questionType == "rentProperty") {
            datas = rentProperty
            nextQuestion = "doorsAmount"
            titleLabel.text = "Do you own or rent your property?"
            progressStatus.setProgress(0.3333, animated: true)
        } else if(questionType == "doorsAmount") {
            datas = doorsAmount
            nextQuestion = "homeSize"
            titleLabel.text = "How many exterior doors does your home have?"
            progressStatus.setProgress(0.5, animated: true)
        } else if(questionType == "homeSize") {
            datas = homeSize
            nextQuestion = "homeSecurity"
            titleLabel.text = "What is the approximate size of your home?"
            progressStatus.setProgress(0.6666, animated: true)
        } else if(questionType == "homeSecurity") {
            datas = homeSecurity
            nextQuestion = "getFreeQuote"
            titleLabel.text = "How would you like to set up your Home Security System?"
            progressStatus.setProgress(0.8333, animated: true)
        }
    
    
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
  @IBAction func skipClicked(_ sender: Any) {
      if(questionType == "businessSize"){
          Quote.sharedInstance.businessSize = "Not Sure"
      } else if(questionType == "squareFootage") {
          Quote.sharedInstance.squareFootage = "Not Sure"
      } else if(questionType == "rentProperty") {
          Quote.sharedInstance.rentProperty = "Not Sure"
      } else if(questionType == "doorsAmount") {
          Quote.sharedInstance.doorsAmount = "Not Sure"
      } else if(questionType == "homeSize") {
          Quote.sharedInstance.homeSize = "Not Sure"
      } else if(questionType == "homeSecurity") {
          Quote.sharedInstance.homeSecurity = "Not Sure"
      }
    
      if(nextQuestion == "businessType") {
          let vc = self.storyboard?.instantiateViewController(withIdentifier: "BusinessTypeViewController") as! BusinessTypeViewController
          vc.modalPresentationStyle = .overFullScreen
          self.navigationController?.pushViewController(vc, animated: true)
      } else if (nextQuestion == "getFreeQuote") {
          let vc = self.storyboard?.instantiateViewController(withIdentifier: "GetFreeQuoteViewController") as! GetFreeQuoteViewController
          vc.modalPresentationStyle = .overFullScreen
          self.navigationController?.pushViewController(vc, animated: true)
      } else {
          let vc = self.storyboard?.instantiateViewController(withIdentifier: "BusinessSizeViewController") as! BusinessSizeViewController
          vc.modalPresentationStyle = .overFullScreen
          vc.questionType = self.nextQuestion
          self.navigationController?.pushViewController(vc, animated: true)
      }
  }
  @IBAction func privacyClicked(_ sender: Any) {
      let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebContentViewController") as! WebContentViewController
      vc.urlString = "https://magnitudedigital.com/en/privacy"
      self.navigationController?.pushViewController(vc, animated: true)
  }
  @IBAction func settingClicked(_ sender: Any) {
      let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
      self.navigationController?.pushViewController(vc, animated: true)
  }
  @IBAction func backClicked(_ sender: Any) {
      self.navigationController?.popViewController(animated: true)
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return datas!.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessSizeTableViewCell", for: indexPath) as! BusinessSizeTableViewCell
      cell.selectLabel.text = self.datas![indexPath.row]
      if indexPath.row % 2 == 0 {
          cell.selectLabel.backgroundColor = UIColor(red: 0.008, green: 0.383, blue: 0.668, alpha: 1.0)
      } else {
          cell.selectLabel.backgroundColor = UIColor(red: 0.313, green: 0.738, blue: 0.652, alpha: 1.0)
      }
      let view = UIView()
      view.backgroundColor = UIColor.white.withAlphaComponent(0.1)
      cell.selectedBackgroundView = view
      return cell
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      if(questionType == "businessSize"){
          Quote.sharedInstance.businessSize = self.datas![indexPath.row]
      } else if(questionType == "squareFootage") {
          Quote.sharedInstance.squareFootage = self.datas![indexPath.row]
      } else if(questionType == "rentProperty") {
          Quote.sharedInstance.rentProperty = self.datas![indexPath.row]
      } else if(questionType == "doorsAmount") {
          Quote.sharedInstance.doorsAmount = self.datas![indexPath.row]
      } else if(questionType == "homeSize") {
          Quote.sharedInstance.homeSize = self.datas![indexPath.row]
      } else if(questionType == "homeSecurity") {
          Quote.sharedInstance.homeSecurity = self.datas![indexPath.row]
      }
    
      if(nextQuestion == "businessType") {
          let vc = self.storyboard?.instantiateViewController(withIdentifier: "BusinessTypeViewController") as! BusinessTypeViewController
          vc.modalPresentationStyle = .overFullScreen
          self.navigationController?.pushViewController(vc, animated: true)
      } else if (nextQuestion == "getFreeQuote") {
          let vc = self.storyboard?.instantiateViewController(withIdentifier: "GetFreeQuoteViewController") as! GetFreeQuoteViewController
          vc.modalPresentationStyle = .overFullScreen
          self.navigationController?.pushViewController(vc, animated: true)
      } else {
          let vc = self.storyboard?.instantiateViewController(withIdentifier: "BusinessSizeViewController") as! BusinessSizeViewController
          vc.modalPresentationStyle = .overFullScreen
          vc.questionType = self.nextQuestion
          self.navigationController?.pushViewController(vc, animated: true)
      }
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
  /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
