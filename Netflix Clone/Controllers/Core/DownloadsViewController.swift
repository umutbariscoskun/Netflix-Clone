//
//  DownloadsViewController.swift
//  Netflix Clone
//
//  Created by Umut Barış Çoşkun on 8.01.2023.
//

import UIKit

class DownloadsViewController: UIViewController {

    private var movies: [MovieItem] = [MovieItem]()
    
    
    private let downloadedTable : UITableView = {
        let table = UITableView()
        table.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Downloads"
        view.addSubview(downloadedTable)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        downloadedTable.delegate = self
        downloadedTable.dataSource = self
        fetchLocalStorageForDownload()
    }
    
    private func fetchLocalStorageForDownload() {
        PersistenceManager.shared.fetchDatasFromDatabase { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movies = movies
                DispatchQueue.main.async {
                    self?.downloadedTable.reloadData()
                }
             
            case .failure(let error):
                print(error.localizedDescription)
            
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        downloadedTable.frame = view.bounds
    }


}

extension DownloadsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for:indexPath) as? MovieTableViewCell  else {return UITableViewCell()
        }
        
        let movie = movies[indexPath.row]
        cell.configure(with: MovieViewModel(movieName: (movie.original_title ?? movie.original_name) ?? "Unknown" , posterUrl: movie.poster_path ?? ""))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
          
            PersistenceManager.shared.deleteItemWith(model: movies[indexPath.row]) { [weak self] result in
                switch result {
                case.success():
                    print("Deleted from database")
                case.failure(let error):
                    print(error.localizedDescription)
                
                }
                self?.movies.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
              
            }
        default:
            break;
        }
    }
}
