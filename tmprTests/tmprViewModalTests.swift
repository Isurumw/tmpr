//
//  tmprViewModalTests.swift
//  tmprTests
//
//  Created by Isuru on 2021-08-08.
//

import XCTest
import RxSwift
@testable import tmpr

class tmprViewModalTests: XCTestCase {
    var sut: JobsViewModal!
    var disposeBag: DisposeBag!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        disposeBag = DisposeBag()
    }

    override func tearDownWithError() throws {
        sut = nil; disposeBag = nil
        try super.tearDownWithError()
    }
    
    func testWhenReceiveJobsSuccess() {
        let webService = WebServiceMock(mockData: mockJobs(), mockError: nil)
        sut = JobsViewModal(webService: webService)
        let promise = expectation(description: "Value Received")
        
        XCTAssertEqual(sut.loading, false, "the variable loading should be false before fire the api")
        
        sut.jobs.subscribe {
            XCTAssertTrue(($0.element?.count ?? 0) > 0, "the jobs not received successfully")
            promise.fulfill()
        }.disposed(by: disposeBag)
        
        sut.nextPage.onNext(.next)
        
        wait(for: [promise], timeout: 5)
    }
    
    func testWhenReceiveJobsFailed() {
        let webService = WebServiceMock(mockData: nil, mockError: NSError(domain: "test", code: 404, userInfo: nil))
        sut = JobsViewModal(webService: webService)
        
        XCTAssertEqual(sut.loading, false, "the variable loading should be false before fire the api")
        
        sut.loader.subscribe {
            let option = $0.element ?? .none
            XCTAssertTrue(option == .error)
        }.disposed(by: disposeBag)
    }
    
    func mockJobs() -> [Job] {
        let links = Links(
            heroImage: URL(string: "https://tmpr-photos.ams3.digitaloceanspaces.com/hero/108213.jpg"),
            thumbImage: URL(string: "https://tmpr-photos.ams3.digitaloceanspaces.com/thumb48/108213.jpg")
        )
        
        let client = Client(
            id: "8qzvwr",
            name: "IJver",
            links: links
        )
        
        let project = Project(
            id: "xawv9v",
            name: "Algemeen",
            client: client
        )
        
        let geo = Geo(
            lat: 52.401377,
            lon: 4.895125
        )
        
        let address = Address(
            zipCode: "1033WM",
            street: "Scheepsbouwkade",
            city: "Amsterdam",
            geo: geo
        )
        
        let jobDescription = JobDescription(
            id: "xv6vpp",
            title: "Bediening",
            project: project,
            reportAddress: address
        )
        
        let earnings = Earnings(
            currency: "EUR",
            amount: 17.5
        )
        
        return [
            Job(
                id: "6eyyvav",
                jobDescription: jobDescription,
                startsAt: Date(),
                endsAt: (Date().addDate(1)),
                earningsPerHour: earnings,
                distance: 10.5
            )
        ]
    }

}
