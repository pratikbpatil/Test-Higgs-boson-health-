//
//  MoviesTableViewCell.swift
//  Higgs boson health Test
//
//  Created by Pratik Patil on 26/05/23.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgMoviePoster: UIImageView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblMovieDetails: UILabel!
    
    var currentItem : MovieModel? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        selectionStyle = .none
        lblMovieName.font = AppFont.setRobotoFont(type: .Regular, size: 13.46)
        lblMovieName.text = (currentItem?.Title ?? "") + " (\(currentItem?.Year ?? ""))"
        lblMovieName.font = AppFont.setRobotoFont(type: .Regular, size: 11.54)
        lblMovieDetails.text = currentItem?.Actors
        if let imageURL = URL(string: currentItem?.Poster ?? "") {
            imgMoviePoster.downloaded(from: imageURL)
        }
    }
}
