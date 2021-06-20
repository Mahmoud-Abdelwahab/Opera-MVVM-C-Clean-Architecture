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
    
    init(movieRepsitory: MoviesRepository) {
        self.movieRepsitory = movieRepsitory
    }
    
    func getMovieDetails(id: Int)->Observable<MovieDetails>{
        movieRepsitory.getMovieDetails(id: id)
    }
    
}
