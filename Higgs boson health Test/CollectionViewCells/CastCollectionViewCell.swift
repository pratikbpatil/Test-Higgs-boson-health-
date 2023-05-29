//
//  CastCollectionViewCell.swift
//  Higgs boson health Test
//
//  Created by Pratik Patil on 29/05/23.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgArtist: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblNameInMovie: UILabel!
    
    //    Configuring the cell
    func configureCell(castObject: castStruct) {
        
        if let image = castObject.image {
            imgArtist.image = UIImage(named: image)
        }
        if let name = castObject.name {
            lblName.font = AppFont.setRobotoFont(type: .Regular, size: 11.54)
            lblName.text = name
        }
        if let movieName = castObject.movieName {
            lblNameInMovie.font = AppFont.setRobotoFont(type: .Regular, size: 11.54)
            
            lblNameInMovie.text = movieName
        }
    }
}
