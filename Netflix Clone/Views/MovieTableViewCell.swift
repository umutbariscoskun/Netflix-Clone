//
//  MovieTableViewCell.swift
//  Netflix Clone
//
//  Created by Umut Barış Çoşkun on 10.01.2023.
//

import UIKit
import SDWebImage

class MovieTableViewCell: UITableViewCell {

 static let identifier = "MovieTableViewCell"
    
    private let playMovieButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .label
        return button
    }()
    
    private let movieLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let moviePosterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(moviePosterImageView)
        contentView.addSubview(movieLabel)
        contentView.addSubview(playMovieButton)
        
        applyConstraints()
    
    }
    
    
    private func applyConstraints() {
        let moviePostureUIImageConstraints = [
            moviePosterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            moviePosterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            moviePosterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            moviePosterImageView.widthAnchor.constraint(equalToConstant: 100),
        
        ]
        
        let movieLabelConstraints = [
            movieLabel.leadingAnchor.constraint(equalTo: moviePosterImageView.trailingAnchor,constant: 20),
            movieLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ]
        
        let playMovieButtonConstraints = [
            playMovieButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            playMovieButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
               ]
        
        NSLayoutConstraint.activate(moviePostureUIImageConstraints)
        NSLayoutConstraint.activate(movieLabelConstraints)
        NSLayoutConstraint.activate(playMovieButtonConstraints)
    }
    
    public func configure(with model: MovieViewModel){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterUrl)") else {return}
        
        moviePosterImageView.sd_setImage(with: url , completed: nil)
        movieLabel.text = model.movieName
    
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}
