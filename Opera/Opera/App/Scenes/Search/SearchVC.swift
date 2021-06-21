//
//  SearchVC.swift
//  Opera
//
//  Created by Mahmoud Abdul-Wahab on 18/06/2021.
//

import UIKit

class SearchVC: BaseViewController<SearchVM> {
    
    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var searchTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
}


extension SearchVC{
    
    private func setupViews() {
        // tableview setup
        movieTableView.register(MovieCell.nib(), forCellReuseIdentifier: MovieCell.identifier)
        movieTableView.contentInset = .init(top: 20, left: 0, bottom: 100, right: 0)
    }
    
    private func bind() {
        // outputs
        viewModel.output.moviesCellsVMs
            .drive(movieTableView.rx.items(cellIdentifier: String(describing: MovieCell.self), cellType: MovieCell.self)) { index, vm , cell in
                cell.viewModel = vm
            }
            .disposed(by: disposeBag)
        
//        viewModel.output.isLoading
//            .drive(loadingIndicator.rx.isAnimating)
//            .disposed(by: disposeBag)
//
//        viewModel.output.isLoadingNextPage
//            .map { !$0 }
//            .drive(nextPageLoadingIndicator.rx.isHidden)
//            .disposed(by: disposeBag)
//
//        viewModel.output.error
//            .drive(onNext: { [weak self] error in
//                guard let self = self else { return }
//                self.setupStateViewWith(error)
//            })
//            .disposed(by: disposeBag)
        
        // inputs
//        Observable.merge(searchTF.rx.controlEvent(.editingDidEndOnExit).map { () }, searchButton.rx.tap.map { () })
//            .withLatestFrom(searchTextField.rx.text.orEmpty)
//            .do(onNext: { [weak self] _ in self?.searchTextField.resignFirstResponder() })
//            .bind(to: viewModel.input.searchWithText)
//            .disposed(by: disposeBag)
//
//        movieTableView.rx.contentOffset
//            .map { [weak self] _ in
//                guard let self = self else { return false }
//                return self.tableView.isNearBottomEdge()
//            }
//            .distinctUntilChanged()
//            .filter { $0 == true }
//            .map { _ in () }
//            .bind(to: viewModel.input.loadNextPage)
//            .disposed(by: disposeBag)
        
        movieTableView.rx.modelSelected(MovieCellVM.self)
            .bind(to: viewModel.input.selectedMovie)
            .disposed(by: disposeBag)
    }
}
