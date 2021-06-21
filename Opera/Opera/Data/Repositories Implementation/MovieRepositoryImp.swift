//
//  MovieRepositoryImp.swift
//  Opera
//
//  Created by Mahmoud Abdul-Wahab on 20/06/2021.
//

import Foundation
import RxSwift

class MovieRepositoryImp: MoviesRepository {
    
    let  remoteMoviesDataSource = MoviesRemoteDataSource()
    
    func getNowPlaying(page: Int) -> Observable<Page<Movie>> {
        remoteMoviesDataSource.getNowPlaying(page: page)
    }
    
    func getTopRated(page: Int) -> Observable<Page<Movie>> {
        remoteMoviesDataSource.getTopRated(page: page)
    }
    
    func getMovieDetails(id: Int) -> Observable<MovieDetails> {
        remoteMoviesDataSource.getMovieDetails(id: id)
    }
    
    func searchForMovie(searchText: String, page: Int) -> Observable<Page<Movie>> {
        remoteMoviesDataSource.searchWith(searchText, page: page)
    }
    
    
}
