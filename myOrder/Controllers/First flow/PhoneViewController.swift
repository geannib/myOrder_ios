//
//  PhoneViewController.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 12/30/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//

import UIKit
import PhoneNumberKit

class PhoneViewController: UIViewController {

    @IBOutlet weak var labelResend: UILabel!
    @IBOutlet weak var LabelNext: UILabel!
    @IBOutlet weak var textFieldPhone: UITextField!
    @IBOutlet weak var labelLabel: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var viewBackground: UIView!
    
    var isPhoneValid = false
    var typedPhoneNumber = ""
    var SMSCode = false
    var wasPhoneSent = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        makeup()
        handleEvents()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Cod"
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
    }
    
    //Add handlers for controls
    func handleEvents(){
        textFieldPhone.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        LabelNext.isUserInteractionEnabled = true
        let tapNext = UITapGestureRecognizer(target: self, action:  #selector (self.nextTapped (_:)))
        tapNext.numberOfTapsRequired = 1
        LabelNext.addGestureRecognizer(tapNext)
        
        
        labelResend.isUserInteractionEnabled = true
        let tapResend = UITapGestureRecognizer(target: self, action:  #selector (self.resendTapped (_:)))
        tapResend.numberOfTapsRequired = 1
        labelResend.addGestureRecognizer(tapResend)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let phoneNumberKit = PhoneNumberKit()
        var  phoneNumberValid = false
        typedPhoneNumber = textFieldPhone.text ?? ""
        do {
            let _ = try phoneNumberKit.parse(typedPhoneNumber)
            phoneNumberValid = true
        }
        catch {
            phoneNumberValid = false
            print("Generic parser error")
        }
        
        if (wasPhoneSent == true){
            return;
        }
        if (typedPhoneNumber.count == 0){
            textFieldPhone.layer.borderColor = UIColor.gray.cgColor
        }
        else {
            if(phoneNumberValid == true){
                textFieldPhone.layer.borderColor = UIColor.gray.cgColor
            }
            else{
                textFieldPhone.layer.borderWidth = 1
                textFieldPhone.layer.borderColor = UIColor.selgrosRed.cgColor
            }
            LabelNext.isHidden = !phoneNumberValid
        }
        
    }
    
     @objc func resendTapped(_ sender:UITapGestureRecognizer){
        
        self.wasPhoneSent = false
        textFieldPhone.placeholder = "+40725123456"
        SMSCode  = false
        typedPhoneNumber = ""
        labelLabel.generateAttributedString(fonts: ["Roboto-Bold"],
                   colors: [.selgrosRed],
                   sizes: [20],
                   texts: ["Telefon: "],
                   alignement: .right)
               labelTitle.numberOfLines = 0
               labelTitle.generateAttributedString(fonts: ["Roboto-Bold"],
                   colors: [.black],
                   sizes: [20],
                   texts: ["Pentru a continua introduceti numarul de telefon, \n apoi codul primit prin SMS"],
                   alignement: .center)
        self.LabelNext.generateAttributedString(fonts: ["Roboto-Bold"],
                                           colors: [.selgrosWhite],
                                           sizes: [20],
                                           texts: ["TRIMITE"],
                                           alignement: .center)
    }
    
    func verifySMS(){
        
        let token:String = (UserDefaults.standard.value(forKey: kUDToken) ?? "") as! String
        let parameters:[String: String] = ["firebase_uid": token,
        "code": typedPhoneNumber]
        
        WebWrapper.shared.callAPI(reqType:API_VALIDATE_SMS,
            parameters: parameters,
            methodType: .post,
            showLoader: false,
            completion: { (responseType, response, error) in

                print("call verify SMS done")
                let reqResponse: SMSResponseData = SMSResponseData(JSONString: response ?? "")!
                let verify = reqResponse.code ?? false
                
                if (verify == true){
                UserDefaults.standard.set("SMSCode", forKey: kIsPhoneCodSet)
                
                if #available(iOS 13.0, *) {
                           
                           SceneDelegate.shared?.computeFirstFlow()
                         
               } else {
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                   appDelegate.computeFirstFlow()
                   
               }
                }else{
                    self.labelTitle.generateAttributedString(fonts: ["Roboto-Bold"],
                    colors: [.black],
                    sizes: [20],
                    texts: ["Codul SMS este gresit, mai incercati!"],
                    alignement: .center)
                }
                
        })
       
        
    }
    @objc func nextTapped(_ sender:UITapGestureRecognizer){
        
       
        
        if (wasPhoneSent == true && SMSCode == true){
            
             verifySMS()
            return;
        }
        if( typedPhoneNumber.count < 3){
            return
        }
        
        let token:String = (UserDefaults.standard.value(forKey: kUDToken) ?? "") as! String
        let parameters:[String: String] = ["firebase_uid": token,
                              "phone": typedPhoneNumber]
        
       
        self.wasPhoneSent = true
        textFieldPhone.placeholder = "SMS cod"
        SMSCode  = false
        labelResend.isHidden = false
        labelLabel.generateAttributedString(fonts: ["Roboto-Bold"],
            colors: [.selgrosRed],
            sizes: [20],
            texts: ["SMS: "],
            alignement: .right)
        labelTitle.numberOfLines = 0
        labelTitle.generateAttributedString(fonts: ["Roboto-Bold"],
            colors: [.black],
            sizes: [20],
            texts: ["Introduceti codul primit prin SMS"],
            alignement: .center)
        typedPhoneNumber = ""
        textFieldPhone.text = ""
        textFieldPhone.placeholder = "Codul SMS"
        WebWrapper.shared.callAPI(reqType:API_SEND_SMS,
                            parameters: parameters,
                            methodType: .post,
                            showLoader: false,
                            completion: { (responseType, response, error) in

                                print("call done")
                                let reqResponse: SMSResponseData = SMSResponseData(JSONString: response ?? "")!
                                self.SMSCode = reqResponse.code ?? false
                                print("Codul primit este: \(self.SMSCode)")
                               
                                self.LabelNext.generateAttributedString(fonts: ["Roboto-Bold"],
                                    colors: [.selgrosWhite],
                                    sizes: [20],
                                    texts: ["VALIDEAZA"],
                                    alignement: .center)
                                self.LabelNext.isHidden = false
                                
            })
    }
    func makeup(){
        
        view.backgroundColor = .selgrosGray
        viewBackground.backgroundColor = .selgrosGray
        labelTitle.backgroundColor = .selgrosGray
        labelLabel.backgroundColor = .selgrosGray
        textFieldPhone.backgroundColor = .selgrosGray
        LabelNext.backgroundColor = .selgrosRed
        labelResend.backgroundColor = .selgrosGray
        
        textFieldPhone.placeholder = "+40723123456"
        textFieldPhone.keyboardType = .phonePad
        textFieldPhone.becomeFirstResponder()
        
        LabelNext.generateAttributedString(fonts: ["Roboto-Bold"],
                                           colors: [.selgrosWhite],
                                           sizes: [20],
                                           texts: ["TRIMITE"],
                                           alignement: .center)
        labelResend.isHidden = true
        labelResend.generateAttributedString(fonts: ["Roboto-Regular"],
                colors: [.selgrosRed],
                sizes: [15],
                texts: ["Mai trimite o data"],
                alignement: .center)
        labelLabel.generateAttributedString(fonts: ["Roboto-Bold"],
            colors: [.selgrosRed],
            sizes: [20],
            texts: ["Telefon: "],
            alignement: .right)
        labelTitle.numberOfLines = 0
        labelTitle.generateAttributedString(fonts: ["Roboto-Bold"],
            colors: [.black],
            sizes: [20],
            texts: ["Pentru a continua introduceti numarul de telefon, \n apoi codul primit prin SMS"],
            alignement: .center)
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
