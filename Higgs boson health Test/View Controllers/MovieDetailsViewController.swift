//
//  MovieDetailsViewController.swift
//  Higgs boson health Test
//
//  Created by Pratik Patil on 26/05/23.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    var movieDetails : MovieModel? = nil
    
    let castCollectionReuseIdentifier = "CastCollectionViewCell"
    let genreCollectionReuseIdentifier = "MovieGenreCollectionViewCell"
    
    // Creating Outlets
    
    @IBOutlet weak var lblYearGenreTime: UILabel!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var imgMoviePoster: UIImageView!
    @IBOutlet weak var lblMovieDetails: UILabel!
    @IBOutlet weak var collectionMovieGenre: UICollectionView!
    @IBOutlet weak var lblMovieRating: UILabel!
    @IBOutlet weak var lblRatingDetails: UILabel!
    @IBOutlet weak var lblMetascoreDetails: UILabel!
    
    @IBOutlet weak var collectionCast: UICollectionView!
    @IBOutlet weak var lblDirectorsDetails: UILabel!
    @IBOutlet weak var lblWritersDetails: UILabel!
    @IBOutlet weak var lblAwardsDetails: UILabel!
    @IBOutlet weak var lblUserReviewsDetails: UILabel!
    @IBOutlet weak var lblUserReviewsTitle: UILabel!
    @IBOutlet weak var lblUserReviewsDate: UILabel!
    @IBOutlet weak var lblUserReviewsDescription: UILabel!
    
    @IBOutlet weak var lblContentRatingDetails: UILabel!
    @IBOutlet weak var lblPlotSummeryDetails: UILabel!
    
    // Creating Outlets for Font only
    
    @IBOutlet weak var titleAwardsLbl: UILabel!
    @IBOutlet weak var titleWatchOnNetflixLbl: UILabel!
    @IBOutlet weak var titleWithSubscriptionLbl: UILabel!
    @IBOutlet weak var titleAddToWatchlistLbl: UILabel!
    @IBOutlet weak var titleRateThisLbl: UILabel!
    @IBOutlet weak var titleMetascoreLbl: UILabel!
    @IBOutlet weak var titleTopBilledCastLbl: UILabel!
    @IBOutlet weak var titleSeeAllBtn: UIButton!
    @IBOutlet weak var titleDirectorsLbl: UILabel!
    @IBOutlet weak var titleWritersLbl: UILabel!
    @IBOutlet weak var titleSeeAllAwardsBtn: UIButton!
    
    @IBOutlet weak var titleSeeAllUserReviewsBtn: UIButton!
    @IBOutlet weak var titleUserReviewsLbl: UILabel!
    @IBOutlet weak var titleAddAReviewBtn: UIButton!
    @IBOutlet weak var titleParentsGuideLbl: UILabel!
    @IBOutlet weak var titleContentRatingLbl: UILabel!
    @IBOutlet weak var titleStorylineLbl: UILabel!
    @IBOutlet weak var titlePlotSummeryLbl: UILabel!
    
    // Arrays for CollectionView
    var genreArray = [String]()
    var castArray = [castStruct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //      Assigning CollectionView Delegates
        collectionCast.delegate = self
        collectionCast.dataSource = self
        
        collectionMovieGenre.delegate = self
        collectionMovieGenre.dataSource = self
        
        // Setting only fonts in this method
        setFonts()
        
        // Populating data & configurating views in this method
        populateMovieDetails()
    }
    
    //    MARK: setFonts()
    func setFonts() {
        lblMovieTitle.font = AppFont.setRobotoFont(type: .Light, size: 25)
        lblYearGenreTime.font = AppFont.setRobotoFont(type: .Light, size: 13.46)
        lblMovieDetails.font = AppFont.setRobotoFont(type: .Regular, size: 11.54)
        titleWatchOnNetflixLbl.font = AppFont.setRobotoFont(type: .Regular, size: 11.54)
        titleWithSubscriptionLbl.font = AppFont.setRobotoFont(type: .Light, size: 11.54)
        titleAddToWatchlistLbl.font = AppFont.setRobotoFont(type: .Regular, size: 11.54)
        lblRatingDetails.font = AppFont.setRobotoFont(type: .Regular, size: 11.54)
        titleRateThisLbl.font = AppFont.setRobotoFont(type: .Regular, size: 13.46)
        titleMetascoreLbl.font = AppFont.setRobotoFont(type: .Regular, size: 13.46)
        lblMetascoreDetails.font = AppFont.setRobotoFont(type: .Regular, size: 11.54)
        titleTopBilledCastLbl.font = AppFont.setRobotoFont(type: .Regular, size: 17.31)
        titleDirectorsLbl.font = AppFont.setRobotoFont(type: .Regular, size: 11.54)
        lblDirectorsDetails.font = AppFont.setRobotoFont(type: .Regular, size: 11.54)
        titleWritersLbl.font = AppFont.setRobotoFont(type: .Regular, size: 11.54)
        lblWritersDetails.font = AppFont.setRobotoFont(type: .Regular, size: 11.54)
        titleAwardsLbl.font = AppFont.setRobotoFont(type: .Regular, size: 17.31)
        lblAwardsDetails.font = AppFont.setRobotoFont(type: .Regular, size: 13.46)
        titleUserReviewsLbl.font = AppFont.setRobotoFont(type: .Regular, size: 17.31)
        lblUserReviewsTitle.font = AppFont.setRobotoFont(type: .Light, size: 11.54)
        lblUserReviewsDate.font = AppFont.setRobotoFont(type: .Light, size: 9.62)
        lblUserReviewsDate.font = AppFont.setRobotoFont(type: .Regular, size: 10.58)
        titleParentsGuideLbl.font = AppFont.setRobotoFont(type: .Regular, size: 17.31)
        titleContentRatingLbl.font = AppFont.setRobotoFont(type: .Regular, size: 11.54)
        lblContentRatingDetails.font = AppFont.setRobotoFont(type: .Regular, size: 11.54)
        titleStorylineLbl.font = AppFont.setRobotoFont(type: .Regular, size: 17.31)
        titlePlotSummeryLbl.font = AppFont.setRobotoFont(type: .Regular, size: 11.54)
        lblPlotSummeryDetails.font = AppFont.setRobotoFont(type: .Regular, size: 11.54)
    }
    
    //    MARK: populateMovieDetails()
    func populateMovieDetails() {
        lblMovieTitle.text = movieDetails?.Title
        
        let stringTime = movieDetails?.Runtime ?? ""
        let array = stringTime.split(separator: " ")
        
        if let runtimeInMinutes = Int(array[0]) {
            let convertedTime = minutesToHoursAndMinutes(runtimeInMinutes)
            let finalTime = "\(convertedTime.hours)" + "h " + "\(convertedTime.leftMinutes)" + "m"
            
            lblYearGenreTime.text = (movieDetails?.Year ?? "") + "  " + (movieDetails?.Rated ?? "") + "  " + finalTime
        }
        
        if let imagePosterURL = URL(string: movieDetails?.Poster ?? "") {
            //            Setting Image from URL
            imgMoviePoster.downloaded(from: imagePosterURL)
        }
        
        if let genreString = movieDetails?.Genre as? String {
            let filteredString = genreString.replacingOccurrences(of: ",", with: "", options: NSString.CompareOptions.literal, range: nil)
            
            let arr = filteredString.split(separator: " ")
            for i in arr {
                genreArray.append("\(i)")
            }
        }
        
        lblMovieDetails.text = movieDetails?.Plot
        if let imdbRating = movieDetails?.imdbRating {
            //            Configuring & setting up the attributed string
            let labelFont1 = AppFont.setRobotoFont(type: .Regular, size: 17.31)
            let attributes1 :[NSAttributedString.Key:AnyObject] = [NSAttributedString.Key.font : labelFont1]
            let attrString1 = NSAttributedString(string:imdbRating, attributes: attributes1)
            
            let labelFont2 = AppFont.setRobotoFont(type: .Regular, size: 11.54)
            let attributes2 :[NSAttributedString.Key:AnyObject] = [NSAttributedString.Key.font : labelFont2]
            let attrString2 = NSAttributedString(string:"/10", attributes: attributes2)
            
            let fullAttributedString = NSMutableAttributedString()
            fullAttributedString.append(attrString1)
            fullAttributedString.append(attrString2)
            
            lblMovieRating.attributedText = fullAttributedString
        }
        
        lblRatingDetails.text = movieDetails?.imdbVotes
        if let metascore = movieDetails?.Metascore {
            lblMetascoreDetails.text = "\(metascore) critic reviews"
        }
        
        //        Configuring & populating Cast Array for CollectionView
        if let actors = movieDetails?.Actors {
            
            let arr = actors.split(separator: ",")
            castArray.append(castStruct(name: "\(arr[0])", movieName: "Neo", image: "image 1.jpg"))
            castArray.append(castStruct(name: "\(arr[1])", movieName: "Morpheus", image: "image 2.jpg"))
            castArray.append(castStruct(name: "\(arr[2])", movieName: "Trinity", image: "image 3.jpg"))
            
        }
        
        lblDirectorsDetails.text = movieDetails?.Director
        lblWritersDetails.text = movieDetails?.Writer
        lblAwardsDetails.text = movieDetails?.Awards
        lblUserReviewsDate.text = movieDetails?.DVD
        lblPlotSummeryDetails.text = movieDetails?.Plot
        
        //        Setting attributed text for button titles
        titleSeeAllBtn.titleLabel?.font = AppFont.setRobotoFont(type: .Bold, size: 11.54)
        titleSeeAllBtn.titleLabel?.text = "SEE ALL"
        titleSeeAllBtn.titleLabel?.textColor = UIColor(named: "ButtonTitleColor 3996C9")
        
        
        titleSeeAllAwardsBtn.titleLabel?.font = AppFont.setRobotoFont(type: .Bold, size: 11.54)
        titleSeeAllAwardsBtn.titleLabel?.text = "SEE ALL"
        titleSeeAllAwardsBtn.titleLabel?.textColor = UIColor(named: "ButtonTitleColor 3996C9")
        
        
        titleSeeAllUserReviewsBtn.titleLabel?.font = AppFont.setRobotoFont(type: .Bold, size: 11.54)
        titleSeeAllUserReviewsBtn.titleLabel?.text = "SEE ALL"
        titleSeeAllUserReviewsBtn.titleLabel?.textColor = UIColor(named: "ButtonTitleColor 3996C9")
        
        titleAddAReviewBtn.titleLabel?.font = AppFont.setRobotoFont(type: .Bold, size: 11.54)
        titleAddAReviewBtn.titleLabel?.text = "ADD A REVIEW"
        titleAddAReviewBtn.titleLabel?.textColor = UIColor(named: "ButtonTitleColor 3996C9")
        
        //        Making Attributed string for label text
        let labelFont3 = AppFont.setRobotoFont(type: .Light, size: 11.54)
        let attributes3 :[NSAttributedString.Key:AnyObject] = [NSAttributedString.Key.font : labelFont3, NSAttributedString.Key.foregroundColor : UIColor.white as AnyObject]
        let attrString3 = NSAttributedString(string:"7", attributes: attributes3)
        
        let labelFont4 = AppFont.setRobotoFont(type: .Light, size: 9.62)
        let attributes4 :[NSAttributedString.Key:AnyObject] = [NSAttributedString.Key.font : labelFont4, NSAttributedString.Key.foregroundColor : UIColor(named: "DetailedLabelTextColor 949596") as AnyObject]
        let attrString4 = NSAttributedString(string:"/10", attributes: attributes4)
        
        let fullAttributedMovieRatingString = NSMutableAttributedString()
        fullAttributedMovieRatingString.append(attrString3)
        fullAttributedMovieRatingString.append(attrString4)
        
        lblUserReviewsDetails.attributedText = fullAttributedMovieRatingString
    }
    
    func minutesToHoursAndMinutes(_ minutes: Int) -> (hours: Int , leftMinutes: Int) {
        return (minutes / 60, (minutes % 60))
    }
    
    // MARK: Button Actions
    
    @IBAction func btnIMDBTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// Coding with help of collections to keep code seperated, neat & tidy
// MARK: CollectionView Extension
extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionMovieGenre {
            return genreArray.count
        }
        else {
            return castArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellObject = UICollectionViewCell()
        
        if collectionView == collectionMovieGenre {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: genreCollectionReuseIdentifier, for: indexPath) as? MovieGenreCollectionViewCell {
                //                 Configuring the cell
                cell.configureCell(currentGenre: genreArray[indexPath.item])
                return cell
            }
            return cellObject
        }
        
        else if collectionView == collectionCast {
            if let cell = collectionCast.dequeueReusableCell(withReuseIdentifier: castCollectionReuseIdentifier, for: indexPath) as? CastCollectionViewCell {
                //                Configuring the cell
                cell.configureCell(castObject: castArray[indexPath.item])
                return cell
            }
            return cellObject
        }
        
        return cellObject
    }
}
// Method for configuring the collectionViewCellSize
extension MovieDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionMovieGenre {
            return CGSize(width: 80, height: 30)
        }
        else if collectionView == collectionCast {
            return CGSize(width: 155, height: 275)
        }
        return CGSize.zero
    }
}
