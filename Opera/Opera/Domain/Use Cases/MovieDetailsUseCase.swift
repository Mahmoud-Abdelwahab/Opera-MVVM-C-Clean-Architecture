//
//  MovieDetailsUseCase.swift
//  Opera
//
//  Created by Mahmoud Abdul-Wahab on 20/06/2021.
//


import Foundation
import RxSwift

class MovieDetailsUseCase{
    
    
    private let movieRepsitory: MoviesRepository
    private let id : Int
    init(id : Int, movieRepsitory: MoviesRepository) {
        self.id             = id
        self.movieRepsitory = movieRepsitory
    }
    
    func getMovieDetails()->Observable<MovieDetails>{
        movieRepsitory.getMovieDetails(id: id)
    }
    
}
