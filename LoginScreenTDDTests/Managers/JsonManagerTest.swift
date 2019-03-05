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

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWithEmptyData() {
        let jsonManager = JsonManager()
        let result = jsonManager.parse(data: Data())
        XCTAssertNil(result)
    }

}
