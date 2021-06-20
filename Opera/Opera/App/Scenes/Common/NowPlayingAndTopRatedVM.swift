//
//  NowPlayingAndTopRatedVM.swift
//  Opera
//
//  Created by Mahmoud Abdul-Wahab on 18/06/2021.
//

import Foundation

import RxSwift
import RxCocoa
import XCoordinator
import XCoordinatorRx

class NowPlayingAndTopRatedVM: ViewModel {
    
    // MARK: - Inputs
    let input: Input
    
    struct Input {
        let viewDidload     : AnyObserver<Void>
        let showMovieDetails: AnyObserver<Int>
        let loadMoreMovies  : AnyObserver<Void>
    }
    
    // MARK: - Input Private properties
    private let viewDidLoadSubject         = PublishSubject<Void>()
    private let showMovieDetailsTrigger    = PublishSubject<Int>()
    private let loadMoreMoviesTrigger      = PublishSubject<Void>()
    // MARK: - Outputs
    let output: Output
    
    struct Output {
        let moviesCellsVMs: Driver<[MovieCellVM]>
    }
    
    // MARK: - Output Private properties
  private let moviesCellsVMsSubject = PublishSubject<[MovieCellVM]>()
    
    
    // MARK: - Private properties
    private let disposeBag = DisposeBag()
    private let router: WeakRouter<NowPlayingAndTopRatedRoute>
    private let useCase: MovieListUseCase
    private let imageBaseURL = "https://image.tmdb.org/t/p/w500/"
    private var currentPage = 1
    private var moviesCellsVMs: [MovieCellVM] = []
    
    // MARK: - Initialization
    init(router: WeakRouter<NowPlayingAndTopRatedRoute>, useCase: MovieListUseCase) {
        self.router = router
        self.useCase = useCase
        
        // MARK: Inputs observables
        input = Input(viewDidload: viewDidLoadSubject.asObserver(), showMovieDetails: showMovieDetailsTrigger.asObserver(), loadMoreMovies: loadMoreMoviesTrigger.asObserver() )
        
        // MARK: outputs drivers
        
        output = Output( moviesCellsVMs:moviesCellsVMsSubject.asDriver(onErrorJustReturn: []) )
        
        
        viewDidLoadSubject
            .flatMap{[weak self] _ -> Observable<Event<Page<Movie>>> in
                    guard let self = self else { return .error(AppError.networkError) }
                    return self.useCase.getMovies(page: self.currentPage).materialize()
            }
            .retry(3)
            .subscribe(onNext:{ [weak self]  event in
                guard let self = self else {return}
                switch event{
                case .next(let page):
                    self.moviesCellsVMs += self.buildMoviesCellsVMs(page.results)
                    self.moviesCellsVMsSubject.onNext(self.moviesCellsVMs)
                case .error(let error):
                    debugPrint("error getting now playing Movies: \(error)")
               default:
                    break
                }
            }).disposed(by: disposeBag)
        
    }
    
    private func buildMoviesCellsVMs(_ movies: [Movie]) -> [MovieCellVM] {
        movies.map { movie in
            .init(
                id: movie.id,
                posterPath: imageBaseURL + (movie.posterPath ?? ""),
                title: movie.title,
                vote: "\(movie.vote)",
                releaseDate: movie.releaseDate.toAppDate
            )
        }
    }
}
