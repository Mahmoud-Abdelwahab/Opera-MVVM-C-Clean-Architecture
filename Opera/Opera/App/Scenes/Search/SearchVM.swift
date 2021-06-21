//
//  SearchVM.swift
//  Opera
//
//  Created by Mahmoud Abdul-Wahab on 18/06/2021.
//

import Foundation

import RxSwift
//import RxCocoa
import XCoordinator
import XCoordinatorRx

class SearchVM: ViewModel {
    
    // MARK: - Inputs
    let input: Input
    
    struct Input {
      
    }
    
    // MARK: - Input Private properties
 
    
    // MARK: - Outputs
    let output: Output
    
    struct Output {
     
    }
    
    
    // MARK: - Output Private properties
  
    
    
    // MARK: - Private properties
    private let disposeBag = DisposeBag()
    private let router: WeakRouter<BrowsingRoute>

    
    
    // MARK: - Initialization
    init(router: WeakRouter<BrowsingRoute>) {
        self.router = router
  //      self.useCase = useCase
        
        input = Input(
           
        )
        
        // MARK: outputs drivers
        
        output = Output(
           
        )
        
    }
    
}
