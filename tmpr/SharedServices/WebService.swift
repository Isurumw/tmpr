//
//  WebService.swift
//  tmpr
//
//  Created by Isuru on 2021-08-06.
//

import Foundation

protocol WebServicesProtocol {
    func fetchJobs(noOfDays: Int, success:@escaping (([Job])->()), failure: @escaping ((Error)->()))
}

class WebService: WebServicesProtocol {
    
    func fetchJobs(noOfDays: Int, success:@escaping (([Job])->()), failure: @escaping ((Error)->())) {
        let day = Date().addDate(noOfDays).formattedDate
        let url = "\(Config.baseUrl)shifts?filter[date]=\(day)"
        
        let request = NetworkManager(url: url, method: .get)
        
        print("api: \(url)")
        NetworkManager.Request(req: request, type: Response.self) { (code) in
            print("status code: \(code)")
        } successCallback: { (response) in
            success(response.data)
        } errorCallback: { (error) in
            failure(error)
        }

        
    }
    
}
