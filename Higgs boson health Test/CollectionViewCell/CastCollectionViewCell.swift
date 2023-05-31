//
//  CastCollectionViewCell.swift
//  Higgs boson health Test
//
//  Created by Pratik Patil on 29/05/23.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {
    static let identifier = "CastCollectionViewCell"
    
    @IBOutlet weak var imgArtist: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblNameInMovie: UILabel!
    
    // Configuring the cell
    override func awakeFromNib() {
        setupUI()
    }
    
    // Setting up the UI
    func setupUI() {
        lblName.font = AppFont.setRobotoFont(type: .Regular, size: 11.54)
        lblNameInMovie.font = AppFont.setRobotoFont(type: .Regular, size: 11.54)
    }
    
    func configureCell(castObject: castStruct) {
        if let image = castObject.image {
            imgArtist.image = UIImage(named: image)
        }
        if let name = castObject.name {
            lblName.text = name
        }
        if let movieName = castObject.movieName {
            lblNameInMovie.text = movieName
        }
    }
}
