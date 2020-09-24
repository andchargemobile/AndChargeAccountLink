//
//  ACURLBuilder.swift
//  AndChargeAccountLink
//
//  Created by Ramesh R C on 24.09.20.
//

import Foundation

import Foundation

class URLBuilder {
    
    private var components: URLComponents

    init() {
        self.components = URLComponents()
    }
    
    func set(scheme: String) -> URLBuilder {
        self.components.scheme = scheme
        return self
    }

    func set(host: String) -> URLBuilder {
        self.components.host = host
        return self
    }
    
    func set(port: Int) -> URLBuilder {
        self.components.port = port
        return self
    }

    func set(path: String) -> URLBuilder {
        var path = path
        if !path.hasPrefix("/") {
            path = "/" + path
        }
        self.components.path = "\(self.components.path)\(path)"
        return self
    }
    
    func set(urlString: String) -> URLBuilder {
        guard let url = URL(string: urlString),
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return self
        }
        self.components = urlComponents
        return self
    }
    
    func addQueryItem(name: String, value: String) -> URLBuilder  {
        if self.components.queryItems == nil {
            self.components.queryItems = []
        }
        self.components.queryItems?.append(URLQueryItem(name: name, value: value))
        return self
    }
    
    func build() -> URL? {
        return self.components.url
    }
}
