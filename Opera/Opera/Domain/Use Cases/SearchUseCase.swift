//
//  SearchUseCase.swift
//  Opera
//
//  Created by Mahmoud Abdul-Wahab on 19/06/2021.
//


import Foundation
import RxSwift

class SearchUseCase{
    
    
    private let movieRepsitory: MoviesRepository
    init( movieRepsitory: MoviesRepository) {
        self.movieRepsitory = movieRepsitory
    }
    
    func searchForMovie(searchText: String, page: Int) -> Observable<Page<Movie>> {
        movieRepsitory.searchForMovie(searchText: searchText, page: page)
    }
    
}
