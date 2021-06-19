//
//  OnBoardingCoordinator.swift
//  Opera
//
//  Created by Mahmoud Abdul-Wahab on 18/06/2021.
//


import UIKit
import XCoordinator

enum OnBoardingRoute: Route {
    case mainTabBar
    case onboarding
}

class OnBoardingCoordinator: NavigationCoordinator<OnBoardingRoute> {
    
    // MARK: Initialization
    
    init() {
        super.init(initialRoute: .onboarding)
    }
    
    // MARK: Overrides
    
    override func prepareTransition(for route: OnBoardingRoute) -> NavigationTransition {
        switch route {
        case .onboarding:
            return .none()
        case .mainTabBar:
            return .none()
        }
    }
    
}
