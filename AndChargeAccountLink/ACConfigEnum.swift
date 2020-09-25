//
//  ACConfig.swift
//  AndChargeAccountLink
//
//  Created by Ramesh R C on 24.09.20.
//

import Foundation

enum ACConfigEnum:String {
    case andChargeURLScheme = "andcharge://"
    case basePath = "https://and-charge.com/confirmAccountLink"
    case APP_ID = "id1487636133"
}

public enum ACAccountLinkError: Error,CaseIterable {
    case INVALID_REQUEST
    case NIL_EXCEPTION
    case ANDCHARGE_NOT_INSTALLED
    
    case MANDATORY_PARAMETER_NOT_SET
    case ACCOUNT_LINKED_TO_DIFFERENT_USER
    case PARTNER_NOT_FOUND
    case GENERAL_PROCESSING_FAILURE
    case AUTHORIZATION_INVALID
    case ACTIVATION_CODE_NOT_FOUND
    case REFERENCED_OBJECT_NOT_FOUND
    
    init?(caseName: String) {
        for value in ACAccountLinkError.allCases where "\(value)" == caseName {
            self = value
            return
        }
        return nil
    }
}

extension ACAccountLinkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .INVALID_REQUEST:
            return NSLocalizedString("Missing parameter invalid request", comment: "InvalidRequest")
        case .ANDCHARGE_NOT_INSTALLED:
            return NSLocalizedString("AndCharge is not installed", comment: "andChargeNotInstalled")
        case .NIL_EXCEPTION:
            return NSLocalizedString("Object Null", comment: "nilException")
        case .MANDATORY_PARAMETER_NOT_SET:
            return NSLocalizedString("Your request was missing a mandatory parameter. Please check the URL.", comment: "MANDATORY_PARAMETER_NOT_SET")
        case .ACCOUNT_LINKED_TO_DIFFERENT_USER:
            return NSLocalizedString("The given user is already linked to another &amp;Charge account.", comment: "ACCOUNT_LINKED_TO_DIFFERENT_USER")
        case .PARTNER_NOT_FOUND:
            return NSLocalizedString("No partner found for the given partnerId.", comment: "PARTNER_NOT_FOUND")
        case .GENERAL_PROCESSING_FAILURE:
            return NSLocalizedString("Something went wrong on side of &amp;Charge. Please get in touch with us, we\'ll have a look into it.", comment: "GENERAL_PROCESSING_FAILURE")
        case .AUTHORIZATION_INVALID:
            return NSLocalizedString("Something went wrong while authenticating.", comment: "AUTHORIZATION_INVALID")
        case .ACTIVATION_CODE_NOT_FOUND:
            return NSLocalizedString("We did not recognize the activation code you gave us in the URL.", comment: "ACTIVATION_CODE_NOT_FOUND")
        case .REFERENCED_OBJECT_NOT_FOUND:
            return NSLocalizedString("Something went wrong within the &amp;Charge app. Please get in touch with us, we\'ll have a look into it.", comment: "REFERENCED_OBJECT_NOT_FOUND")
        }
    }
}

public enum ACAccountLinkResult : Equatable{
    case Success
    case Error(errorType:ACAccountLinkError)
}
