//
//  SitesCell.swift
//  WebAlarm
//
//  Created by Soo Jang on 2023/03/03.
//

import UIKit

class SitesCell: UICollectionViewCell {
    var data: UIImage? {
        didSet {
            guard let data = data else { return }
            thumnailImg.image = data
        }
    }
    let thumnailImg: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(thumnailImg)

        NSLayoutConstraint.activate([
            thumnailImg.topAnchor.constraint(equalTo: contentView.topAnchor),
            thumnailImg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            thumnailImg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            thumnailImg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
