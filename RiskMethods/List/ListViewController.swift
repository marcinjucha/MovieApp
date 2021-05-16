//
//  ListViewController.swift
//  RiskMethods
//
//  Created by jucham01 on 16/05/2021.
//

import UIKit
import Combine

class ListViewController: NibViewController {

    @IBOutlet private weak var tableView: UITableView!

    let model: ListModel
    private var itemModels: [ListItemModel] = []
    private var cancellable: AnyCancellable?

    init(model: ListModel) {
        self.model = model

        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
        configureTableView()
    }

    private func bind() {
        cancellable = model.$itemModels
            .sink { [weak self] in
                self?.itemModels = $0
                self?.tableView.reloadData()
            }
    }

    private func configureTableView() {
        tableView.registerNib(ListItemCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)

        let cell = tableView.cellForRow(at: indexPath) as! ListItemCell
        guard let movie = cell.model?.movie else { return }

        model.open(movie: movie)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(at: indexPath) as ListItemCell
        let model = itemModels[indexPath.row]

        cell.updateView(model: model)

        return cell
    }
}
