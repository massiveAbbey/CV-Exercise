//
//  AppService.swift
//  CV Express
//
//  Created by Abbey Ola on 15/06/2019.
//  Copyright © 2019 Abbey. All rights reserved.
//

import Foundation

class AppService {

    private var apiService: ApiService?
    var networkTaskFinishWithError: (() -> ())?
    var updateLoadingState: (() -> ())?
    var didFinishNetworkTask: (() -> ())?

    init(apiService: ApiService) {
        self.apiService = apiService
    }

    var cv: CV? {
        didSet {
            self.didFinishNetworkTask?()
        }
    }

    var error: Error? {
        didSet { self.networkTaskFinishWithError?() }
    }

    var isLoading: Bool = false {
        didSet { self.updateLoadingState?() }
    }

    func getCV() {
        self.apiService?.requestCVdata(completion: { (cv, error) in
            self.isLoading = false
            if let error = error {
                self.error = error
                return
            }
            self.error = nil
            self.cv = cv
        })
    }
}
