//
//  APIClient.swift
//  Pokemons
//
//  Created by KreΕ‘imir BakoviΔ on 19/11/2020.
//  Copyright Β© 2020 Kreso Bakovic. All rights reserved.
//

import Foundation
import Combine

final class APIClient {
    static let shared = APIClient()
    private var cancellables = Set<AnyCancellable>()

    let decoder = JSONDecoder()
}

// MARK: - Public methods

extension APIClient {
    func performRequest<T: APIRequest>(_ request: T) -> AnyPublisher<T.ResponseType, Model.ErrorResponse> {
        return URLSession
            .shared
            .dataTaskPublisher(for: request.urlRequest())
            .receive(on: DispatchQueue.main)
            .mapError{ _ in Model.ErrorResponse(code: .unknown) }
            .flatMap { [weak self] data, response -> AnyPublisher<T.ResponseType, Model.ErrorResponse> in
                guard let self = self else { return Fail(error: Model.ErrorResponse(code: .unknown)).eraseToAnyPublisher() }
                if let response = response as? HTTPURLResponse {
                    if (200...299).contains(response.statusCode) {
                        return Just(data)
                            .decode(type: T.ResponseType.self, decoder: self.decoder)
                            .mapError { error in
                                print("π΄π΄π΄π΄π΄\(error)π΄π΄π΄π΄π΄π΄") // TODO: - handle error
                                return Model.ErrorResponse(code: .decodingError) }
                            .eraseToAnyPublisher()
                    } else if response.statusCode == 401 {
                        return Fail(error: Model.ErrorResponse(code: .unknown)).eraseToAnyPublisher()
                    } else {
                        print("π΄π΄π΄π΄π΄\(Date.timeNow): \(response.statusCode)π΄π΄π΄π΄π΄π΄")
                        do {
                            let errorResponse = try self.decoder.decode(Model.ErrorResponse.self, from: data)
                            return Fail(error: errorResponse)
                                .eraseToAnyPublisher()
                        } catch {
                            return Fail(error: Model.ErrorResponse(code: .unknown))
                                .eraseToAnyPublisher()
                        }
                    }
                }
                return Fail(error: Model.ErrorResponse(code: .unknown))
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
