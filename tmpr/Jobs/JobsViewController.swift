//
//  JobsViewController.swift
//  tmpr
//
//  Created by Isuru on 2021-08-06.
//

import UIKit
import RxSwift
import RxCocoa
import RappleProgressHUD

class JobsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var conBottomTableView: NSLayoutConstraint!
    
    private var viewModal: JobsViewModal!
    private let disposeBag = DisposeBag()
    private let attributes = RappleActivityIndicatorView.attribute(style: .circle)

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        
        // configure the pull to refresh on tableView
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        setupViewModelListners()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // hide the nav bar for jobs view controller
        navigationController?.navigationBar.isHidden = true
        // hide the navigation back button title for all the view controllers throught the app
        navigationController?.navigationBar.topItem?.title = ""
        // Hide the border of the navigation bar for all the view controllers throught the app
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // show back the navigation bar, when navigating to an another view controllers
        navigationController?.navigationBar.isHidden = false
    }
    
    @objc func refresh(refreshControl: UIRefreshControl) {
        viewModal.nextPage.onNext(.refresh)
    }

    func setupViewModelListners() {
        // Setup the view model listners for jobs view controller
        viewModal = JobsViewModal()
        
        // listen to the fetch jobs web service and update the tableview, once the responces received
        viewModal.jobs.bind(to: tableView.rx.items(cellIdentifier: "JobsCell")){ index, job, cell in
            // cast the cell as the class type
            if let cell = cell as? JobsTableViewCell {
                // Update the table view cell with the job details
                cell.updateCell(job: job)
            }
        }.disposed(by: disposeBag)
        // listen to the observer `loader`, which desired what loader should appear in the screen and which should disappear
        viewModal.loader.subscribe {
            let option = $0.element ?? .none
   
            if option == .next {
                self.conBottomTableView.constant = 55.0
            } else if option == .initial {
                RappleActivityIndicatorView.startAnimating(attributes: RappleModernAttributes)
            } else if option == .none || option == .error {
                RappleActivityIndicatorView.stopAnimation(
                    completionIndicator: (option == .error ? .failed : .success),
                    completionLabel: option == .error ? "FAILED_TO_LOAD_JOBS".localized : nil,
                    completionTimeout: 1.0
                )
                self.tableView.refreshControl?.endRefreshing()
                self.conBottomTableView.constant = 20.0
            }
        }.disposed(by: disposeBag)
    }
    
    @IBAction func actionGetIn(_ sender: CustomButton) {
        let vc = sender.tag == 1 ? navSignup() : navSignin()
        //navigate to the sign-up or sign-in view controllers based on the tag of the button
        navigationController?.pushViewController(vc, animated: true)

        // modaly present the sign-up or sign-in view controllers based on the tag of the button
//         present(vc, animated: true, completion: nil)
    }
    
    @IBAction func actionMap(_ sender: UIButton) {
        let vc = navMap()
        vc.viewModal = MapViewModal(jobs: self.viewModal.fetchJobs)
        present(vc, animated: true, completion: nil)
    }
    
}

//MARK: UITableView delegate methods
extension JobsViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        // Determined the user has reached the bottom of the scroll view
        if distanceFromBottom < height && viewModal.jobCount > 0 {
            viewModal.nextPage.onNext(.next)
        }
    }
    
}
