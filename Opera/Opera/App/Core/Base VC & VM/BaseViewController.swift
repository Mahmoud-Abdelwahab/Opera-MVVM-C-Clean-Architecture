//
//  BaseViewController.swift
//  Opera
//
//  Created by Mahmoud Abdul-Wahab on 18/06/2021.
//


import UIKit
import RxSwift

class BaseViewController<T: ViewModel>: UIViewController {
    var viewModel: T!
    let disposeBag = DisposeBag()
    
    init(viewModel: T) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
