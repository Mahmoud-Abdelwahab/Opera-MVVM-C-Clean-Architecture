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

    
    
    // MARK: - Initialization
    init(router: WeakRouter<NowPlayingAndTopRatedRoute>) {
        self.router = router
    //    self.useCase = useCase
        
        input = Input(viewDidload: viewDidLoadSubject.asObserver(), showMovieDetails: showMovieDetailsTrigger.asObserver(), loadMoreMovies: loadMoreMoviesTrigger.asObserver() )
        
        // MARK: outputs drivers
        
        output = Output( moviesCellsVMs:moviesCellsVMsSubject.asDriver(onErrorJustReturn: []) )
        
    }
    
}
