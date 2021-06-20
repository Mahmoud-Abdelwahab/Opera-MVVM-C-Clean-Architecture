//
//  MovieListUseCase.swift
//  Opera
//
//  Created by Mahmoud Abdul-Wahab on 19/06/2021.
//

import Foundation
import RxSwift

class MovieListUseCase{
    
    enum Browsing {
        case nowPlaying
        case topRated
    }
    
    private let movieRepsitory: MoviesRepository
    private let browsing: Browsing
    
    init(movieRepsitory: MoviesRepository , browsing: Browsing) {
        self.movieRepsitory = movieRepsitory
        self.browsing       = browsing
    }
    
    func getMovies(page: Int)->Observable<Page<Movie>>{
        switch browsing {
        case .nowPlaying:
            return movieRepsitory.getNowPlaying(page: page)
        case .topRated:
            return movieRepsitory.getTopRated(page: page)
        }
    }
    
}
