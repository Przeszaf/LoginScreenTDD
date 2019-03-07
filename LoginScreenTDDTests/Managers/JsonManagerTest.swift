//
//  JsonManagerTest.swift
//  LoginScreenTDDTests
//
//  Created by Przemyslaw Szafulski on 05/03/2019.
//  Copyright © 2019 Przemyslaw Szafulski. All rights reserved.
//

import XCTest
@testable import LoginScreenTDD
class JsonManagerTest: XCTestCase {
    var managerContext: ManagerContext!

    override func setUp() {
        managerContext = ManagerContext()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testWithEmptyData() {
        let result = managerContext.jsonManager.parse(data: Data())
        XCTAssertNil(result)
    }
    
    func testParsingValidJson() {
        let json = "{\"key\" : \"value\"}"
        let data = json.data(using: .utf8)!
        let result = managerContext.jsonManager.parse(data: data)
        XCTAssertNotNil(result)
    }
    
    func testParsingInvalidJson() {
        let json = "{\"key\" : error\"value\"}"
        let data = json.data(using: .utf8)!
        let result = managerContext.jsonManager.parse(data: data)
        XCTAssertNil(result)
    }

}
