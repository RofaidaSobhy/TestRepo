//
//  LeaguesDetailsPresenter.swift
//  SportsApp
//
//  Created by Macos on 16/05/2025.
//

import Foundation

class LeaguesDetailsPresenter {
    weak var vc: LeaguesDetailsCollectionViewController?
    
    func attachView(myViewController: LeaguesDetailsCollectionViewController) {
        vc = myViewController
    }
    
    func getDataFromModel(
        sport: SportType,
        method: APIMethod,
        leagueId: String,
        fromDate: String,
        toDate: String
    ) {
        NetworkService.fetchLeaguesDetailsData(
            sport: sport,
            method: method,
            leagueId: leagueId,
            fromDate: fromDate,
            toDate: toDate
        ) { [weak self] res in
            guard let result = res else { return }
            DispatchQueue.main.async {
                self?.vc?.renderLeaguesDetailsToView(result: result)
            }
        }
    }
    
    func getTeamDataFromModel(
        sport: SportType,
        method: APIMethod,
        leagueId: String
    ) {
        NetworkService.fetchTeamDetailsData(
            sport: sport,
            method: method,
            leagueId: leagueId
        ) { [weak self] res in
            guard let result = res else { return }
            DispatchQueue.main.async {
                self?.vc?.renderTeamDetailsToView(result: result)
            }
        }
    }
}
