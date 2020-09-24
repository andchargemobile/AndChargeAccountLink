//
//  AndChargeAccountLink.swift
//  AndChargeAccountLink
//
//  Created by Ramesh R C on 23.09.20.
//

import Foundation
import UIKit

open class ACAccountLink:NSObject {
    
    public static var shared:ACAccountLink = {
        return ACAccountLink()
    }()
    /// partnerId Your partner ID with which you registered yourself as a partner
    private(set) var _partnerId:String = ""
    /// partnerUserId The user for which you request the account link (user ID is defined by you, we'll map this to one of our users subsequently).
    private(set) var _partnerUserId:String = ""
    /// The activation code that needs to be passed to the &Charge webpage or app to complete the link
    private(set) var _activationCode:String = ""
    
    private(set) var _callbackUrl:String = ""
    
    public weak var delegate:ACAccountLinkDelegate?
    
    // MARK: - Initializers
    public override init() {}
    
    // MARK: Private
    
    private func setupParams(partnerId: String,
                             partnerUserId: String,
                             activationCode: String,
                             callbackUrl:String){
        self._partnerId = partnerId
        self._partnerUserId = partnerUserId
        self._activationCode = activationCode
        self._callbackUrl = callbackUrl
    }
    
    private func validateRequest() -> Bool{
        guard _partnerId != "", _partnerUserId != "", _activationCode != "",_callbackUrl != "" else { return false}
        return true
    }
    
    private func canOpenAndCharge() -> Bool{
        guard let openUrl =  URLBuilder().set(urlString: ACConfigEnum.andChargeURLScheme.rawValue).build(),
              UIApplication.shared.canOpenURL(openUrl) else {return false}
        return true
    }
    private func navigateToAppStore(){
        if let openUrl =  URLBuilder().set(scheme: "itms-apps").set(path: "apple.com/app").set(path: ACConfigEnum.APP_ID.rawValue).build(){
            UIApplication.shared.open(openUrl)
        }
    }
    private func navigateToAndChargeApp(){
        
        guard let openUrl =  URLBuilder().set(urlString: ACConfigEnum.basePath.rawValue)
                .addQueryItem(name: "activationCode", value: self._activationCode)
                .addQueryItem(name: "partnerId", value: self._partnerId)
                .addQueryItem(name: "partnerUserId", value: self._partnerUserId)
                .addQueryItem(name: "callbackUrl", value: self._callbackUrl)
                .build() else {return}
        UIApplication.shared.open(openUrl)
    }
    
    // MARK: Public
    
    public func accountLinkCallBack(url: URL) {
        let callBackResult = ACAccountLinkParser.parseCallBack(with: url)
        if let d = delegate{
            d.didAccountLinkResponses(with: callBackResult)
        }
    }
    
    public func linkAccount(partnerId pId: String,partnerUserId pUserId: String,activationCode aCode: String,callbackUrl url:String){
        self.setupParams(partnerId: pId, partnerUserId: pUserId, activationCode: aCode,callbackUrl: url)
        
        if !validateRequest(){
            // One of the param is missing so call back fail delegate
            if let d = delegate{
                d.didRequestFailed(with: .NIL_EXCEPTION)
            }
            return
        }
        // Validation of request param is success.
        if (canOpenAndCharge()){
            // And charge app is installed so open deeplink with params
            self.navigateToAndChargeApp()
        }else{
            // And charge app is not installed, opennig app store
            navigateToAppStore()
            //
            if let d = delegate{
                d.didRequestFailed(with: .ANDCHARGE_NOT_INSTALLED)
            }
        }
    }
    
}
