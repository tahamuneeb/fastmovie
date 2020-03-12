//
//  FastMoviesUITests.swift
//  FastMoviesUITests
//
//  Created by Taha Muneeb on 14/01/2020.
//  Copyright © 2020 FastOrder. All rights reserved.
//

import XCTest
import UIKit
import Foundation

class FastMoviesUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMovieTap() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
        app.tables.firstMatch.cells.firstMatch.tap()

    }
    
    func testMovieDetailBackTap() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
        app.tables.firstMatch.cells.firstMatch.tap()
        app.buttons.matching(identifier: "detailBackBtn").firstMatch.tap()

    }
    
    func testMovieFilterTopRated() {
        let app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
        app.collectionViews.firstMatch.cells.element(boundBy: 1).tap()
    }
    
    func testMovieFilterUpComing() {
        let app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
        app.collectionViews.firstMatch.cells.element(boundBy: 2).tap()
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
