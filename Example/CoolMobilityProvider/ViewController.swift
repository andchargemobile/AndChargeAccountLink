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
        ACAccountLink.shared.linkAccount(partnerId: "PCS-001",
                       partnerUserId: "1553fe89-95ff-4326-b038-c49ecc7e34db",
                       activationCode: "df7eZIbQ7IiStqgcoOY2XX6Lk0C9qPf3CwYB/LSbN5c",
                       callbackUrl: "coolmobilityprovider://and-charge/link")
    }
}

extension ViewController: ACAccountLinkDelegate {
    func didRequestFailed(with error: AccountLinkError) {
        lblError.text = error.localizedDescription
    }
    func didAccountLinkResponses(with result: AccountLinkResult) {
        switch result {
        case .Success:
            lblError.text = "You are connected"
        case .Error(let type):
            lblError.text = type.localizedDescription
        }
    }
}
