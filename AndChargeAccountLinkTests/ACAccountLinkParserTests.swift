//
//  ACAccountLinkParserTests.swift
//  AndChargeAccountLinkTests
//
//  Created by Ramesh R C on 24.09.20.
//

import XCTest
@testable import AndChargeAccountLink

class ACAccountLinkParserTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_01_callback_nil(){
        guard let callBackUrl = URL(string: "AndChargeAccountLink://?ok=false&error=abcd") else { return }
        let callBackResult = ACAccountLinkParser.parseCallBack(with: callBackUrl)
        switch callBackResult {
        case .Success:
            break
        case .Error(let type):
            XCTAssert(type == AccountLinkError.NIL_EXCEPTION)
        }
    }
    func test_02_callback_ok_Success(){
        guard let callBackUrl = URL(string: "AndChargeAccountLink://?ok=true&error=nil") else { return }
        let callBackResult = ACAccountLinkParser.parseCallBack(with: callBackUrl)
        switch callBackResult {
        case .Success:
            XCTAssert(callBackResult == .Success)
        case .Error(_):
            break
        }
    }
    
    func test_03_callback_MANDATORY_PARAMETER_NOT_SET(){
        guard let callBackUrl = URL(string: "AndChargeAccountLink://?ok=false&error=MANDATORY_PARAMETER_NOT_SET") else { return }
        let callBackResult = ACAccountLinkParser.parseCallBack(with: callBackUrl)
        switch callBackResult {
        case .Success:
            break
        case .Error(let type):
            XCTAssert(type == AccountLinkError.MANDATORY_PARAMETER_NOT_SET)
        }
    }
}
