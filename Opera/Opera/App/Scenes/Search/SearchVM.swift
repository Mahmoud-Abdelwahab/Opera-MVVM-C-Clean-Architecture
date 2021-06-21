//
//  SearchVM.swift
//  Opera
//
//  Created by Mahmoud Abdul-Wahab on 18/06/2021.
//

import Foundation

import RxSwift
import RxCocoa
import XCoordinator
import XCoordinatorRx

class SearchVM: ViewModel {
    
    // MARK: - Inputs
    let input: Input
    
    struct Input {
        let searchText: AnyObserver<String>
       // let isLoadNextPage: AnyObserver<Void>
        let selectedMovie: AnyObserver<MovieCellVM>
    }
    
    // MARK: - Input Private properties
    private let searchTextSubject = PublishSubject<String>()
    //private let isLoadNextPageSubject = PublishSubject<Void>()
    private let selectedMovieSubject = PublishSubject<MovieCellVM>()
    
    // MARK: - Outputs
    let output: Output
    
    struct Output {
        let moviesCellsVMs: Driver<[MovieCellVM]>
        let noMovieLableIsHidden: Driver<Bool>
        //        let isLoading: Driver<Bool>
        let isLoadingNextPage: Driver<Bool>
        let error: Driver<AppError?>
    }
    
    // MARK: - Output Private properties
    private let moviesCellsVMsSubject = PublishSubject<[MovieCellVM]>()
    private let noMovieLableIsHiddenSubject = BehaviorSubject<Bool>(value: false)
    //    private let isLoadingSubject = PublishSubject<Bool>()
    private let isLoadingNextPageSubject = PublishSubject<Bool>()
    private let errorSubject = PublishSubject<AppError?>()
    
    private let imageBaseURL = "https://image.tmdb.org/t/p/w500/"
    private var currentPage = 1
    private var moviesCellsVMs: [MovieCellVM] = []
    
    // MARK: - Private properties
    private let disposeBag = DisposeBag()
    private let router: WeakRouter<BrowsingRoute>
    private let useCase: SearchUseCase
    
    // MARK: - Initialization
    init(router: WeakRouter<BrowsingRoute> , useCase: SearchUseCase) {
        self.router = router
        self.useCase = useCase
        
        input = Input(
            searchText: searchTextSubject.asObserver(),
            selectedMovie: selectedMovieSubject.asObserver()
        )
        
        // MARK: outputs drivers
        
        output = Output(
            moviesCellsVMs: moviesCellsVMsSubject.asDriver(onErrorJustReturn: []), noMovieLableIsHidden: noMovieLableIsHiddenSubject.asDriver(onErrorJustReturn: false), isLoadingNextPage: isLoadingNextPageSubject.asDriver(onErrorJustReturn: false),
            error: errorSubject.asDriver(onErrorJustReturn: nil)
        )
        
        moviesCellsVMsSubject.subscribe(onNext:{[weak self] in
            guard let self = self else {return}
            self.noMovieLableIsHiddenSubject.onNext(!$0.isEmpty)
        }).disposed(by: disposeBag)
        
        searchTextSubject
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .do(onNext:{ [weak self] text in
                guard let self = self else {return}
                self.currentPage = 1
                self.moviesCellsVMs.removeAll()
                self.moviesCellsVMsSubject.onNext([])
                self.errorSubject.onNext(nil)
            })
            .filter { !$0.isEmpty }
            .flatMap { [weak self] text -> Observable<Event<Page<Movie>>> in
                guard let self = self else { return .error(AppError.networkError) }
                self.isLoadingNextPageSubject.onNext(true)
                return self.useCase.searchForMovie(searchText: text, page: self.currentPage).materialize()
            }
            .subscribe(onNext: { [weak self] event in
                guard let self = self else { return }
                self.isLoadingNextPageSubject.onNext(false)
                switch event {
                case .next(let page):
                    self.moviesCellsVMs = self.buildMoviesCellsVMs(page.results)
                    self.moviesCellsVMsSubject.onNext(self.moviesCellsVMs)
                case .error(let error):
                    debugPrint("error getting now playing Movies: \(error)")
                    self.errorSubject.onNext(error as? AppError ?? .with(message: error.localizedDescription))
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
   
        selectedMovieSubject
            .map { $0.id }
            .flatMap { [unowned self] id in self.router.rx.trigger(.details(id)) }
            .subscribe()
            .disposed(by: disposeBag)
        
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
