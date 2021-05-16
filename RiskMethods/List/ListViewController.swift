//
//  ListViewController.swift
//  RiskMethods
//
//  Created by jucham01 on 16/05/2021.
//

import UIKit

class ListViewController: NibViewController {

    var movies: [Movie] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    @IBOutlet private weak var tableView: UITableView!
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService

        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerNib(ListItemCell.self)
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
    }
}

extension ListViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(at: indexPath) as ListItemCell
        let movie = movies[indexPath.row]

        cell.updateView(model: .init(networkService: networkService, movie: movie))

        return cell
    }
}
