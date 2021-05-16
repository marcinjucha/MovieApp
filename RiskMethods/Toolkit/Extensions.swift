//
//  Extensions.swift
//  RiskMethods
//
//  Created by jucham01 on 16/05/2021.
//

import UIKit

extension UIViewController {

    func embedChild(_ child: UIViewController, in containerView: UIView? = nil, anchors: [LayoutAnchor] = []) {
        let view: UIView = containerView ?? view

        child.willMove(toParent: self)
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)

        child.view.layoutConstraints(to: view, anchors: anchors)
    }
}

extension UITableView {

    func registerNib<T: UITableViewCell>(_ type: T.Type = T.self) where T: IdentifiableView {
        register(T.nib, forCellReuseIdentifier: T.identifier)
    }

    func dequeueCell<T: UITableViewCell & IdentifiableView>(at index: IndexPath) -> T {
        dequeueReusableCell(withIdentifier: T.identifier, for: index) as! T
    }

}