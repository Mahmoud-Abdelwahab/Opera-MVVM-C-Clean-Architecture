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
    }

}


extension NowPlayingVC{
    private func configureViewController(){
        nowPlayingTableView.register(MovieCell.nib(), forCellReuseIdentifier: MovieCell.identifier)
    }
}
