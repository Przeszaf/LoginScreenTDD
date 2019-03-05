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
    var jsonManager: JsonManager!

    override func setUp() {
        jsonManager = JsonManager()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testWithEmptyData() {
        let result = jsonManager.parse(data: Data())
        XCTAssertNil(result)
    }
    
    func testParsingValidJson() {
        let json = "{\"key\" : \"value\"}"
        let data = json.data(using: .utf8)!
        let result = jsonManager.parse(data: data)
        XCTAssertNotNil(result)
    }
    
    func testParsingInvalidJson() {
        let json = "{\"key\" : error\"value\"}"
        let data = json.data(using: .utf8)!
        let result = jsonManager.parse(data: data)
        XCTAssertNil(result)
    }

}
