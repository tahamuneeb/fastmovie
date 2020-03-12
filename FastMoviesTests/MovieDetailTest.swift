//
//  MovieDetailTest.swift
//  FastMoviesTests
//
//  Created by Taha Muneeb on 3/12/20.
//  Copyright © 2020 FastOrder. All rights reserved.
//

import XCTest
@testable import FastMovies

class MovieDetailTest: XCTestCase {
    
    func testSetNullMovieToDisplay() {
        guard let detailVC = Constants.mainSB.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else { return }
        detailVC.movie = nil
        XCTAssertNoThrow(detailVC.setMovie())
    }
    
    func testMovieDetailModule(){
        let module = MovieListRouter.setupModule()
        XCTAssert(module != nil)
    }
    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
