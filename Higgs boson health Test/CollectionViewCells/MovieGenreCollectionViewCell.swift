//
//  MovieGenreCollectionViewCell.swift
//  Higgs boson health Test
//
//  Created by Pratik Patil on 29/05/23.
//

import UIKit
// Creating CollectionViewCell
class MovieGenreCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var btnGenreTitle: UIButton!
    
    //    Function to completely configure & populate the cell
    func configureCell(currentGenre: String) {
        
        let colorToSet = UIColor(named: "MovieDetailsTextColor C4C4C4")
        
        btnGenreTitle.titleLabel?.font = AppFont.setRobotoFont(type: .Light, size: 11.54)
        btnGenreTitle.titleLabel?.text = currentGenre
        btnGenreTitle.titleLabel?.textColor = colorToSet
        btnGenreTitle.layer.borderWidth = 0.5
        btnGenreTitle.layer.borderColor = colorToSet?.cgColor
        btnGenreTitle.layer.cornerRadius = 5
    }
}
