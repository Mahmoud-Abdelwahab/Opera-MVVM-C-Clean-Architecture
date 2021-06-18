//
//  Transition+Ex.swift
//  Opera
//
//  Created by Mahmoud Abdul-Wahab on 18/06/2021.
//

import UIKit
import XCoordinator

extension Transition{
    
    static func switchTo(_ presentable: Presentable, in container: Container) -> Transition {
        for viewController in container.viewController.children {
            viewController.willMove(toParent: nil)
            viewController.view.removeFromSuperview()
            viewController.removeFromParent()
        }
        return embed(presentable, in: container)
    }
}
