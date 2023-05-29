//
//  ViewController.swift
//  Higgs boson health Test
//
//  Created by Pratik Patil on 26/05/23.
//

import UIKit

class ViewController: UIViewController {
    
    let cellIdentifier = "MoviesTableViewCell"
    let identifier = "MovieDetailsViewController"
    
    @IBOutlet weak var movieTable: UITableView!
    
    @IBOutlet weak var lblIMDBTitle: UILabel!
    
    var movieArray: [MovieModel]? {
        didSet{
            DispatchQueue.main.async {
                self.movieTable.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        movieTable.delegate = self
        movieTable.dataSource = self
        
        lblIMDBTitle.font = AppFont.setRobotoFont(type: .Bold, size: 17.31)
        
        //        Fetching the data from JSON File.
        if let moviesData = FetchDataFromJSON.sharedInstance.readMovieData() {
            debugPrint(moviesData)
            self.movieArray = moviesData
        }
        
    }
    
}

//  MARK: TableView Delegate Methods
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = movieTable.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MoviesTableViewCell else {return UITableViewCell()}
        
        if let object = movieArray?[indexPath.row] {
            cell.currentItem = object
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: identifier) as? MovieDetailsViewController {
            if let object = movieArray?[indexPath.row] {
                vc.movieDetails = object
            }
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

