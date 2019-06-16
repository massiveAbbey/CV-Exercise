//
//  EducationCell.swift
//  CV Express
//
//  Created by Abbey Ola on 16/06/2019.
//  Copyright © 2019 Abbey. All rights reserved.
//

import Foundation
import UIKit
import EasyPeasy

class EducationCell: UITableViewCell {

    let schoolLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        label.textAlignment = .left
        return label
    }()

    let degreeLAbel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.textAlignment = .left
        return label
    }()

    let yearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.textAlignment = .left
        label.textColor = .gray
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(schoolLabel)
        contentView.addSubview(degreeLAbel)
        contentView.addSubview(yearLabel)

        schoolLabel.textAlignment = .left
        degreeLAbel.textAlignment = .left
        yearLabel.textAlignment = .left

        schoolLabel.easy.layout(
            Top(8),
            Left(16),
            Right(16))

        degreeLAbel.easy.layout(
            Top(4).to(schoolLabel),
            Left(16),
            Right(16))

        yearLabel.easy.layout(
            Top(4).to(degreeLAbel),
            Left(16),
            Right(16))

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
