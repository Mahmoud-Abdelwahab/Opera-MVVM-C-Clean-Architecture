//
//  NowPlayingVC.swift
//  Opera
//
//  Created by Mahmoud Abdul-Wahab on 18/06/2021.
//

import UIKit
import RxSwift
import RxCocoa
class NowPlayingVC: BaseViewController<NowPlayingAndTopRatedVM> {
    
    @IBOutlet weak var nowPlayingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        viewsBinding()
    }
}


extension NowPlayingVC: UITableViewDelegate {
    
    private func configureViewController(){
        nowPlayingTableView.rx.setDelegate(self).disposed(by: disposeBag)
        nowPlayingTableView.register(MovieCell.nib(), forCellReuseIdentifier: MovieCell.identifier)
        nowPlayingTableView.contentInset = .init(top: 0, left: 0, bottom: 100, right: 0)
    }
    
    private func viewsBinding(){
        
        //Inputs
        viewModel.input.viewDidload.onNext(())
        
        nowPlayingTableView.rx
            .modelSelected(MovieCellVM.self)
            .map{$0.id}
            .bind(to: viewModel.input.selectedMovie).disposed(by: disposeBag)
        
        nowPlayingTableView.rx
            .contentOffset
            .map{[weak self] _  in
                guard let self = self else { return false }
                return self.nowPlayingTableView.isNearBottomEdge()
            }
            .distinctUntilChanged()
            .filter{$0 == true}
            .map{_ in ()}
            .bind(to: viewModel.input.loadMoreMovies)
            .disposed(by: disposeBag)
        //Outputs
        
        viewModel.output.isLoadingNextPage
            .drive(nextPageLoadingIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel?.output.moviesCellsVMs
            .drive(nowPlayingTableView.rx.items(cellIdentifier: MovieCell.identifier,cellType: MovieCell.self)){_,vm,cell in
                cell.viewModel = vm
            }
            .disposed(by: disposeBag)
    }
}


