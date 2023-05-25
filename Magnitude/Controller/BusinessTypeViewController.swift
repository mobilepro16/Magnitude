//
//  BusinessTypeViewController.swift
//  Magnitude
//
//  Created by admin on 7/31/21.
//

import UIKit
import AppsFlyerLib

class BusinessTypeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  var businessType = ["Automotive", "Food and beverage", "Retail", "Professional services", "Health and wellness", "Manufacturing/Warehouse", "Other"]
  var featureImages = ["business1", "business2", "business3", "business4", "business5", "business6", "business7"]
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var continueBtn: UIButton!
  @IBOutlet weak var progressStatus: UIProgressView!
  @IBOutlet weak var callButton: UIButton!
  override func viewDidLoad() {
        super.viewDidLoad()
        
        continueBtn.layer.cornerRadius = continueBtn.bounds.height / 2
        continueBtn.layer.masksToBounds = true
        continueBtn.isHidden = true
        self.navigationItem.setHidesBackButton(true, animated: true)
        tableView.register(UINib(nibName: "FeatureTableViewCell", bundle: nil), forCellReuseIdentifier: "FeatureTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        progressStatus.setProgress(0.8, animated: true)
        callButton.layer.cornerRadius = callButton.bounds.height / 2
        callButton.layer.masksToBounds = true
        progressStatus.layer.cornerRadius = 3.5
        progressStatus.layer.masksToBounds = true
        progressStatus.clipsToBounds = true

        progressStatus.layer.sublayers![1].cornerRadius = 3.5
        progressStatus.subviews[1].clipsToBounds = true
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
  @IBAction func privacyClicked(_ sender: Any) {
      let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebContentViewController") as! WebContentViewController
      vc.urlString = "https://magnitudedigital.com/en/privacy"
      self.navigationController?.pushViewController(vc, animated: true)
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return businessType.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "FeatureTableViewCell", for: indexPath) as! FeatureTableViewCell
    cell.featureLabel.text = self.businessType[indexPath.row]
    cell.featureImage.image = UIImage(named: self.featureImages[indexPath.row])
    let view = UIView()
    view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
    cell.selectedBackgroundView = view
    return cell
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let cell = tableView.cellForRow(at: indexPath) as! FeatureTableViewCell
      cell.checkedImage.isHidden = false
      self.continueBtn.isHidden = false
  }
  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
      let cell = tableView.cellForRow(at: indexPath) as! FeatureTableViewCell
      cell.checkedImage.isHidden = true
      let selectedFeatures = tableView.indexPathsForSelectedRows
      if selectedFeatures == nil {
          self.continueBtn.isHidden = true
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
  
  @IBAction func continueTapped(_ sender: Any) {
      let selectedFeatures = tableView.indexPathsForSelectedRows
      if selectedFeatures == nil {
          return
      }
      var features : [String] = []
      for indexPath in selectedFeatures! {
        features.append(self.businessType[indexPath.row])
      }
      Quote.sharedInstance.businessType = features.joined(separator: ", ")
    
      let vc = self.storyboard?.instantiateViewController(withIdentifier: "GetFreeQuoteViewController") as! GetFreeQuoteViewController
      vc.modalPresentationStyle = .overFullScreen
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
