//
//  File.swift
//  SportsAppTests
//
//  Created by Macos on 19/05/2025.
//

import XCTest
@testable import SportsApp

final class NetworkServiceTests : XCTestCase {
    
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }
    
//    func testFetchLeagues_ShouldReturnNonEmptyList() {
//          let expectation = self.expectation(description: "Leagues fetched")
//
//          NetworkService.fetchLeagues(for: "football") { leagues in
//              XCTAssertFalse(leagues.isEmpty, "Leagues should not be empty")
//              expectation.fulfill()
//          }
//
//          waitForExpectations(timeout: 10)
//      }
    
    
    func testFetchFootballLeagueDetails_ShouldReturnData() {
          let expectation = self.expectation(description: "Football league details fetched")

          NetworkService.fetchLeaguesDetailsFootballData(
              sport: .football,
              method: .fixtures,
              leagueId: "3",
              fromDate: "2024-05-01",
              toDate: "2024-05-10"
          ) { response in
              XCTAssertNotNil(response)
              XCTAssertNotNil(response?.result)
              expectation.fulfill()
          }

          waitForExpectations(timeout: 10)
      }
    
    func testFetchCricketLeagueDetails_ShouldReturnData() {
          let expectation = self.expectation(description: "Cricket league details fetched")

          NetworkService.fetchLeaguesDetailsCricketData(
              sport: .cricket,
              method: .fixtures,
              leagueId: "12",
              fromDate: "2024-05-01",
              toDate: "2024-05-10"
          ) { response in
              XCTAssertNotNil(response)
              XCTAssertNotNil(response?.result)
              expectation.fulfill()
          }

          waitForExpectations(timeout: 10)
      }
    
    
    func testFetchBasketballLeagueDetails_ShouldReturnData() {
           let expectation = self.expectation(description: "Basketball league details fetched")

           NetworkService.fetchLeaguesDetailsBasketballData(
               sport: .basketball,
               method: .fixtures,
               leagueId: "21",
               fromDate: "2024-05-01",
               toDate: "2024-05-10"
           ) { response in
               XCTAssertNotNil(response)
               XCTAssertNotNil(response?.result)
               expectation.fulfill()
           }

           waitForExpectations(timeout: 10)
       }

       func testFetchTennisLeagueDetails_ShouldReturnData() {
           let expectation = self.expectation(description: "Tennis league details fetched")

           NetworkService.fetchLeaguesDetailsTennisData(
               sport: .tennis,
               method: .fixtures,
               leagueId: "7",
               fromDate: "2024-05-01",
               toDate: "2024-05-10"
           ) { response in
               XCTAssertNotNil(response)
               XCTAssertNotNil(response?.result)
               expectation.fulfill()
           }

           waitForExpectations(timeout: 10)
       }

       func testFetchTeamDetails_ShouldReturnData() {
           let expectation = self.expectation(description: "Team details fetched")

           NetworkService.fetchTeamDetailsData(
               sport: .football,
               method: .teams,
               leagueId: "3"
           ) { response in
               XCTAssertNotNil(response)
               XCTAssertNotNil(response?.result)
               expectation.fulfill()
           }

           waitForExpectations(timeout: 10)
       }

}
