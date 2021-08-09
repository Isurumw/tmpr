//
//  NetworkManager.swift
//  tmpr
//
//  Created by Isuru on 2021-08-06.
//

import Foundation
import Alamofire

typealias StatusCallBack = (_ statusCode: Int) -> Void
typealias SuccessDataCallback = (_ result: Data) -> Void
typealias ErrorCallback = (_ error: Error) -> Void

class NetworkManager: NSObject {
    
    var url: String?
    var parameters: [String : Any]?
    var headers: HTTPHeaders?
    var method: HTTPMethod?
    
    init(url: String, method: HTTPMethod) {
        self.url = url
        self.method = method
    }
    
    init(url: String, method: HTTPMethod, headers: [String : String]) {
        self.url = url
        self.method = method
        self.headers = HTTPHeaders(headers)
    }
    
    
    class func Request<T: Codable>(req: NetworkManager, type: T.Type, statusCallBack: @escaping StatusCallBack, successCallback: @escaping (_ result: T) -> Void, errorCallback: @escaping ErrorCallback) {
        execute(req: req, statusCallBack: { (code) in
            statusCallBack(code)
        }, successCallback: { (data) in
            do {
                // convert the data response into the requested object type
                let jsonDecoder = JSONDecoder()
                let model = try jsonDecoder.decode(type, from: data)
                successCallback(model)
            } catch let error {
                errorCallback(error)
            }
        }) { (error) in
            errorCallback(error)
        }
    }
    
    private class func execute(req: NetworkManager, statusCallBack: @escaping StatusCallBack, successCallback: @escaping SuccessDataCallback, errorCallback: @escaping ErrorCallback) {
        
        let encodingType: ParameterEncoding = req.parameters == nil ? URLEncoding.default : JSONEncoding.default
        let requestParams: Parameters = req.parameters == nil ? [:] : req.parameters!
        
        let manager = Alamofire.Session.default
        let request = manager.request(req.url!, method: req.method!, parameters: requestParams, encoding: encodingType, headers: req.headers)
        
        // request the data through internet from api
        request.responseJSON { (response) in
            let status = response.response?.statusCode ?? 1002
            
            // check if the request is authorized or not
            if reAuthenticate(status, statusCallBack, successCallback, errorCallback, req) {
                return
            }
            // if the request is authorized, move forward to see whether there are any api errors or not
            statusCallBack(status)
            
            switch response.result {
            case .success(_):
                if let result = response.data {
                    // When the request is success and received the correct response
                    successCallback(result)
                } else {
                    // When the request is success but requested data is missing, So there should be an error
                    errorCallback(NSError(domain: "Internal server error", code: 1002, userInfo: nil))
                }
                break
            case .failure(let error):
                // When the request failed
                errorCallback(error)
                break
            }
        }
    }
    
    private class func reAuthenticate(_ status: Int, _ statusCallBack: @escaping StatusCallBack,_ successCallback: @escaping SuccessDataCallback,_ errorCallback: @escaping ErrorCallback,_ req: NetworkManager) -> Bool {
        // TODO: Check status code as well as if there is an auth token available
        if status == 403 {
            logout()
            return true
        }
        return false
    }
    
    class func logout() {
        // TODO: Remove the token from app's local cash and redirect to the login screen
    }
    
}
