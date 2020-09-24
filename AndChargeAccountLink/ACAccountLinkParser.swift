//
//  ACAccountLinkParser.swift
//  AndChargeAccountLink
//
//  Created by Ramesh R C on 24.09.20.
//

import Foundation

class ACAccountLinkParser {
    
    class func parseCallBack(with url:URL) -> AccountLinkResult  {
        
        guard let components = URLComponents(string: url.absoluteString) else {
            return .Error(errorType: AccountLinkError.NIL_EXCEPTION)
        }
        
        if let okState = components.queryItems?.filter({ $0.name.lowercased() == "ok"}).first,
           okState.value?.lowercased() == "true"{
            return .Success
        }else if let errorState = components.queryItems?.filter({ $0.name.lowercased() == "error"}).first,
                 let errorValue = errorState.value{
            return .Error(errorType: AccountLinkError(caseName:errorValue) ?? AccountLinkError.NIL_EXCEPTION)
        }
        
        return .Error(errorType: AccountLinkError.NIL_EXCEPTION)
    }
}
