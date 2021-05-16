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
    @IBOutlet weak var watchButton: UIButton!
    
    private var subscribers = Set<AnyCancellable>()
    private(set) var model: ListItemModel? {
        didSet {
            bindModel()
        }
    }

    func updateView(model: ListItemModel) {
        self.model = model
        let movie = model.movie

        title.text = movie.title
        overview.text = movie.overview

        model.fetchImage()
    }

    @IBAction func toggleIsWatched() {
        model?.toggleIsWatched()
    }

    private func bindModel() {
        model?.$imageData
            .sink { [weak imgView] in
            guard let data = $0 else {
                imgView?.image = .placeholder

                return
            }

            imgView?.image = UIImage(data: data) ?? .placeholder
        }
        .store(in: &subscribers)

        model?.$isWatched
            .sink { [weak watchButton] in
                watchButton?.setTitle($0 ? "Watched" : "Not watched", for: .normal)
            }
            .store(in: &subscribers)
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        subscribers.removeAll()


        model = nil
        imageView?.image = nil
    }
}
