//
//  JobsViewModal.swift
//  tmpr
//
//  Created by Isuru on 2021-08-06.
//

import Foundation
import RxSwift

enum NextPage {
    case next
    case initial
    case refresh
    case error
    case none
}

//MARK: Jobs View Modal
class JobsViewModal {
    private var webService: WebServicesProtocol
    private var disposeBag = DisposeBag()
    private let jobsPerPage = 5
    
    var _jobs: [Job] = []
    private var day: Int = 0
    var loading: Bool = false {
        didSet {
            loader.onNext(loading ? option : ((error != nil) ? .error : .none))
        }
    }
    private var option: NextPage = .none
    var error: Error?
    
    var jobCount: Int {
        return _jobs.count
    }
    var fetchJobs: [Job] {
        return _jobs
    }
    
    // the list of job objects
    var jobs = PublishSubject<[Job]>()
    // the top, bottom or main loader of the view controller will appear or disappear, based on the value of this
    var loader = BehaviorSubject<NextPage>(value: .initial)
    // nextPage will be fired from the view vontroller, when the next set of data need to be shown
    var nextPage = BehaviorSubject<NextPage>(value: .initial)
    
    // initialize the view modal with web service
    init(webService: WebServicesProtocol = WebService()) {
        self.webService = webService
        
        nextPage.subscribe {
            self.option = $0.element ?? .none
            /*
                loading == true, means that a api call is on fire, the next api call will be fired only when previous one finished, which means loading == false
             */
            guard !self.loading && self.option != .none else { return }
            /*
                the option == .current, means that user want to refresh the list of job jobs per current day
             */
            self.day = self.option == .refresh ? 0 : self.day
            self.loading = true
            self.error = nil
            self.webService.fetchJobs(noOfDays: self.day) { (jobs) in
                // emit the job details to the view controller, once the responces received
                if self.option == .refresh || self.option == .initial {
                    self._jobs = jobs
                } else {
                    self._jobs.append(contentsOf: jobs)
                }
                self.jobs.onNext(self._jobs)
                
                self.loading = false
                /*
                    The day will be increase by one digit, coz with the next api, it should load the job for `one day after today`
                */
                self.day += 1
                // if the count of the job objects is less than 5, fetch the set of object from next day
                if (self._jobs.count <= self.jobsPerPage) {
                    self.nextPage.onNext(.next)
                }
            } failure: { (error) in
                self.error = error
                self.loading = false
            }
        }.disposed(by: disposeBag)
    }
}
