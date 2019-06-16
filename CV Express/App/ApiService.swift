//
//  ApiService.swift
//  CV Express
//
//  Created by Abbey Ola on 14/06/2019.
//  Copyright © 2019 Abbey. All rights reserved.
//

import Foundation
import Alamofire
import Kingfisher
import UIKit

struct ApiService {

    static let shared = ApiService()
    private var host = "https://api.myjson.com/bins/r9hnh"

    func requestCVdata(completion: @escaping (CV?, Error?) -> ()) {
        Alamofire.request(host).cvResponse { response in
            if let error = response.error {
                completion(nil, error)
                return
            }
            if let cv = response.result.value {
                completion(cv, nil)
                return
            }
        }
    }
}

// MARK: - Alamofire response handlers
extension DataRequest {
    fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(error!) }

            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }

            return Result { try JSONDecoder().decode(T.self, from: data) }
        }
    }

    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }

    @discardableResult
    func cvResponse(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<CV>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}
