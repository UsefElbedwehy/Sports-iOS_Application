//
//  MockNetworkTest.swift
//  sportsAppTests
//
//  Created by Usef on 05/02/2025.
//

import XCTest

final class MockNetworkTest: XCTestCase {
    let fakeNetwork = FakeNetwork(shouldReturnError: false)
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadLeaguesFromApi(){
        fakeNetwork.fetchLeaguesFromModel(leagueIndex: 0) { leagues, error in
            if let error = error {
                XCTFail()
            }else{
                XCTAssertNotNil(leagues)
            }
        }
    }
    
    func testLoadFixturesFromApi(){
        fakeNetwork.fetchFixturesFromModel(leagueIndex: 0, exten: []) { fixture, error in
            if let error = error {
                XCTFail()
            }else{
                XCTAssertNotNil(fixture)
            }
        }
    }
    
    func testLoadTeamsFromApi(){
        fakeNetwork.fetchTeamsFromModel(leagueIndex: 0, exten: "") { teams, error in
            if let error = error {
                XCTFail()
            }else{
                XCTAssertNotNil(teams)
            }
        }
    }

}
