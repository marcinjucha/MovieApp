//
// Created by jucham01 on 16/05/2021.
//

import UIKit

protocol IdentifiableView {
    static var nibName: String { get }
    static var nibBundle: Bundle { get }
}

extension IdentifiableView {
    static var identifier: String { String(describing: Self.self) }
    static var nibName: String { String(describing: Self.self) }
    static var nibBundle: Bundle { .main }

    static var nib: UINib { .init(nibName: nibName, bundle: nibBundle) }
}

extension UIViewController: IdentifiableView {}
extension UITableViewCell: IdentifiableView {}
