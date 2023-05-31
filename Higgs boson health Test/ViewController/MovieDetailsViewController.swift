//
//  MovieDetailsViewController.swift
//  Higgs boson health Test
//
//  Created by Pratik Patil on 26/05/23.
//

import UIKit
import Combine

class MovieDetailsViewController: UIViewController {
    
    static let identifier = "MovieDetailsViewController"
    
    var viewModel: MovieDetailsViewModel!
    var cancellables: Set<AnyCancellable> = []
    
    //    MARK: IBOutlets
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionView()
        setUpUI()
        configureButtons()
        bindProperties()
        prepareMovieRating()
        prepareUserReviewDetails()
        viewModel.getGenreList()
        viewModel.getCast()
    }
    
    deinit {
        cancellables.cancelAll()
    }
    
    // MARK: Custom Functions
    // Assigning CollectionView Delegates
    private func setUpCollectionView() {
        collectionCast.delegate = self
        collectionCast.dataSource = self
        
        collectionMovieGenre.delegate = self
        collectionMovieGenre.dataSource = self
    }
    
    // Subscribe movie array to get updates
    private func subscribeMoviesList() {
        viewModel.$genres.receive(on: RunLoop.main).sink { [weak self] genres in
            self?.collectionMovieGenre.reloadData()
        }.store(in: &cancellables)
    }
//    Subscribe cast array to get updates
    private func subscribeCast() {
        viewModel.$cast.receive(on: RunLoop.main).sink { [weak self] cast in
            self?.collectionCast.reloadData()
        }.store(in: &cancellables)
    }
    
    // Binding properties with Data
    private func bindProperties() {
        viewModel.$title.assign(to: \.text!, on: lblMovieTitle).store(in: &cancellables)
        viewModel.$finalTimeValue.assign(to: \.text!, on: lblYearGenreTime).store(in: &cancellables)
        viewModel.$plot.assign(to: \.text!, on: lblMovieDetails).store(in: &cancellables)
        viewModel.$imdbVotes.assign(to: \.text!, on: lblRatingDetails).store(in: &cancellables)
        viewModel.$metascore.assign(to: \.text!, on: lblMetascoreDetails).store(in: &cancellables)
        viewModel.$director.assign(to: \.text!, on: lblDirectorsDetails).store(in: &cancellables)
        viewModel.$writer.assign(to: \.text!, on: lblWritersDetails).store(in: &cancellables)
        viewModel.$awards.assign(to: \.text!, on: lblAwardsDetails).store(in: &cancellables)
        viewModel.$reviewDate.assign(to: \.text!, on: lblUserReviewsDate).store(in: &cancellables)
        viewModel.$plot.assign(to: \.text!, on: lblPlotSummeryDetails).store(in: &cancellables)
        
//        Considering this is just POC I have not handled image cashing here.
        if let imageURL = viewModel.getPosterImageURLString() {
            imgMoviePoster.downloaded(from: imageURL)
        }
    }
    
    // Setting up the UI
    func setUpUI() {
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
    
//    Configuring button UI
    func configureButtons() {
        // Setting attributed text for button titles
        titleSeeAllBtn.titleLabel?.font = AppFont.setRobotoFont(type: .Bold, size: 11.54)
        titleSeeAllBtn.titleLabel?.text = seeAll
        titleSeeAllBtn.titleLabel?.textColor = UIColor(named: buttonTitleColor)
        
        titleSeeAllAwardsBtn.titleLabel?.font = AppFont.setRobotoFont(type: .Bold, size: 11.54)
        titleSeeAllAwardsBtn.titleLabel?.text = seeAll
        titleSeeAllAwardsBtn.titleLabel?.textColor = UIColor(named: buttonTitleColor)
        
        titleSeeAllUserReviewsBtn.titleLabel?.font = AppFont.setRobotoFont(type: .Bold, size: 11.54)
        titleSeeAllUserReviewsBtn.titleLabel?.text = seeAll
        titleSeeAllUserReviewsBtn.titleLabel?.textColor = UIColor(named: buttonTitleColor)
        
        titleAddAReviewBtn.titleLabel?.font = AppFont.setRobotoFont(type: .Bold, size: 11.54)
        titleAddAReviewBtn.titleLabel?.text = addAReview
        titleAddAReviewBtn.titleLabel?.textColor = UIColor(named: buttonTitleColor)
    }
    
    func prepareMovieRating() { // As this includes UIKit related, could not put it into viewModel.
        // Configuring & setting up the attributed string.
        let largerFont = AppFont.setRobotoFont(type: .Regular, size: 17.31)
        let largerFontAttribute :[NSAttributedString.Key:AnyObject] = [NSAttributedString.Key.font : largerFont]
        let largerFontString = NSAttributedString(string: viewModel.getImdbRating(), attributes: largerFontAttribute)
        
        let smallerFont = AppFont.setRobotoFont(type: .Regular, size: 11.54)
        let smallerFontAttribute :[NSAttributedString.Key:AnyObject] = [NSAttributedString.Key.font : smallerFont]
        let smalletFontString = NSAttributedString(string:"/10", attributes: smallerFontAttribute)
        
        let fullAttributedString = NSMutableAttributedString()
        fullAttributedString.append(largerFontString)
        fullAttributedString.append(smalletFontString)
        
        lblMovieRating.attributedText = fullAttributedString
    }
    
    func prepareUserReviewDetails() { // As this includes UIKit related, could not put it into viewModel.
        // Configuring & setting up the attributed string.
        let largerFont = AppFont.setRobotoFont(type: .Light, size: 11.54)
        let largerFontAttributes :[NSAttributedString.Key:AnyObject] = [NSAttributedString.Key.font : largerFont, NSAttributedString.Key.foregroundColor : UIColor.white as AnyObject]
        let largerFontString = NSAttributedString(string:"7", attributes: largerFontAttributes)
        
        let smallerFont = AppFont.setRobotoFont(type: .Light, size: 9.62)
        let smallerFontAttribute :[NSAttributedString.Key:AnyObject] = [NSAttributedString.Key.font : smallerFont, NSAttributedString.Key.foregroundColor : UIColor(named: detailedLabelTextColor) as AnyObject]
        let smallerFontString = NSAttributedString(string:"/10", attributes: smallerFontAttribute)
        
        let combinedAttributedString = NSMutableAttributedString()
        combinedAttributedString.append(largerFontString)
        combinedAttributedString.append(smallerFontString)
        
        lblUserReviewsDetails.attributedText = combinedAttributedString
    }
    
    // MARK: Button Actions
    @IBAction func btnIMDBTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

// Coding with help of collections to keep code seperated, neat & tidy.
// MARK: CollectionView Extension
extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionMovieGenre {
            return viewModel.getNumberOfGenreInSection(section: section)
        }
        else {
            return viewModel.getNumberOfCastInSection(section: section)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellObject = UICollectionViewCell()
        
        if collectionView == collectionMovieGenre {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieGenreCollectionViewCell.identifier, for: indexPath) as? MovieGenreCollectionViewCell {
                
                let currentGenre = viewModel.getGenre(row: indexPath.row)
                cell.configureCell(currentGenre: currentGenre)
                return cell
            }
            return cellObject
        }
        
        else if collectionView == collectionCast {
            if let cell = collectionCast.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.identifier, for: indexPath) as? CastCollectionViewCell {
                
                let currentCastMember = viewModel.getCastMember(row: indexPath.row)
                cell.configureCell(castObject: currentCastMember)
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
