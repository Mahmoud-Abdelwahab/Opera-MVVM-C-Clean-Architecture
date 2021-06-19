//
//  MainTabbarCoordinator.swift
//  Opera
//
//  Created by Mahmoud Abdul-Wahab on 18/06/2021.
//

import UIKit
import XCoordinator

enum MainTabbarRoute: Route {
    case nowPlaying
    case topRated
    case search
}

class MainTabbarCoordinator: TabBarCoordinator<MainTabbarRoute> {
    
    // MARK: Initialization
    
    init() {
//        let initialRoute = con.is_login() ? AppRoute.main : AppRoute.auth
        let customTabBar = TextyTabBarController()
        
        let nowPlayingCoordinator = NowPlayingCoordinator()
        let nowPlayingBarItem = TextyTabBarItem(title: "Now Playing", image: #imageLiteral(resourceName: "icon-play"), tag: 0)
        nowPlayingBarItem.color = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        nowPlayingCoordinator.rootViewController.tabBarItem = nowPlayingBarItem

        let topRatedCoordinator   = TopRatedCoordinator()
        let topRatedBarItem = TextyTabBarItem(title: "Top Rated", image: #imageLiteral(resourceName: "icon-like"), tag: 1)
        topRatedBarItem.color     = #colorLiteral(red: 0.5141925812, green: 0.5142051578, blue: 0.5141984224, alpha: 1)
        topRatedCoordinator.rootViewController.tabBarItem = topRatedBarItem
        
        let searchCoordinator     = SearchCoordinator()
        let searchBarItem = TextyTabBarItem(title: "Search", image:  #imageLiteral(resourceName: "icon-search"), tag: 2)
        searchBarItem.color     = #colorLiteral(red: 0.5141925812, green: 0.5142051578, blue: 0.5141984224, alpha: 1)
        searchCoordinator.rootViewController.tabBarItem = searchBarItem
        
        customTabBar.viewControllers = [nowPlayingCoordinator.rootViewController, topRatedCoordinator.rootViewController, searchCoordinator.rootViewController]
        
        super.init(rootViewController: customTabBar, tabs: [nowPlayingCoordinator,topRatedCoordinator,searchCoordinator])
    }
    
    // MARK: Overrides
    
    override func prepareTransition(for route: MainTabbarRoute) -> TabBarTransition {
        switch route {
        
        case .nowPlaying:
            return .select(index: 0)

        case .topRated:
            return .select(index: 1)

        case .search:
            return .select(index: 2)

        }
    }
    
}
