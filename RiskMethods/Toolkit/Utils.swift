//
// Created by jucham01 on 16/05/2021.
//

import Combine

func justWithError<Output>(_ output: Output) -> AnyPublisher<Output, Error> {
    Just(output).setFailureType(to: Error.self).eraseToAnyPublisher()
}
