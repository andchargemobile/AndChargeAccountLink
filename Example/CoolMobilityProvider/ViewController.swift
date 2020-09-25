//
//  ViewController.swift
//  CoolMobilityProvider
//
//  Created by Ramesh R C on 23.09.20.
//

import UIKit
import AndChargeAccountLink

class ViewController: UIViewController {

    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var lblConnetUrl: UILabel!
    @IBOutlet weak var txtPartnerId: UITextField!
    @IBOutlet weak var txtPartnerUserId: UITextField!
    @IBOutlet weak var txtActivationCode: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setUpView()
    }
    
    func setUpView() {
        self.lblError.text = ""
    }
    
    @IBAction func btnConnect(_ sender: Any) {
        ACAccountLink.shared.delegate = self
        ACAccountLink.shared.linkAccount(partnerId: txtPartnerId.text ?? "",
                                         partnerUserId: txtPartnerUserId.text ?? "",
                                         activationCode: txtActivationCode.text ?? "",
                                         callbackUrl: "coolmobilityprovider://and-charge/link")
    }
}

extension ViewController: ACAccountLinkDelegate {
    
    func didRequestAccountLink(with requestUrl: URL?, error: ACAccountLinkError?) {
        if let requestUrl = requestUrl{
            lblConnetUrl.text = requestUrl.absoluteString
        }
        if let error = error{
            // return Error
            lblError.text = error.localizedDescription
        }
    }
    
    func didAccountLinkResponses(with requestUrl:URL?, result: ACAccountLinkResult) {
        if let requestUrl = requestUrl{
            lblConnetUrl.text = requestUrl.absoluteString
        }
        
        switch result {
        case .Success:
            lblError.text = "You are connected"
        case .Error(let type):
            lblError.text = type.localizedDescription
        }
    }
}
