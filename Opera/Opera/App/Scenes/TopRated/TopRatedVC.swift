//
//  TopRatedVC.swift
//  Opera
//
//  Created by Mahmoud Abdul-Wahab on 18/06/2021.
//

import UIKit
import RxSwift

class TopRatedVC: BaseViewController<NowPlayingAndTopRatedVM> {
    
    @IBOutlet weak var topMoviesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        viewsBinding()
    }
}


extension TopRatedVC: UITableViewDelegate {
    
    private func configureViewController(){
        topMoviesTableView.rx.setDelegate(self).disposed(by: disposeBag)
        topMoviesTableView.register(MovieCell.nib(), forCellReuseIdentifier: MovieCell.identifier)
        topMoviesTableView.contentInset = .init(top: 0, left: 0, bottom: 100, right: 0)
    }
    
    private func viewsBinding(){
        
        //Inputs
        viewModel.input.viewDidload.onNext(())
        
        topMoviesTableView.rx
            .modelSelected(MovieCellVM.self)
            .map{$0.id}
            .bind(to: viewModel.input.selectedMovie).disposed(by: disposeBag)
        
        topMoviesTableView.rx
            .contentOffset
            .map{[weak self] _  in
                guard let self = self else { return false }
                return self.topMoviesTableView.isNearBottomEdge()
            }
            .distinctUntilChanged()
            .filter{$0 == true}
            .map{_ in ()}
            .bind(to: viewModel.input.loadMoreMovies)
            .disposed(by: disposeBag)
        //Outputs
        
        viewModel?.output.moviesCellsVMs
            .drive(topMoviesTableView.rx.items(cellIdentifier: MovieCell.identifier,cellType: MovieCell.self)){_,vm,cell in
                cell.viewModel = vm
            }
            .disposed(by: disposeBag)
    }
}


