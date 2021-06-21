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
    }
    
    private func bindingViews() {
        
        // inputs
        
        searchTF.rx.text.orEmpty
            .bind(to: viewModel.input.searchText)
            .disposed(by: disposeBag)
        
        movieTableView.rx.modelSelected(MovieCellVM.self)
            .bind(to: viewModel.input.selectedMovie)
            .disposed(by: disposeBag)
        
        
        // outputs
        
        viewModel.output.noMovieLableIsHidden
            .drive(noMovieLable.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.output.moviesCellsVMs
            .drive(movieTableView.rx.items(cellIdentifier: String(describing: MovieCell.self), cellType: MovieCell.self)) { index, vm , cell in
                cell.viewModel = vm
            }
            .disposed(by: disposeBag)
        
        
    }
}
