//
//  ACAccountLinkDelegate.swift
//  AndChargeAccountLink
//
//  Created by Ramesh R C on 24.09.20.
//

import Foundation

public protocol ACAccountLinkDelegate: class {
    func didRequestFailed(with error:AccountLinkError)
    func didAccountLinkResponses(with result:AccountLinkResult)
}
