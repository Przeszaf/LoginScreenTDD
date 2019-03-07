//
//  LoadingButtonTest.swift
//  LoginScreenTDDTests
//
//  Created by Przemyslaw Szafulski on 07/03/2019.
//  Copyright © 2019 Przemyslaw Szafulski. All rights reserved.
//

import XCTest

@testable import LoginScreenTDD

class LoadingButtonTest: XCTestCase {
    var loadingButton: LoadingButton!
    
    override func setUp() {
        loadingButton = LoadingButton()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testIsAddingActivityIndicator() {
        loadingButton.startLoading(style: .white)
        XCTAssertNotNil(loadingButton.activityIndicator)
    }
    
    func testIsChangingActivityIndicatorStyle() {
        loadingButton.startLoading(style: .gray)
        XCTAssertEqual(loadingButton.activityIndicator.style, .gray)
    }
    
    
    func testIsAddingActivityIndicatorToSubview() {
        loadingButton.startLoading(style: .white)
        XCTAssertTrue(loadingButton.subviews.contains(loadingButton.activityIndicator))
    }
    
    func testIsActivityIndicatorInTheMiddle() {
        let loadingButton = LoadingButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        loadingButton.startLoading(style: .white)
        let viewCenterX = (loadingButton.frame.origin.x + loadingButton.frame.origin.x + loadingButton.frame.size.width) / 2
        let viewCenterY = (loadingButton.frame.origin.y + loadingButton.frame.origin.y + loadingButton.frame.size.height) / 2
        let indicatorCenterX = (loadingButton.activityIndicator.frame.origin.x + loadingButton.activityIndicator.frame.origin.x + loadingButton.activityIndicator.frame.size.width) / 2
        let indicatorCenterY = (loadingButton.activityIndicator.frame.origin.y + loadingButton.activityIndicator.frame.origin.y + loadingButton.activityIndicator.frame.size.height) / 2
        XCTAssertEqual(viewCenterX, indicatorCenterX)
        XCTAssertEqual(viewCenterY, indicatorCenterY)
    }
    
    func testIsActivityIndicatorIsSpinning() {
        loadingButton.startLoading(style: .white)
        XCTAssertTrue(loadingButton.activityIndicator.isAnimating)
    }
    
    func testIsActivityIndicatorStopsSpinning() {
        loadingButton.startLoading(style: .white)
        loadingButton.stopLoading()
        XCTAssertFalse(loadingButton.activityIndicator.isAnimating)
    }
    
    func testIsActivityIndicatorRemovedFromSubviews() {
        loadingButton.startLoading(style: .white)
        loadingButton.stopLoading()
        XCTAssertFalse(loadingButton.subviews.contains(loadingButton.activityIndicator))
    }
    
    func testActivityIndicatorStartedTwice() {
        loadingButton.startLoading(style: .white)
        loadingButton.startLoading(style: .white)
        XCTAssertTrue(loadingButton.subviews.count == 1)
    }
    
    func testActivityIndicatorStoppedTwice() {
        loadingButton.startLoading(style: .white)
        loadingButton.stopLoading()
        loadingButton.stopLoading()
        XCTAssertTrue(loadingButton.subviews.count == 0)
    }
    
    func testActivityIndicatorStoppedWithoutStarting() {
        loadingButton.stopLoading()
        XCTAssertTrue(loadingButton.subviews.count == 0)
    }
    
}
