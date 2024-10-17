//
//  URLRequest+HTTPMethod.swift
//  MHNetworkingKit
//
//  Created by Milen Halachev on 13.02.19.
//  Copyright © 2019 Milen Halachev. All rights reserved.
//

import Foundation

extension URLRequest {
    
    ///HTTP method
    ///
    ///[Online Reference](https://www.w3.org/Protocols/rfc2616/rfc2616-sec9.html)
    public struct HTTPMethod: RawRepresentable, ExpressibleByStringLiteral, Sendable {
        
        public var rawValue: String
        
        public init(rawValue: String) { self.rawValue = rawValue }
        public init(stringLiteral value: String) { self.rawValue = value }
        public init(method: Method) { self.rawValue = method.rawValue }
        
        public enum Method: String, Sendable {
                case get = "GET"
                case put = "PUT"
                case post = "POST"
                case delete = "DELETE"
                case head = "HEAD"
                case options = "OPTIONS"
                case trace = "TRACE"
                case connect = "CONNECT"
            }
        
        public static var get: Self { .init(method: .get) }
        public static var put: Self { .init(method: .put) }
        public static var post: Self { .init(method: .post) }
        public static var delete: Self { .init(method: .delete) }
        public static var head: Self { .init(method: .head) }
        public static var options: Self { .init(method: .options) }
        public static var trace: Self { .init(method: .trace) }
        public static var connect: Self { .init(method: .connect) }
        
        }
    
    public var method: HTTPMethod? {
        
        get { httpMethod.map { .init(rawValue: $0) }}
        set { httpMethod = newValue?.rawValue }
    }
}

extension URLRequest {
    
    public init(url: URL, method: HTTPMethod) {
        
        self.init(url: url)
        
        self.method = method
    }
    
    public init(url: URL, method: HTTPMethod, contentType: String?, body: Data?) {
        
        self.init(url: url, method: method)
        
        self.setValue(contentType, forHTTPHeaderField: "Content-Type")
        self.httpBody = body
    }
    
    public init(url: URL, cachePolicy: CachePolicy, timeoutInterval: TimeInterval, method: HTTPMethod) {
        
        self.init(url: url, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
        
        self.method = method
    }
    
    public init(url: URL, cachePolicy: CachePolicy, timeoutInterval: TimeInterval, method: HTTPMethod, contentType: String?, body: Data?) {
        
        self.init(url: url, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval, method: method)
        
        self.setValue(contentType, forHTTPHeaderField: "Content-Type")
        self.httpBody = body
    }
}
