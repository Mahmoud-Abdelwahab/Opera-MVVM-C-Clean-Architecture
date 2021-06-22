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



protocol SearchViewModelInput : BaseInputViewModel {
    var  loadMoreMovies  : PublishSubject<Void> { set get }
    var  searchForMovie  : PublishSubject<String> { set get }
    func showMovieDetails(model: MovieCellVM)
}

protocol SearchViewModelOutput {
    var isLoadingNextPage : PublishSubject<Bool> { get }
    var noMovieLableIsHidden : BehaviorSubject<Bool> { get }
    var moviesCellsVMs : PublishSubject<[MovieCellVM]> { get }
    var error : PublishSubject<AppError> { get }
}

protocol IOViewModel: SearchViewModelOutput,SearchViewModelInput {
    
}

class SearchVM:IOViewModel {


    // MARK: - Input  properties
    var loadMoreMovies  = PublishSubject<Void>()
    var searchForMovie = PublishSubject<String>()

    func viewDidLoad() {
        
    }
    
    func viewWillAppear() {
        
    }
    
    func showMovieDetails(model: MovieCellVM) {
        self.router.rx.trigger(.details(model.id))
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    // MARK: - Output  properties
    var isLoadingNextPage    = PublishSubject<Bool>()
    var noMovieLableIsHidden = BehaviorSubject<Bool>(value: false)
    var moviesCellsVMs       = PublishSubject<[MovieCellVM]>()
    var error                = PublishSubject<AppError>()
    

    private let imageBaseURL = "https://image.tmdb.org/t/p/w500/"
    private var currentPage = 1
    private var moviesCellsDataSource: [MovieCellVM] = []
    
    // MARK: - Private properties
    private let disposeBag = DisposeBag()
    private let router: WeakRouter<BrowsingRoute>
    private let useCase: SearchUseCase
    
    // MARK: - Initialization
    init(router: WeakRouter<BrowsingRoute> , useCase: SearchUseCase) {
        self.router = router
        self.useCase = useCase
            
        moviesCellsVMs.subscribe(onNext:{[weak self] in
            guard let self = self else {return}
            self.noMovieLableIsHidden.onNext(!$0.isEmpty)
        }).disposed(by: disposeBag)
        
      
        searchForMovie
                   .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
                   .distinctUntilChanged()
                   .do(onNext:{ [weak self] text in
                       guard let self = self else {return}
                       self.currentPage = 1
                       self.moviesCellsDataSource.removeAll()
                    self.moviesCellsVMs.onNext([])
                   })
                   .filter { !$0.isEmpty }
                   .flatMap { [weak self] text -> Observable<Event<Page<Movie>>> in
                       guard let self = self else { return .error(AppError.networkError) }
                    self.isLoadingNextPage.onNext(true)
                       return self.useCase.searchForMovie(searchText: text, page: self.currentPage).materialize()
                   }
                   .subscribe(onNext: { [weak self] event in
                       guard let self = self else { return }
                       self.isLoadingNextPage.onNext(false)
                       switch event {
                       case .next(let page):
                           self.moviesCellsDataSource = self.buildMoviesCellsVMs(page.results)
                           self.moviesCellsVMs.onNext(self.moviesCellsDataSource)
                       case .error(let error):
                           debugPrint("error getting now playing Movies: \(error)")
                           self.error.onNext(error as? AppError ?? .with(message: error.localizedDescription))
                       default:
                           break
                       }
                   })
                   .disposed(by: disposeBag)
        
        loadMoreMovies
            .withLatestFrom(searchForMovie)
            .distinctUntilChanged()
            .do(onNext:{ [weak self] text in
                guard let self = self else {return}
                self.currentPage += 1
            })
            .filter { !$0.isEmpty }
            .flatMap { [weak self] text -> Observable<Event<Page<Movie>>> in
                guard let self = self else { return .error(AppError.networkError) }
                self.isLoadingNextPage.onNext(true)
                return self.useCase.searchForMovie(searchText: text, page: self.currentPage).materialize()
            }
            .subscribe(onNext: { [weak self] event in
                guard let self = self else { return }
                self.isLoadingNextPage.onNext(false)
                switch event {
                case .next(let page):
                    self.moviesCellsDataSource = self.buildMoviesCellsVMs(page.results)
                    self.moviesCellsVMs.onNext(self.moviesCellsDataSource)
                case .error(let error):
                    debugPrint("error getting now playing Movies: \(error)")
                    self.error.onNext(error as? AppError ?? .with(message: error.localizedDescription))
                default:
                    break
                }
            })
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
