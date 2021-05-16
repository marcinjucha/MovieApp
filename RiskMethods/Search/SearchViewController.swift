//
//  SearchViewController.swift
//  RiskMethods
//
//  Created by jucham01 on 16/05/2021.
//

import UIKit
import Combine

class SearchViewController: NibViewController, UISearchBarDelegate {

    @IBOutlet private weak var searchBar: UISearchBar!
    let model: SearchModel

    init(model: SearchModel) {
        self.model = model

        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        model.setup()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        model.search(for: searchText)
    }
}
