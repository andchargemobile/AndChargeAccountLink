//
//  ACAccountLinkNavigator.swift
//  AndChargeAccountLink
//
//  Created by Ramesh R C on 25.09.20.
//

import Foundation
import UIKit

class ACAccountLinkNavigator {
    /// Checking that is device has installed &Charge App
    class func canOpenAndCharge() -> Bool{
        guard let openUrl =  URLBuilder().set(urlString: ACConfigEnum.andChargeURLScheme.rawValue).build(),
              UIApplication.shared.canOpenURL(openUrl) else {return false}
        return true
    }
    /// If the &Charge app not installed  then open appstore
    class func navigateToAppStore(){
        if let openUrl =  URLBuilder().set(scheme: "itms-apps").set(path: "apple.com/app").set(path: ACConfigEnum.APP_ID.rawValue).build(){
            UIApplication.shared.open(openUrl)
        }
    }
    
    /// &Charge is installed so execute deeplink
    class func navigateToAndChargeApp(openUrl:URL){
        UIApplication.shared.open(openUrl)
    }
}
