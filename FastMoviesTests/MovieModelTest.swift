//
//  MovieModelTest.swift
//  FastMoviesTests
//
//  Created by Taha Muneeb on 3/12/20.
//  Copyright © 2020 FastOrder. All rights reserved.
//

import XCTest
import CoreData
@testable import FastMovies

class MovieModelTest: XCTestCase {
    func testJsonToMovieViceVersa() {
        // This testcase will convert json to Movie object and then convert movies object to json and compare orginal json with converted json
        let jsonDic = [
            "popularity": 297.056,
            "vote_count": 891,
            "video": false,
            "poster_path": "/aQvJ5WPzZgYVDrxLX4R6cLJCEaQ.jpg",
            "id": 454626,
            "adult": false,
            "backdrop_path": "/stmYfCUGd8Iy6kAMBr6AmWqx8Bq.jpg",
            "original_language": "en",
            "original_title": "Sonic the Hedgehog",
            "title": "Sonic the Hedgehog",
            "vote_average": 7.2,
            "overview": "Based on the global",
            "release_date": "2020-02-12",
            "type": ""
            ] as [String: Any]
        do {
            guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
                fatalError("Failed to retrieve managed object context")
            }
            let managedObjectContext = SingleTon.shared.cdContext
            let jsonData = try JSONSerialization.data(withJSONObject: jsonDic, options: .prettyPrinted)
            let jsonDecoder = JSONDecoder()
            jsonDecoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedObjectContext
            let movie = try jsonDecoder.decode(Movie.self, from: jsonData)
            if let dic = movie.dictionary {
                var temp = dic
                if let video = temp["video"] as? Int {
                    temp["video"] = video == 0 ? false : true
                }
                if let adult = temp["adult"] as? Int {
                    temp["adult"] = adult == 0 ? false : true
                }
                temp["type"] = ""
                let keysCount = jsonDic.keys.count
                var count: Int = 0
                for tempVal in temp.values {
                    for dicVal in jsonDic.values {
                        if let val1 = tempVal as? Int, let val2 = dicVal as? Int {
                            if val1 == val2 {
                                count += 1
                                break
                            }
                        } else if let val1 = tempVal as? Double, let val2 = dicVal as? Double {
                            if val1 == val2 {
                                count += 1
                                break
                            }
                        } else if let val1 = tempVal as? String, let val2 = dicVal as? String {
                            if val1 == val2 {
                                count += 1
                                break
                            }
                        } else if let val1 = tempVal as? Bool, let val2 = dicVal as? Bool {
                            if val1 == val2 {
                                count += 1
                                break
                            }
                        }
                    }
                }
                XCTAssertTrue(count == keysCount)
            }

        } catch {
            XCTAssertFalse(true)
            print("--> Error: " + error.localizedDescription)
        }
    }

    func testMovieModelWithNullValues() {
        // This testcase will test initialization of movie model with null json Dic values
        let jsonDic: [String: Any] = [:]
        do {
            guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
                fatalError("Failed to retrieve managed object context")
            }
            let managedObjectContext = SingleTon.shared.cdContext
            let jsonData = try JSONSerialization.data(withJSONObject: jsonDic, options: .prettyPrinted)
            let jsonDecoder = JSONDecoder()
            jsonDecoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedObjectContext
            let movie = try jsonDecoder.decode(Movie.self, from: jsonData)
            XCTAssertNotNil(movie)
        } catch {
             XCTAssertFalse(true)
            print("--> Error: " + error.localizedDescription)
        }
    }
    
    func testMovieModelWithDifferentDataTypeValues() {
        // This testcase will test initialization of movie model with different datatype values
        let jsonDic = [
            "popularity": "",
            "vote_count": "",
            "video": 1,
            "poster_path": 1,
            "id": "",
            "adult": "1",
            "backdrop_path": 1,
            "original_language": 1,
            "original_title": 1,
            "title": 1,
            "vote_average": "",
            "overview": "1",
            "release_date": 1,
            "type": 1
        ] as [String: Any]
        do {
            guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
                fatalError("Failed to retrieve managed object context")
            }
            let managedObjectContext = SingleTon.shared.cdContext
            let jsonData = try JSONSerialization.data(withJSONObject: jsonDic, options: .prettyPrinted)
            let jsonDecoder = JSONDecoder()
            jsonDecoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedObjectContext
            let movie = try jsonDecoder.decode(Movie.self, from: jsonData)
            XCTAssertNotNil(movie)
        } catch {
            print("--> Error: " + error.localizedDescription)
            XCTAssertFalse(true)
        }
    }
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
