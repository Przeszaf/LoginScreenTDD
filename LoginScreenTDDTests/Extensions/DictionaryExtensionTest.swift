//
//  DictionaryExtensionTest.swift
//  LoginScreenTDDTests
//
//  Created by Przemyslaw Szafulski on 05/03/2019.
//  Copyright © 2019 Przemyslaw Szafulski. All rights reserved.
//

import XCTest
@testable import LoginScreenTDD

class DictionaryExtensionTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testValueFuncWithEmptyDictionary() {
        let dict: [String: Int] = [:]
        let result = dict.value(keyPath: "key")
        XCTAssertNil(result)
    }
    
    func testValueFuncWithSimpleDictionary() {
        let dict: [String: Int] = ["key": 1]
        let result = dict.value(keyPath: "key")
        XCTAssertNotNil(result)
    }
    
    func testValueFuncWithDoubleDeepDictionary() {
        let dict: [String: Any] = ["key": ["key2": "value"]]
        let result = dict.value(keyPath: "key.key2")
        XCTAssertNotNil(result)
    }

}
