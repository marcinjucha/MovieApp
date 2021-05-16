//
//  ViewController.swift
//  RiskMethods
//
//  Created by jucham01 on 16/05/2021.
//

import UIKit

class ContainerViewController: BaseViewController {

    let model: ContainerModel

    private lazy var search = SearchViewController(model: model.searchModel)
    private lazy var list = ListViewController(model: model.listModel)

    init(model: ContainerModel) {
        self.model = model

        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Movie list"
        model.setup()

        embedChild(search, anchors: [.leading, .top, .trailing])
        embedChild(list, anchors: [.leading, .trailing, .bottom])

        list.view.layoutConstraints(to: search.view, anchors: [
            .custom({ $0.topAnchor.constraint(equalTo: $1.bottomAnchor) })
        ])
    }
}
