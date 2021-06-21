//
//  UIScrollView+Ex.swift
//  Opera
//
//  Created by Mahmoud Abdul-Wahab on 21/06/2021.
//

import UIKit

extension UIScrollView {
    func  isNearBottomEdge(edgeOffset: CGFloat = 20.0) -> Bool {
        self.contentOffset.y + self.frame.size.height + edgeOffset > self.contentSize.height
    }
}
