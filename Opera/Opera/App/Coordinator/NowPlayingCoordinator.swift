//
//  NowPlayingCoordinator.swift
//  Opera
//
//  Created by Mahmoud Abdul-Wahab on 19/06/2021.
//

import XCoordinator

enum NowPlayingRoute: Route {
    case nowPlaying
  
}

class NowPlayingCoordinator: NavigationCoordinator<NowPlayingRoute> {
    
    // MARK: Initialization
    
    init() {
        super.init(initialRoute: .nowPlaying)
    }
    
    // MARK: Overrides
    
    override func prepareTransition(for route: NowPlayingRoute) -> NavigationTransition {
        switch route {
        case .nowPlaying:
            let nowPlayingVC = NowPlayingVC(viewModel:NowPlayingVM(router: weakRouter))
            nowPlayingVC.title = "Now Playing"
            return .push(nowPlayingVC)
        }
    }
}

