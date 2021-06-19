//
//  TopRatedCoordinator.swift
//  Opera
//
//  Created by Mahmoud Abdul-Wahab on 19/06/2021.
//

import XCoordinator

enum TopRatedRoute: Route {
    case topRatedRoute
  
}

class TopRatedCoordinator: NavigationCoordinator<TopRatedRoute> {
    
    // MARK: Initialization
    
    init() {
        super.init(initialRoute: .topRatedRoute)
    }
    
    // MARK: Overrides
    
    override func prepareTransition(for route: TopRatedRoute) -> NavigationTransition {
        switch route {
        case .topRatedRoute:
            let topRatedVC = TopRatedVC(viewModel:TopRatedVM(router: weakRouter))
            topRatedVC.title = "Top Rated"
            return .push(topRatedVC)
        }
    }
}

