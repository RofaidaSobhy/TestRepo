//
//  NetworkService.swift
//  SportsApp
//
//  Created by Macos on 16/05/2025.
//

import Foundation


import Alamofire

// MARK: - Network Protocol
protocol NetworkProtocol {
    static func fetchLeaguesDetailsData(
        sport: SportType,
        method: APIMethod,
        leagueId: String,
        fromDate: String,
        toDate: String,
        completionHandler: @escaping (LeaguesDetailsResponse?) -> Void
    )
    static func fetchTeamDetailsData(
        sport: SportType,
        method: APIMethod,
        leagueId: String,
        completionHandler: @escaping (TeamDetailsResponse?) -> Void
    )
    
}

// MARK: - Network Service Implementation
class NetworkService: NetworkProtocol {

    static func fetchLeaguesDetailsData(
        sport: SportType,
        method: APIMethod,
        leagueId: String,
        fromDate: String,
        toDate: String,
        completionHandler: @escaping (LeaguesDetailsResponse?) -> Void
    ) {
        let url = "\(APIConstants.baseURL)/\(sport.rawValue)/"
        let parameters: Parameters = [
            "met": method.rawValue,
            "APIkey": APIConstants.apiKey,
            "from": fromDate,
            "to": toDate,
            "leagueId": leagueId
        ]
        
        AF.request(url, parameters: parameters)
            .responseDecodable(of: LeaguesDetailsResponse.self) { response in
                switch response.result {
                case .success(let result):
                    //print("Data received: \(result.result ?? [])")
                    completionHandler(result)
                case .failure(let error):
                    print("Request failed: \(error)")
                    completionHandler(nil)
                }
            }
    }
    
    
    static func fetchTeamDetailsData(
        sport: SportType,
        method: APIMethod,
        leagueId: String,
        completionHandler: @escaping (TeamDetailsResponse?) -> Void
    ) {
        let url = "\(APIConstants.baseURL)/\(sport.rawValue)/"
        let parameters: Parameters = [
            "met": method.rawValue,
            "APIkey": APIConstants.apiKey,
            "leagueId": leagueId
        ]
        
        AF.request(url, parameters: parameters)
            .responseDecodable(of: TeamDetailsResponse.self) { response in
                switch response.result {
                case .success(let result):
                   // print("Data received: \(result.result ?? [])")
                    completionHandler(result)
                case .failure(let error):
                    print("Request failed: \(error)")
                    completionHandler(nil)
                }
            }
    }
}


