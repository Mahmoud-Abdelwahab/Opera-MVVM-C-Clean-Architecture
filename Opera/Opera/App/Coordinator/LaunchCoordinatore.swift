//
//  LaunchCoordinatore.swift
//  Opera
//
//  Created by Mahmoud Abdul-Wahab on 18/06/2021.
//

import UIKit
import XCoordinator

enum AppRoute: Route {
    case mainTabBar
    case onboarding
}

class AppCoordinator: ViewCoordinator<AppRoute> {
    
    // MARK: Initialization
    
    init() {
//        let initialRoute = con.is_login() ? AppRoute.main : AppRoute.auth
        super.init(rootViewController: UIViewController(), initialRoute: .onboarding)
    }
    
    // MARK: Overrides
    
    override func prepareTransition(for route: AppRoute) -> ViewTransition {
        switch route {
        case .onboarding:
            return .switchTo(OnBoardingCoordinator(router: weakRouter), in: rootViewController)
        case .mainTabBar:
//            return .switchTo(MainCoordinator(router: weakRouter), in: rootViewController)
            return .switchTo(NavigationalTabCoordinator(router: weakRouter), in: rootViewController)
        }
    }
    
}
