//
// Created by jucham01 on 16/05/2021.
//

import UIKit

protocol SystemService {

    func openMovie(withId id: Int)
}

extension UIApplication: SystemService {

    func openMovie(withId id: Int) {
        open(URL(string: "https://www.themoviedb.org/movie/\(id)")!, options: [:], completionHandler: nil)
    }
}
