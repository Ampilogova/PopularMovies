//
//  MovieCell.swift
//  Movies
//
//  Created by Tatiana Ampilogova on 6/4/22.
//

import Foundation
import UIKit

class MovieCell: UITableViewCell {
    
    private var title: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .heavy)
        return label
    }()
    
    private var overview: UILabel = {
        var label = UILabel()
        label.numberOfLines = 5
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        title.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
        ])
        
        overview.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(overview)
        NSLayoutConstraint.activate([
            overview.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 6),
            overview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            overview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
            overview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: Movie) {
        self.title.text = model.title
        self.overview.text = model.overview
    }
}
