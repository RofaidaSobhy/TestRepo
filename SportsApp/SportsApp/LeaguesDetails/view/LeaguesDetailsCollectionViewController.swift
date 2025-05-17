//
//  LeaguesDetailsCollectionViewController.swift
//  SportsApp
//
//  Created by Macos on 14/05/2025.
//

import UIKit
import Kingfisher

class LeaguesDetailsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let sectionTitles = ["Upcoming Events", "Latest Events", "Teams"]
    
    var upComingMatchs : [Match]?
    var latestMatchs : [Match]?
    
    var allTeams : [TeamData]?
    
    let leaguesDetailsPresenter = LeaguesDetailsPresenter()

    var leagueId : String?
    var leagueName : String?
    var sport : SportType?
    override func viewDidLoad() {
        super.viewDidLoad()
        //calling data
        leagueId = "5"
        leagueName = "leagueName"
        sport = .football
        
        
        leaguesDetailsPresenter.attachView(myViewController: self)
        
        
        leaguesDetailsPresenter.getDataFromModel(
            sport: sport ?? .football,
            method: .fixtures,
            leagueId: leagueId ?? "0",
            fromDate: DateUtils.getFromDateOneYearAgo(),
            toDate: DateUtils.getToDateOneYearAhead()
        )
        
        leaguesDetailsPresenter.getTeamDataFromModel(
            sport: sport ?? .football,
            method: .teams,
            leagueId: leagueId ?? "0"
            
        )
        
        
        setupNavigationBar()
        registerCellsAndHeaders()
        collectionView.setCollectionViewLayout(configureCompositionalLayout(), animated: true)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionTitles.count
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section{
        case 0 :
            return upComingMatchs?.count ?? 0

        case 1 :
            return latestMatchs?.count ?? 0

           
        default:
            return allTeams?.count ?? 0
        }
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = dequeueCell(ofType: UpComingEvensCollectionViewCell.self, for: indexPath)
            
            
            cell.nameTeam1.text = upComingMatchs?[indexPath.row].eventHomeTeam
            cell.nameTeam2.text = upComingMatchs?[indexPath.row].eventAwayTeam
            
            cell.matchDate.text = upComingMatchs?[indexPath.row].eventDate
            
            cell.matchTime.text = upComingMatchs?[indexPath.row].eventTime
            
            if let urlHomeTeamLogo = URL(string: upComingMatchs?[indexPath.row].homeTeamLogo ?? ""){
                cell.logoTeam1.kf.setImage(with: urlHomeTeamLogo ,placeholder: UIImage(named: "1"))
            }
            if let urlAwayTeamLogo = URL(string: upComingMatchs?[indexPath.row].awayTeamLogo ?? ""){
                cell.logoTeam2.kf.setImage(with: urlAwayTeamLogo ,placeholder: UIImage(named: "1"))
            }
            return cell
        case 1:
            
            let cell = dequeueCell(ofType: LatestEventsCollectionViewCell.self, for: indexPath)
            
            cell.nameTeam1.text = latestMatchs?[indexPath.row].eventHomeTeam
            cell.nameTeam2.text = latestMatchs?[indexPath.row].eventAwayTeam
            
            cell.matchDate.text = latestMatchs?[indexPath.row].eventDate
            
            cell.matchTime.text = latestMatchs?[indexPath.row].eventTime
            
            cell.score.text = latestMatchs?[indexPath.row].eventFinalResult
            
            if let urlHomeTeamLogo = URL(string: latestMatchs?[indexPath.row].homeTeamLogo ?? ""){
                cell.logoTeam1.kf.setImage(with: urlHomeTeamLogo ,placeholder: UIImage(named: "1"))
            }
            if let urlAwayTeamLogo = URL(string: latestMatchs?[indexPath.row].awayTeamLogo ?? ""){
                cell.logoTeam2.kf.setImage(with: urlAwayTeamLogo ,placeholder: UIImage(named: "1"))
            }
            return cell
        default:
            let cell =  dequeueCell(ofType: TeamCollectionViewCell.self, for: indexPath)
            
            cell.teamName.text = allTeams?[indexPath.row].teamName
            
            if let urlTeamLogo = URL(string: allTeams?[indexPath.row].teamLogo ?? ""){
                cell.teamImage.kf.setImage(with: urlTeamLogo ,placeholder: UIImage(named: "1"))
            }
            return cell
        }
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }

        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SimpleHeaderView.reuseIdentifier, for: indexPath) as! SimpleHeaderView
        header.configure(text: sectionTitles[indexPath.section])
        return header
    }
}

// MARK: - Layout Configuration

extension LeaguesDetailsCollectionViewController {

    private func configureCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { index, _ in
            switch index {
            case 0: return self.drawSection(itemWidth: .fractionalWidth(1), groupHeight: 185, groupWidth: .fractionalWidth(1), isHorizontal: true)
            case 1: return self.drawSection(itemWidth: .fractionalWidth(1), groupHeight: 185, groupWidth: .fractionalWidth(1), isHorizontal: false)
            case 2: return self.drawSection(itemWidth: .fractionalWidth(1), groupHeight: 185, groupWidth: .absolute(250), isHorizontal: true)
            default: return self.drawSection(itemWidth: .fractionalWidth(1), groupHeight: 185, groupWidth: .fractionalWidth(1), isHorizontal: true)
            }
        }
    }

    private func drawSection(itemWidth: NSCollectionLayoutDimension, groupHeight: CGFloat, groupWidth: NSCollectionLayoutDimension, isHorizontal: Bool) -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(widthDimension: itemWidth, heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: groupWidth, heightDimension: .absolute(groupHeight))
        let group = isHorizontal
            ? NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            : NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        group.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 10, bottom: 0, trailing: 10)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = isHorizontal ? .continuous : .none
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]

        section.visibleItemsInvalidationHandler = { items, offset, environment in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.8
                let maxScale: CGFloat = 1.0
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }

        return section
    }
}

// MARK: - Setup & Utilities

extension LeaguesDetailsCollectionViewController {

    private func setupNavigationBar() {
        let customFont = UIFont.systemFont(ofSize: 24, weight: .bold)
        let customColor = UIColor(named: "orange") ?? .orange
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: customColor,
            .font: customFont
        ]
        navigationItem.title = leagueName
    }

    private func registerCellsAndHeaders() {
        collectionView.register(SimpleHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SimpleHeaderView.reuseIdentifier)

        collectionView.register(UINib(nibName: "UpComingEvensCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: UpComingEvensCollectionViewCell.identifier)
        collectionView.register(UINib(nibName: "LatestEventsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: LatestEventsCollectionViewCell.identifier)
        collectionView.register(UINib(nibName: "TeamCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: TeamCollectionViewCell.identifier)
    }

    private func dequeueCell<T: UICollectionViewCell>(ofType type: T.Type, for indexPath: IndexPath) -> T {
        return collectionView.dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
}

// MARK: - Reuse Identifiers

extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}


// MARK: - UICollectionViewDelegate
extension LeaguesDetailsCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 2 {
            let teamDetailsViewController :  TeamDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "teamDetails") as! TeamDetailsViewController
            
            teamDetailsViewController.teamData = allTeams?[indexPath.row];
            
            let backItem = UIBarButtonItem()
            backItem.title = leagueName
            navigationItem.backBarButtonItem = backItem
            self.navigationController?.pushViewController(teamDetailsViewController, animated: true)
        }
       
    }
}

// MARK: - Dealing With Presenter "Fetching Data"
extension LeaguesDetailsCollectionViewController {
    func renderLeaguesDetailsToView(result : LeaguesDetailsResponse){
        let allMatches = result.result ?? []

           upComingMatchs = allMatches.filter { $0.eventFinalResult == nil || $0.eventFinalResult  == "-" }
           latestMatchs = allMatches.filter { !($0.eventFinalResult == nil || $0.eventFinalResult  == "-") }

           DispatchQueue.main.async {
               self.collectionView?.reloadData()
           }
    }
    
    func renderTeamDetailsToView(result : TeamDetailsResponse){
         allTeams = result.result ?? []

           DispatchQueue.main.async {
               self.collectionView?.reloadData()
           }
    }
}
