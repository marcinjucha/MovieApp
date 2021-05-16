//
//  ViewController.swift
//  RiskMethods
//
//  Created by jucham01 on 16/05/2021.
//

import UIKit

class ContainerViewController: UIViewController {

    let label = UILabel()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = label
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = "YO"
        label.textColor = .white
    }

}

