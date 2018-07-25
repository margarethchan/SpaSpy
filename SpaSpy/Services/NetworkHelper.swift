//
//  NetworkHelper.swift
//  SpaSpy
//
//  Created by C4Q on 7/5/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

struct NetworkHelper {
    private init() {}
    static let manager = NetworkHelper()
    let session = URLSession(configuration: .default)
    func performDataTask(with request: URLRequest, completionHandler: @escaping (Data) -> Void, errorHandler: @escaping (Error) -> Void) {
        let myDataTask = session.dataTask(with: request) {(data, response, error) in
            DispatchQueue.main.async {
                guard let data = data else { errorHandler(error!); return }
                if let dataStr = String(data: data, encoding: .utf8) {
                    print(dataStr)
                }
                completionHandler(data)
            }
        }
        myDataTask.resume()
    }
}

