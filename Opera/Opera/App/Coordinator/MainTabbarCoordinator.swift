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
        super.init(initialRoute: .nowPlaying)
    }
    
    // MARK: Overrides
    
    override func prepareTransition(for route: MainTabbarRoute) -> ViewTransition {
        switch route {
        
        case .nowPlaying:
            
        case .topRated:

        case .search:

        }
    }
    
}
