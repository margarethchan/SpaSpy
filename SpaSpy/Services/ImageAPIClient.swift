//
//  ImageAPIClient.swift
//  SpaSpy
//
//  Created by C4Q on 7/5/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import UIKit

class ImageAPIClient {
    private init() {}
    static let manager = ImageAPIClient()
    func loadImage(from urlStr: String,
                   completionHandler: @escaping (UIImage) -> Void,
                   errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlStr) else {return}
        let completion = {(data: Data) in
            guard let onlineImage = UIImage(data: data) else { return }
            completionHandler(onlineImage)
        }
        NetworkHelper.manager.performDataTask(with: URLRequest(url: url),
                                              completionHandler: completion,
                                              errorHandler: errorHandler)
    }
}
