//
//  ACAccountLinkDelegate.swift
//  AndChargeAccountLink
//
//  Created by Ramesh R C on 24.09.20.
//

import Foundation

public protocol ACAccountLinkDelegate: class {
    func didRequestAccountLink(with requestUrl:URL?, error:ACAccountLinkError?)
    func didAccountLinkResponses(with requestUrl:URL?, result:ACAccountLinkResult)
}
