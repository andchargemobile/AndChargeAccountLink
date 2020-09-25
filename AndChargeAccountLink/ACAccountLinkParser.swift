//
//  ACAccountLinkParser.swift
//  AndChargeAccountLink
//
//  Created by Ramesh R C on 24.09.20.
//

import Foundation

class ACAccountLinkParser {
    
    class func parseCallBack(with url:URL) -> ACAccountLinkResult  {
        
        guard let components = URLComponents(string: url.absoluteString) else {
            return .Error(errorType: ACAccountLinkError.NIL_EXCEPTION)
        }
        
        if let okState = components.queryItems?.filter({ $0.name.lowercased() == "ok"}).first,
           okState.value?.lowercased() == "true"{
            return .Success
        }else if let errorState = components.queryItems?.filter({ $0.name.lowercased() == "error"}).first,
                 let errorValue = errorState.value{
            return .Error(errorType: ACAccountLinkError(caseName:errorValue) ?? ACAccountLinkError.NIL_EXCEPTION)
        }
        
        return .Error(errorType: ACAccountLinkError.NIL_EXCEPTION)
    }
}
