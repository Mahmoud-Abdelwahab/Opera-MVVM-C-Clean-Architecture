//
//  SearchVC.swift
//  Opera
//
//  Created by Mahmoud Abdul-Wahab on 18/06/2021.
//

import UIKit

class SearchVC: BaseViewController2<SearchVM> {
    
    @IBOutlet weak var movieTableView: UITableView!
    
    @IBOutlet weak var searchTF: UITextField!
    
    @IBOutlet weak var noMovieLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindingViews()
    }
}


extension SearchVC{
    
    private func setupViews() {
        // tableview setup
        movieTableView.register(MovieCell.nib(), forCellReuseIdentifier: MovieCell.identifier)
        movieTableView.contentInset = .init(top: 20, left: 0, bottom: 100, right: 0)
        movieTableView.tableFooterView = nextPageLoadingIndicator
    }
    
    private func bindingViews() {
        
        // inputs
        
        searchTF.rx.text.orEmpty
            .bind(to: viewModel.searchForMovie)
            .disposed(by: disposeBag)

        movieTableView.rx.modelSelected(MovieCellVM.self)
            .subscribe(onNext: {
                [weak self] in
                guard let self = self else {return}
                self.viewModel.showMovieDetails(model: $0)
            })
            .disposed(by: disposeBag)
        
        movieTableView.rx
            .contentOffset
            .map{[weak self] _  in
                guard let self = self else { return false }
                return self.movieTableView.isNearBottomEdge()
            }
            .distinctUntilChanged()
            .filter{$0 == true}
            .map{_ in ()}
            .bind(to: viewModel.loadMoreMovies)
            .disposed(by: disposeBag)
        
        // outputs
        
        viewModel.noMovieLableIsHidden
            .bind(to: self.noMovieLable.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.isLoadingNextPage
            .bind(to:nextPageLoadingIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.moviesCellsVMs
            .bind(to : movieTableView.rx.items(cellIdentifier: String(describing: MovieCell.self), cellType: MovieCell.self)) { index, vm , cell in
                cell.viewModel = vm
            }
            .disposed(by: disposeBag)
    }
}
