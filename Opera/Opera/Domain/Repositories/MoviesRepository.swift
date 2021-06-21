//
//  MoviesRepository.swift
//  Opera
//
//  Created by Mahmoud Abdul-Wahab on 20/06/2021.
//

import Foundation
import RxSwift

protocol  MoviesRepository {
    func getNowPlaying(page: Int)->Observable<Page<Movie>>
    func getTopRated(page: Int)->Observable<Page<Movie>>
    func getMovieDetails(id: Int)->Observable<MovieDetails>
    func searchForMovie(searchText: String, page: Int)->Observable<Page<Movie>>
}
