//
//  GenreCell.swift
//  Opera
//
//  Created by Mahmoud Abdul-Wahab on 21/06/2021.
//

import UIKit

class GenreCell: UICollectionViewCell {
    static var identifier = "GenreCell"
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var bgColor: UIView!
    
    var viewModel: String? {
        didSet {
            guard let viewModel = viewModel else { return }
            titleLable.text = viewModel
            bgColor.backgroundColor = DesignSystem.getColorFor(viewModel)
        }
    }
    
    static func nib()->UINib{
        UINib(nibName: "GenreCell", bundle: Bundle.main)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
