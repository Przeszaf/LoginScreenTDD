//
//  HttpManagerTest.swift
//  LoginScreenTDDTests
//
//  Created by Przemyslaw Szafulski on 07/03/2019.
//  Copyright © 2019 Przemyslaw Szafulski. All rights reserved.
//

import XCTest

@testable import LoginScreenTDD

class HttpManagerTest: XCTestCase {
    var managerContext: ManagerContext!
    var url: URL!
    
    override func setUp() {
        managerContext = ManagerContext()
        guard let url = URL(string: "www.google.com") else {
            XCTFail()
            return
        }
        self.url = url
    }
    
    
    //MARK: - requestForPost(url: URL, parameters: [[String: Any]]?, httpHeadersArray: [(value: String, httpHeaderField: String)]?) -> URLRequest
    
    func testPostRequestURL() {
        let result = managerContext.httpManager.createPostRequest(url: url, parameters: nil, httpHeadersArray: nil)
        XCTAssertEqual(result.url, url)
    }
    
    func testPostRequestIsPost() {
        let result = managerContext.httpManager.createPostRequest(url: url, parameters: nil, httpHeadersArray: nil)
        XCTAssertEqual(result.httpMethod, "POST")
    }
    
    func testPostRequestParameters() {
        let result = managerContext.httpManager.createPostRequest(url: url, parameters: ["param1": "paramValue1"], httpHeadersArray: nil)
        XCTAssertNotNil(result.httpBody)
    }
    
    func testPostRequestValueHeaderDict() {
        let result = managerContext.httpManager.createPostRequest(url: url, parameters: nil, httpHeadersArray: [("ValueHeaderDictValue", "ValueHeaderDictKey")])
        XCTAssertEqual(result.value(forHTTPHeaderField: "ValueHeaderDictKey"), "ValueHeaderDictValue")
    }
    
    func testPostRequestMultipleValueHeaderDict() {
        let result = managerContext.httpManager.createPostRequest(url: url, parameters: nil, httpHeadersArray: [(value: "ValueHeaderDictValue", httpHeaderField: "ValueHeaderDictKey"),
                                                                                                 (value: "ValueHeaderDictValue2", httpHeaderField: "ValueHeaderDictKey2"),
                                                                                                 (value: "ValueHeaderDictValue3", httpHeaderField: "ValueHeaderDictKey3")])
        XCTAssertEqual(result.value(forHTTPHeaderField: "ValueHeaderDictKey"), "ValueHeaderDictValue")
        XCTAssertEqual(result.value(forHTTPHeaderField: "ValueHeaderDictKey2"), "ValueHeaderDictValue2")
        XCTAssertEqual(result.value(forHTTPHeaderField: "ValueHeaderDictKey3"), "ValueHeaderDictValue3")
    }
    
    //MARK: - get(session: URLSession, request: URLRequest, completionHandler: @escaping ((_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void))
    
    func testGettingCorrectURL() {
        let request = managerContext.httpManager.createPostRequest(url: url, parameters: nil, httpHeadersArray: nil)
        let session = URLSessionMock()
        managerContext.httpManager.get(session: session, request: request) { (data, response, error) in }
        XCTAssertEqual(session.mockURL, url)
    }
    
    
    func testGettingNoError() {
        let request = managerContext.httpManager.createPostRequest(url: url, parameters: nil, httpHeadersArray: nil)
        let session = URLSessionMock()
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        session.mockResponse = response
        var receivedError: Error?
        managerContext.httpManager.get(session: session, request: request) { (data, response, error) in
            receivedError = error
        }
        XCTAssertNil(receivedError)
    }
    
    
    func testGettingData() {
        let request = managerContext.httpManager.createPostRequest(url: url, parameters: nil, httpHeadersArray: nil)
        let session = URLSessionMock()
        let data = try? JSONSerialization.data(withJSONObject: ["username": "admin"], options: [])
        session.mockData = data
        var receivedData: Data?
        managerContext.httpManager.get(session: session, request: request) { (data, response, error) in
            receivedData = data
        }
        guard receivedData != nil else {
            XCTFail()
            return
        }
        let receivedJson = try? JSONSerialization.jsonObject(with: receivedData!, options: [])
        XCTAssertNotNil(receivedJson)
    }
    
    
    
    func testGettingResponseNoDataEqualDataNil() {
        let request = managerContext.httpManager.createPostRequest(url: url, parameters: nil, httpHeadersArray: nil)
        let session = URLSessionMock()
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        session.mockResponse = response
        var receivedData: Data?
        managerContext.httpManager.get(session: session, request: request) { (data, response, error) in
            receivedData = data
        }
        XCTAssertNil(receivedData)
    }
    
    
}

