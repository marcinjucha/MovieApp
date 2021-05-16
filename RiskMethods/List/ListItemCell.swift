//
//  ListItemCell.swift
//  RiskMethods
//
//  Created by jucham01 on 16/05/2021.
//

import UIKit
import Combine

class ListItemCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var overview: UILabel!

    private var cancellable: AnyCancellable?
    private var model: ListItemModel?

    func updateView(model: ListItemModel) {
        self.model = model
        let movie = model.movie

        title.text = movie.title
        overview.text = movie.overview

        cancellable = model.$imageData
            .sink { [weak imgView] in
                guard let data = $0 else {
                    imgView?.image = .placeholder

                    return
                }

                imgView?.image = UIImage(data: data) ?? .placeholder
            }
        model.fetchImage()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        cancellable?.cancel()
        cancellable = nil

        model = nil
        imageView?.image = nil
    }
}
