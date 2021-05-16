//
// Created by jucham01 on 16/05/2021.
//

import UIKit

typealias LayoutConstraint = (UIView, UIView) -> NSLayoutConstraint

enum LayoutAnchor {
    case leading, safeAreaLeading
    case trailing, safeAreaTrailing
    case top, safeAreaTop
    case bottom, safeAreaBottom
    case custom(LayoutConstraint)

    static let all: [LayoutAnchor] = [.leading, .trailing, .top, .bottom]

    var constraint: LayoutConstraint { { view, superview in
        switch self {
        case .leading:
            return view.leadingAnchor.constraint(equalTo: superview.leadingAnchor)
        case .trailing:
            return view.trailingAnchor.constraint(equalTo: superview.trailingAnchor)
        case .top:
            return view.topAnchor.constraint(equalTo: superview.topAnchor)
        case .bottom:
            return view.bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        case .safeAreaLeading:
            return view.leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor)
        case .safeAreaTrailing:
            return view.trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor)
        case .safeAreaTop:
            return view.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor)
        case .safeAreaBottom:
            return view.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor)
        case .custom(let provider):
            return provider(view, superview)
        }
    }}
}

extension UIView {

    func layoutConstraints(to superview: UIView, anchors: [LayoutAnchor] = LayoutAnchor.all) {
        guard !anchors.isEmpty else { return }

        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate(anchors.map { $0.constraint(self, superview) })
    }
}
