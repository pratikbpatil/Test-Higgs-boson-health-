//
//  ViewController.swift
//  Higgs boson health Test
//
//  Created by Pratik Patil on 26/05/23.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet weak var movieTable: UITableView!
    @IBOutlet weak var lblIMDBTitle: UILabel!
    
    let viewModel = MovieListViewModel()
    
    var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
        self.setupUI()
        self.subscribeMoviesList()
        self.viewModel.parseMoviesRecords()
    }
    
    deinit {
        cancellables.cancelAll()
    }
    
    // MARK: Custom Functions
    
    private func setupTableView() {
        movieTable.delegate = self
        movieTable.dataSource = self
    }
    
    // Setting up UI
    private func setupUI() {
        lblIMDBTitle.font = AppFont.setRobotoFont(type: .Bold, size: 17.31)
    }
    
    // Subscribe movie array to get updates
    private func subscribeMoviesList() {
        viewModel.$movies.receive(on: RunLoop.main).sink { [weak self] movies in
            self?.movieTable.reloadData()
        }.store(in: &cancellables)
    }
    
}

//  MARK: TableView Delegate Methods
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = movieTable.dequeueReusableCell(withIdentifier: MoviesTableViewCell.identifier, for: indexPath) as? MoviesTableViewCell else {return UITableViewCell()}
        
        let movie = viewModel.getMovieModel(row: indexPath.row)
        cell.currentItem = movie
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: MovieDetailsViewController.identifier) as? MovieDetailsViewController {
            let movie = viewModel.getMovieModel(row: indexPath.row)
            let viewModel = MovieDetailsViewModel(movie: movie)
            vc.viewModel = viewModel
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

