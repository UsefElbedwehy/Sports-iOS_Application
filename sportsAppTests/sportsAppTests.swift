//
//  sportsAppTests.swift
//  sportsAppTests
//
//  Created by Usef on 27/01/2025.
//

import XCTest
@testable import sportsApp

final class sportsAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchLeaguesFromModel(){
        let expectation = expectation(description: "wait for leagues api")
        Service.fetchLeaguesFromModel(leagueIndex: 0) { val, error in
            if error == nil {
                print("Success")
                XCTAssertNotNil(val, "nil found")
                expectation.fulfill()
            }else{
                XCTFail()
            }
        }
        waitForExpectations(timeout: 5)
        
    }
    
    func testFetchFixturesFromModel(){
        let expectation = expectation(description: "wait for Fixtures api")
        Service.fetchFixturesFromModel(leagueIndex: 0, exten: []) { val, error in
            if error == nil {
                print("Success")
                XCTAssertNotNil(val, "nil found")
                expectation.fulfill()
            }else{
                XCTFail()
            }
        }
        waitForExpectations(timeout: 5)
    }
    
    func testFetchTeamsFromModel(){
        let expectation = expectation(description: "wait for Teams api")
        Service.fetchTeamsFromModel(leagueIndex: 0, exten: "") { val, error in
            if error == nil {
                print("Success")
                XCTAssertNotNil(val, "nil found")
                expectation.fulfill()
            }else{
                XCTFail()
            }
        }
        waitForExpectations(timeout: 5)
    }


}
