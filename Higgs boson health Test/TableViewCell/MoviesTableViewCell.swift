//
//  MoviesTableViewCell.swift
//  Higgs boson health Test
//
//  Created by Pratik Patil on 26/05/23.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    
    static let identifier = "MoviesTableViewCell"

    @IBOutlet weak var imgMoviePoster: UIImageView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblMovieDetails: UILabel!
    
    var currentItem : MovieModel? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
//    Setting up the UI
    func setupUI() {
        lblMovieName.font = AppFont.setRobotoFont(type: .Regular, size: 13.46)
        lblMovieDetails.font = AppFont.setRobotoFont(type: .Regular, size: 11.54)
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        lblMovieName.text = (currentItem?.title ?? "") + " (\(currentItem?.year ?? ""))"
        lblMovieDetails.text = currentItem?.actors
// Considering this is just POC I have not handled image cashing here.
        if let imageURL = URL(string: currentItem?.poster ?? "") {
            imgMoviePoster.downloaded(from: imageURL)
        }
    }
}
