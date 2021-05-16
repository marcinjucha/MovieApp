//
//  ViewController.swift
//  RiskMethods
//
//  Created by jucham01 on 16/05/2021.
//

import UIKit
import Combine

class ContainerViewController: BaseViewController {

    private lazy var search = SearchViewController(model: .init(networkService: networkService))
    private lazy var list = ListViewController(networkService: networkService)
    private let networkService: NetworkService

    private var cancellable: AnyCancellable?

    init(networkService: NetworkService) {
        self.networkService = networkService

        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Movie list"

        embedChild(search, anchors: [.leading, .top, .trailing])
        embedChild(list, anchors: [.leading, .trailing, .bottom])

        list.view.layoutConstraints(to: search.view, anchors: [
            .custom({ $0.topAnchor.constraint(equalTo: $1.bottomAnchor) })
        ])

        cancellable = search.model.$movies
            .sink { [weak list] movies in
            list?.movies = movies }
    }
}
