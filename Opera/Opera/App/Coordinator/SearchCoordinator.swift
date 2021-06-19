//
//  SearchCoordinator.swift
//  Opera
//
//  Created by Mahmoud Abdul-Wahab on 19/06/2021.
//

import XCoordinator

enum SearchRoute: Route {
    case searchRoute
}

class SearchCoordinator: NavigationCoordinator<SearchRoute> {
    
    // MARK: Initialization
    
    init() {
        super.init(initialRoute: .searchRoute)
    }
    
    // MARK: Overrides
    
    override func prepareTransition(for route: SearchRoute) -> NavigationTransition {
        switch route {
        case .searchRoute:
            let searchVC = SearchVC(viewModel:SearchVM(router: weakRouter))
            searchVC.title = "Search"
            return .push(searchVC)
        }
    }
}

