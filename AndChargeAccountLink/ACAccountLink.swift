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
    /// The callback that needs to be passed to the &Charge app to complete the link
    private(set) var _callbackUrl:String = ""
    ///
    public weak var delegate:ACAccountLinkDelegate?
    /// enableDebugging defalut false. once it enable will be connect to &Charge pp app, But if the app not installed will open
    public var enableDebugging:Bool = false // TODO:
    
    // MARK: - Initializers
    public override init() {}
    
    // MARK: Private
    /// setupParams will be usinng for setting the required value to set calling and charge
    private func setupParams(partnerId: String,
                             partnerUserId: String,
                             activationCode: String,
                             callbackUrl:String){
        self._partnerId = partnerId
        self._partnerUserId = partnerUserId
        self._activationCode = activationCode
        self._callbackUrl = callbackUrl
    }
    /// Making sure all the params has values
    private func validateRequest() -> Bool{
        guard _partnerId != "", _partnerUserId != "", _activationCode != "",_callbackUrl != "" else { return false}
        return true
    }
   
    /// &Charge is installed so execute deeplink
    private func buildAndChargeDeepLinkUrl() -> URL?{
        
        guard let openUrl =  URLBuilder().set(urlString: ACConfigEnum.basePath.rawValue)
                .addQueryItem(name: "activationCode", value: self._activationCode)
                .addQueryItem(name: "partnerId", value: self._partnerId)
                .addQueryItem(name: "partnerUserId", value: self._partnerUserId)
                .addQueryItem(name: "callbackUrl", value: self._callbackUrl)
                .build() else {return nil}
        return openUrl
    }
    
    
    // MARK: Public
    /// This method will be handling app delegate. handle request from &Charge app
    public func accountLinkCallBack(url: URL) {
        let callBackResult = ACAccountLinkParser.parseCallBack(with: url)
        if let d = delegate{
            d.didAccountLinkResponses(with: self.buildAndChargeDeepLinkUrl(), result:callBackResult)
        }
    }
    /// Main method shuould call from Main app
    public func linkAccount(partnerId pId: String,partnerUserId pUserId: String,activationCode aCode: String,callbackUrl url:String){
        self.setupParams(partnerId: pId, partnerUserId: pUserId, activationCode: aCode,callbackUrl: url)
        
        if !validateRequest(){
            // One of the param is missing so call back fail delegate
            if let d = delegate{
                d.didRequestAccountLink(with: self.buildAndChargeDeepLinkUrl(),error: .NIL_EXCEPTION)
            }
            return
        }
        // Validation of request param is success.
        if ACAccountLinkNavigator.canOpenAndCharge(), let openUrl =  self.buildAndChargeDeepLinkUrl(){
            // And charge app is installed so open deeplink with params
            ACAccountLinkNavigator.navigateToAndChargeApp(openUrl: openUrl)
            if let d = delegate{
                d.didRequestAccountLink(with: self.buildAndChargeDeepLinkUrl(), error: nil)
            }
        }else{
            // And charge app is not installed, opennig app store
            ACAccountLinkNavigator.navigateToAppStore()
            //
            if let d = delegate{
                d.didRequestAccountLink(with: self.buildAndChargeDeepLinkUrl(), error: .ANDCHARGE_NOT_INSTALLED)
            }
        }
    }
    
}
