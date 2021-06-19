//
//  NowPlayingAndTopRatedCoordinator.swift
//  Opera
//
//  Created by Mahmoud Abdul-Wahab on 19/06/2021.
//

import XCoordinator

enum NowPlayingAndTopRatedRoute: Route {
    case topRated
    case nowPlaying
}

class NowPlayingAndTopRatedCoordinator: NavigationCoordinator<NowPlayingAndTopRatedRoute> {
    
    // MARK: Initialization
    
    init(router:NowPlayingAndTopRatedRoute) {
        super.init(initialRoute: router)
    }
    
    // MARK: Overrides
    
    override func prepareTransition(for route: NowPlayingAndTopRatedRoute) -> NavigationTransition {
        switch route {
        case .nowPlaying:
            let nowPlayingVC = NowPlayingVC(viewModel:NowPlayingAndTopRatedVM(router: weakRouter))
            nowPlayingVC.title = "Now Playing"
            return .push(nowPlayingVC)
            
        case .topRated:
            let topRatedVC = TopRatedVC(viewModel:NowPlayingAndTopRatedVM(router: weakRouter))
            topRatedVC.title = "Top Rated"
            return .push(topRatedVC)
        }
    }
}

