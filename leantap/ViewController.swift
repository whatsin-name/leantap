 //
//  ViewController.swift
//  leantap
//
//  Created by Shubhansh Rai on 28/07/23.
//

import UIKit
import Leanplum

class ViewController: UIViewController,UITextFieldDelegate {
    let datePicker = UIDatePicker()
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var identity: UITextField!
    
    @IBOutlet weak var phone: UITextField!
    
    
    //@IBOutlet weak var dob: UITextField!
    
    
    @IBOutlet weak var num: UITextField!
    
    
    @IBOutlet weak var userlogin: UIButton!
    
    @IBOutlet weak var pushprofile: UIButton!
    
    @IBOutlet weak var pushevent: UIButton!
    
    @IBOutlet weak var pusheventwithprops: UIButton!
    
    @IBOutlet weak var chargedevent: UIButton!
    
    @IBOutlet weak var appinbox: UIButton!
    
    @IBOutlet weak var nativedisplay: UIButton!
    
    @IBAction func nativedisplayfunc(_ sender: Any) {
     
        
    }
    @IBAction func userlogin(_ sender: UIButton) {
        // each of the below mentioned fields are optional
        // with the exception of one of Identity, Email, or FBID
        let _namefield: String? = name.text
        let _emailfield: String? = email.text
        let _idfield: String? = identity.text
        let _phonenum: String? = phone.text
     //   let : String? = dob.text
        let _numfield: Int? = Int(num.text!)
       
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let _dobfield = dateFormatter.date(from: dob.text!)
        
        let _: Dictionary<String, Any> = [
            "Name": _namefield,       // String
            "Identity": _idfield,         // String or number
            "Email": _emailfield,    // Email address of the user
            "Phone": "+91"+_phonenum!,      // Phone (with the country code, starting with +)
            "Number":_numfield,
            // optional fields. controls whether the user will be sent email, push etc.
            "DOB":_dobfield,
            "MSG-email": false,           // Disable email notifications
            "MSG-push": true,             // Enable push notifications
            "MSG-sms": false,             // Disable SMS notifications
            "MSG-whatsapp": true,         // Enable WhatsApp notifications
        ]

        
    }
    @IBAction func btn_login(_ sender: Any) {
        Leanplum.setUserId("user1234")
    }
    
    
    @IBAction func btn_notification(_ sender: Any) {
        
    }
    
    @IBAction func txt_ID(_ sender: Any) {
        Leanplum.setUserId("user1234")
    }
    @IBAction func txt_name(_ sender: Any) {
        Leanplum.setUserAttributes(["name":"Shubhansh"])

    }
    @IBAction func txt_number(_ sender: Any) {
        Leanplum.setUserAttributes(["phone":"9969325155"])

    }
    @IBAction func txt_email(_ sender: Any) {
        Leanplum.setUserAttributes(["email":"user@example.com"])
    }
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date

       //ToolBar
       let toolbar = UIToolbar();
       toolbar.sizeToFit()
       let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
      let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));

     toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)

      dob.inputAccessoryView = toolbar
      dob.inputView = datePicker

     }

      @objc func donedatePicker(){

       let formatter = DateFormatter()
       formatter.dateFormat = "dd/MM/yyyy"
       dob.text = formatter.string(from: datePicker.date)
       self.view.endEditing(true)
     }

     @objc func cancelDatePicker(){
        self.view.endEditing(true)
      }
    
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        self.view.endEditing(true)
            return true
        }
    
    @IBAction func charged_evnt(_ sender: Any) {
        Leanplum.trackInAppPurchases()
    }
    
    @IBAction func Cust_event1(_ sender: Any) {
        Leanplum.track("Score", value: 1)
    }
    
}



