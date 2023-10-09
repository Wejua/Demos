//
//  YYRequester.swift
//  YYVideo
//
//  Created by zhouweijie on 10/24/19.
//  Copyright © 2019 com.yiyuan. All rights reserved.
//

import UIKit
import Alamofire

class YYRequester: NSObject {
    
    func baseUrl() -> String {
        return bossBaseUrl
    }
    
    func url() -> String {
        return ""
    }
    
    func parameters() -> [String: Any]? {
        return nil
    }
    
    func method() -> HTTPMethod {
        return .post
    }
    
    func header() -> [String: String] {
        let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
        return ["version": YYAPI.version, "source": YYAPI.source, "token": getCookie(), "udid":udid, "yipaiId":getyipaiId()]
    }
    
    private(set) var encoding: ParameterEncoding = JSONEncoding.default
    
    private(set) var isArrayData: Bool = false
    
    func requester<T: Convertible>(modelType: T.Type, completion: @escaping (T?, DataResponse<Any>) -> Void) {
        Alamofire.request(self.baseUrl() + self.url(), method: self.method(), parameters: self.parameters(), encoding: self.encoding, headers: self.header()).responseJSON { (response) in
            if response.error == nil {
                guard let dataDic = response.result.value as? [String:Any] else {
                    completion(nil, response)
                    return
                }
                let model: T? = dataDic.kj.model(T.self)
                completion(model, response)
            }
            completion(nil, response)
        }
    }
    
    func request(completion: @escaping (Error?, DataResponse<Any>) -> Void) {
        Alamofire.request(self.baseUrl() + self.url(), method: self.method(), parameters: self.parameters(), encoding: self.encoding, headers: self.header()).responseJSON { (response) in
            completion(response.error, response)
        }
    }
    
    func request<T: YYBaseModel>(model: T.Type, completion: @escaping (Error?, T?, DataResponse<Any>) -> Void) {
        Alamofire.request(self.baseUrl() + self.url(), method: self.method(), parameters: self.parameters(), encoding: URLEncoding.default, headers: self.header()).responseJSON { (response) in
            if response.error == nil {
                guard let dataDic = (response.result.value as? [String:Any])?["data"] as? [String:Any] else {
                    completion(nil, nil, response)
                    return 
                }
                let model: T? = dataDic.kj.model(T.self)
                completion(nil, model, response)
            } else {
                completion(response.error, nil, response)
            }
        }
    }
    
    func request<T: YYBaseModel>(model: T.Type, encoding: ParameterEncoding, isArrayData: Bool, completion: @escaping (Error?, T?, DataResponse<Any>) -> Void) {
        Alamofire.request(self.baseUrl() + self.url(), method: self.method(), parameters: self.parameters(), encoding: encoding, headers: self.header()).responseJSON { (response) in
            if response.error == nil {
                if isArrayData {
                    guard let dataArr = response.result.value as? [String:Any] else {
                        completion(nil, nil, response)
                        return
                    }
                    let model: T? = dataArr.kj.model(T.self)
                    completion(nil, model, response)
                } else {
                    guard let dataDic = (response.result.value as? [String:Any])?["data"] as? [String:Any] else {
                        completion(nil, nil, response)
                        return
                    }
                    let model: T? = dataDic.kj.model(T.self)
                    completion(nil, model, response)
                }
            } else {
                completion(response.error, nil, response)
            }
        }
    }
    
}

struct JSONStringArrayEncoding: ParameterEncoding {
    private let array: [String]

    init(array: [String]) {
        self.array = array
    }

    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = urlRequest.urlRequest!

        let data = try JSONSerialization.data(withJSONObject: array, options: [])

        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        urlRequest.httpBody = data

        return urlRequest
    }
}

