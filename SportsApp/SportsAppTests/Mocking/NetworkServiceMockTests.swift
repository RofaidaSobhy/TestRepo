//
//  NetworkServiceMockTests.swift
//  SportsAppTests
//
//  Created by Macos on 19/05/2025.
//

import Foundation

import XCTest
import Alamofire
@testable import SportsApp

final class NetworkServiceMockTests: XCTestCase {

    override class func setUp() {
        URLProtocol.registerClass(MockURLProtocol.self)
    }

    override class func tearDown() {
        URLProtocol.unregisterClass(MockURLProtocol.self)
    }

    func testFetchLeagues_WithMockedResponse_ShouldReturnLeagues() {
        let json = """
        {
          "success": 1,
          "data": [
            {
              "league_key": 123,
              "league_name": "Mock League",
              "country_name": "Mockland",
              "league_logo": null,
              "country_logo": null
            }
          ]
        }
        """.data(using: .utf8)

        MockURLProtocol.stubResponseData = json

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = Session(configuration: configuration)

        let expectation = self.expectation(description: "Leagues from mock")
        let url = "https://mockapi.com/football/?met=Leagues&APIkey=MOCK"

        session.request(url).validate().responseDecodable(of: LeaguesResponse.self) { response in
            switch response.result {
            case .success(let data):
                XCTAssertEqual(data.data.first?.league_name, "Mock League")
            case .failure:
                XCTFail("Should decode mock data")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5)
    }
}

// MARK: - Mock URLProtocol

class MockURLProtocol: URLProtocol {
    static var stubResponseData: Data?

    override class func canInit(with request: URLRequest) -> Bool { true }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }

    override func startLoading() {
        if let data = MockURLProtocol.stubResponseData {
            self.client?.urlProtocol(self, didLoad: data)
        }
        self.client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}
}
