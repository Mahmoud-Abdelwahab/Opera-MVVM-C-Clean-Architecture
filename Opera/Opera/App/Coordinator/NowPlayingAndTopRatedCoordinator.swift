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
    case details(Int)
    case dismiss
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
            let nowPlayingVC = NowPlayingVC(viewModel:NowPlayingAndTopRatedVM(router: weakRouter, useCase: MovieListUseCase(movieRepsitory: MovieRepositoryImp(), browsing: .nowPlaying)))
            nowPlayingVC.title = "Now Playing"
            return .push(nowPlayingVC)
            
        case .topRated:
            let topRatedVC = TopRatedVC(viewModel:NowPlayingAndTopRatedVM(router: weakRouter, useCase: MovieListUseCase(movieRepsitory: MovieRepositoryImp(), browsing: .topRated)))
            topRatedVC.title = "Top Rated"
            return .push(topRatedVC)
            
        case .details(let id):
            let movieDetailsVC = MovieDetailsVC(
                viewModel: MovieDetailsVM(
                    router: weakRouter,
                    useCase: MovieDetailsUseCase(id: id, movieRepsitory: MovieRepositoryImp())
                )
            )
            
            movieDetailsVC.title = "Movie Details"
            movieDetailsVC.modalPresentationStyle = .fullScreen
            return .present(movieDetailsVC)
        
        case .dismiss:
            return .dismiss()
        }
        
    }
}

