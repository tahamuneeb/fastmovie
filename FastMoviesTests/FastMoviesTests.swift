//
//  FastMoviesTests.swift
//  FastMoviesTests
//
//  Created by Taha Muneeb on 14/01/2020.
//  Copyright © 2020 FastOrder. All rights reserved.
//

import XCTest
import CoreData
@testable import FastMovies

class FastMoviesTests: XCTestCase {

    func testYear() {
        let refDate = "2019-1-12"
        let outputYear = Helper.year(string: refDate)
        XCTAssertEqual("2019", outputYear)
    }

    func testFilterDate() {
        let date = Date()
        XCTAssertEqual(date.movieFilterDate(), "2020-01-01")
    }

    func testDeleteFunc() {
        let interactor = MovieListInteractor()
        interactor.clearStorage(type: .popular)
        let movies = interactor.fetchFromStorage(type: .popular)
        XCTAssertEqual(movies, [])
    }

    func testsetMovieSave() {

        let movie = Movie.init(context: SingleTon.shared.cdContext)
        movie.setType(type: .popular)

        let interactor = MovieListInteractor()
        interactor.clearStorage(type: .popular)
        interactor.saveToStorage(type: .popular)
        XCTAssertEqual(interactor.fetchFromStorage(type: .popular).count, 1)
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
