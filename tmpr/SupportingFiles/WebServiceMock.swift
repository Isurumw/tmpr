//
//  WebServiceMock.swift
//  tmpr
//
//  Created by Isuru on 2021-08-08.
//

import Foundation

class WebServiceMock: WebServicesProtocol {
    private let mockData: [Job]?
    private let mockError: Error?
    
    init(mockData: [Job]? = nil, mockError: Error? = nil) {
        self.mockData = mockData
        self.mockError = mockError
    }
    
    func fetchJobs(noOfDays: Int, success: @escaping (([Job]) -> ()), failure: @escaping ((Error) -> ())) {
        if let jobs = self.mockData {
            success(jobs)
        } else if let error = self.mockError {
            failure(error)
        }
    }
    
    
    
    
}
