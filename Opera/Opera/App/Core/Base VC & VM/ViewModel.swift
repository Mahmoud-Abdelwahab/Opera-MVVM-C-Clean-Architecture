//
//  ViewModel.swift
//  Opera
//
//  Created by Mahmoud Abdul-Wahab on 18/06/2021.
//


import Foundation

protocol ViewModel {
    associatedtype Input
    associatedtype Output
    
    var input: Input { get }
    var output: Output { get }
}
