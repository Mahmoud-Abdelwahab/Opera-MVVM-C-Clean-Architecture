//
//  MovieCell.swift
//  Opera
//
//  Created by Mahmoud Abdul-Wahab on 19/06/2021.
//

import UIKit
import  SDWebImage

class MovieCell: UITableViewCell {

    static let identifier = "MovieCell"
    
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    var viewModel: MovieCellVM? {
        didSet {
            guard let viewModel = viewModel else { return }
            posterImageView.sd_setImage(with: URL(string: viewModel.posterPath))
            titleLabel.text = viewModel.title
            voteLabel.text = viewModel.vote
            releaseDateLabel.text = viewModel.releaseDate
        }
    }
    
    static func nib()->UINib{
        UINib(nibName: MovieCell.identifier, bundle: Bundle.main)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
