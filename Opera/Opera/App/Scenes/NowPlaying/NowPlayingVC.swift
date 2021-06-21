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
        
        //Outputs
        
        viewModel?.output.moviesCellsVMs
            .drive(nowPlayingTableView.rx.items(cellIdentifier: MovieCell.identifier,cellType: MovieCell.self)){_,vm,cell in
                cell.viewModel = vm
            }
            .disposed(by: disposeBag)
    }
  
}


