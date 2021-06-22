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
    
     let nextPageLoadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(frame: .init(x: 0, y: 0, width: 50, height: 50))
        indicator.hidesWhenStopped = true
        indicator.color = DesignSystem.Color.search.UIColor
        indicator.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        indicator.startAnimating()
        indicator.isHidden = true
        return indicator
    }()
            
    init(viewModel: T) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}


import UIKit
import RxSwift

class BaseViewController2<T: IOViewModel>: UIViewController {
    var viewModel: T!
    let disposeBag = DisposeBag()
    
     let nextPageLoadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(frame: .init(x: 0, y: 0, width: 50, height: 50))
        indicator.hidesWhenStopped = true
        indicator.color = DesignSystem.Color.search.UIColor
        indicator.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        indicator.startAnimating()
        indicator.isHidden = true
        return indicator
    }()
            
    init(viewModel: T) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
