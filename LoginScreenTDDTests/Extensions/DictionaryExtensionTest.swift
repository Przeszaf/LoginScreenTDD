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
        let result: Any? = dict.value(keyPath: "key")
        XCTAssertNil(result)
    }
    
    func testValueFuncWithSimpleDictionary() {
        let dict: [String: Int] = ["key": 1]
        let result: Any? = dict.value(keyPath: "key")
        XCTAssertNotNil(result)
    }
    
    func testValueFuncWithDoubleDeepDictionary() {
        let dict: [String: Any] = ["key": ["key2": "value"]]
        let result: Any? = dict.value(keyPath: "key.key2")
        XCTAssertNotNil(result)
    }
    
    func testValueFuncWithTripleDeepDictionary() {
        let dict: [String: Any] = ["key": ["key2": ["key3": "value"]]]
        let result: Any? = dict.value(keyPath: "key.key2.key3")
        XCTAssertNotNil(result)
    }
    
    func testValueFuncWithTripleDeepDictionaryNotFullKeypath() {
        let dict: [String: Any] = ["key": ["key2": ["key3": "value"]]]
        let result: Any? = dict.value(keyPath: "key.key2")
        XCTAssertNotNil(result)
    }
    
    func testValueFuncSimpleDictReturnsString() {
        let dict: [String: Any] = ["key" : "value"]
        let result: String? = dict.value(keyPath: "key")
        XCTAssertEqual(result, "value")
    }
    
    func testValueFuncTripleDeepDictReturnsString() {
        let dict: [String: Any] = ["key": ["key2": ["key3": "value"]]]
        let result: String? = dict.value(keyPath: "key.key2.key3")
        XCTAssertEqual(result, "value")
    }
    
    func testValueFuncTripleDeepDictReturnsDict() {
        let dict: [String: Any] = ["key": ["key2": ["key3": "value"]]]
        let result: [String: String]? = dict.value(keyPath: "key.key2")
        XCTAssertEqual(result, ["key3": "value"])
    }
    
    func testValueFuncTripleDeepDictWithArrayReturnsNil() {
        let dict: [String: Any] = ["key": [["key2": ["key3": "value"]], ["keyArray1": "valueArray1"]]]
        let result: [String: String]? = dict.value(keyPath: "key.key2")
        XCTAssertNil(result)
    }
    
    func testValueFuncTripleDeepDictWithArrayReturnsArray() {
        let dict: [String: Any] = ["key": [["key2": ["key3": "value"]], ["keyArray1": "valueArray1"]]]
        let result: [Any]? = dict.value(keyPath: "key")
        XCTAssertNotNil(result)
    }
    
    
    func testStringOrStringNumberFuncSimpleDictWithString() {
        let dict: [String: Any] = ["key": "value"]
        let result = dict.stringOrStringNumber(keyPath: "key")
        XCTAssertEqual(result, "value")
    }
    
    func testStringOrStringNumberFuncSimpleDictWithInt() {
        let dict: [String: Any] = ["key": 1]
        let result = dict.stringOrStringNumber(keyPath: "key")
        XCTAssertEqual(result, "1")
    }
    
    func testStringOrStringNumberFuncSimpleDictWithDouble() {
        let dict: [String: Any] = ["key": 1.234]
        let result = dict.stringOrStringNumber(keyPath: "key")
        XCTAssertEqual(result, "1.234")
    }
    
    func testStringOrStringNumberFuncTripleDeepDictWithInt() {
        let dict: [String: Any] = ["key": ["key2": ["key3": 1]]]
        let result = dict.stringOrStringNumber(keyPath: "key.key2.key3")
        XCTAssertEqual(result, "1")
    }
    
    func testStringOrStringNumberFuncTripleDeepDictWithDouble() {
        let dict: [String: Any] = ["key": ["key2": ["key3": 1.234]]]
        let result = dict.stringOrStringNumber(keyPath: "key.key2.key3")
        XCTAssertEqual(result, "1.234")
    }

}
