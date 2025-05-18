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
    
    // MARK: - LeaguesDetails
    
    // MARK: - Football
    static func fetchLeaguesDetailsFootballData(
        sport: SportType,
        method: APIMethod,
        leagueId: String,
        fromDate: String,
        toDate: String,
        completionHandler: @escaping (LeaguesDetailsFootballResponse?) -> Void
    )
    
    // MARK: - Cricket
    static func fetchLeaguesDetailsCricketData(
        sport: SportType,
        method: APIMethod,
        leagueId: String,
        fromDate: String,
        toDate: String,
        completionHandler: @escaping (LeaguesDetailsCricketResponse?) -> Void
    )
    
    // MARK: - Basketball
    static func fetchLeaguesDetailsBasketballData(
        sport: SportType,
        method: APIMethod,
        leagueId: String,
        fromDate: String,
        toDate: String,
        completionHandler: @escaping (LeaguesDetailsBasketballResponse?) -> Void
    )
    
    // MARK: - Tennis
    static func fetchLeaguesDetailsTennisData(
        sport: SportType,
        method: APIMethod,
        leagueId: String,
        fromDate: String,
        toDate: String,
        completionHandler: @escaping (LeaguesDetailsTennisResponse?) -> Void
    )
    
    // MARK: - TeamDetails
    static func fetchTeamDetailsData(
        sport: SportType,
        method: APIMethod,
        leagueId: String,
        completionHandler: @escaping (TeamDetailsResponse?) -> Void
    )
    
}

// MARK: - Network Service Implementation
class NetworkService: NetworkProtocol {

    // MARK: - LeaguesDetails

    // MARK: - Football
    static func fetchLeaguesDetailsFootballData(
        sport: SportType,
        method: APIMethod,
        leagueId: String,
        fromDate: String,
        toDate: String,
        completionHandler: @escaping (LeaguesDetailsFootballResponse?) -> Void
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
            .responseDecodable(of: LeaguesDetailsFootballResponse.self) { response in
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
    
    
    // MARK: - Cricket
    static func fetchLeaguesDetailsCricketData(
        sport: SportType,
        method: APIMethod,
        leagueId: String,
        fromDate: String,
        toDate: String,
        completionHandler: @escaping (LeaguesDetailsCricketResponse?) -> Void
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
            .responseDecodable(of: LeaguesDetailsCricketResponse.self) { response in
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
    
    // MARK: - Basketball
    static func fetchLeaguesDetailsBasketballData(
        sport: SportType,
        method: APIMethod,
        leagueId: String,
        fromDate: String,
        toDate: String,
        completionHandler: @escaping (LeaguesDetailsBasketballResponse?) -> Void
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
            .responseDecodable(of: LeaguesDetailsBasketballResponse.self) { response in
                switch response.result {
                case .success(let result):
                    completionHandler(result)
                case .failure(let error):
                    print("Request failed: \(error)")
                    completionHandler(nil)
                }
            }
    }
    
    // MARK: - Tennis
    static func fetchLeaguesDetailsTennisData(
        sport: SportType,
        method: APIMethod,
        leagueId: String,
        fromDate: String,
        toDate: String,
        completionHandler: @escaping (LeaguesDetailsTennisResponse?) -> Void
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
            .responseDecodable(of: LeaguesDetailsTennisResponse.self) { response in
                switch response.result {
                case .success(let result):
                    completionHandler(result)
                case .failure(let error):
                    print("Request failed: \(error)")
                    completionHandler(nil)
                }
            }
    }
    
    // MARK: - TeamDetails
    
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


