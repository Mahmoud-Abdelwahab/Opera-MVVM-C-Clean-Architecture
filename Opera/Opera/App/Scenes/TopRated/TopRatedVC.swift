//
//  TopRatedVC.swift
//  Opera
//
//  Created by Mahmoud Abdul-Wahab on 18/06/2021.
//

import UIKit

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
        
        
        //Outputs
        
        viewModel?.output.moviesCellsVMs
            .drive(topMoviesTableView.rx.items(cellIdentifier: MovieCell.identifier,cellType: MovieCell.self)){_,vm,cell in
                cell.viewModel = vm
            }
            .disposed(by: disposeBag)
        
       
        
    }
  
}


