//
//  MapViewModal.swift
//  tmpr
//
//  Created by Isuru on 2021-08-08.
//

import UIKit
import Foundation
import RxSwift
import MapKit

//MARK: Map View Modal
class MapViewModal {
    private var disposeBag = DisposeBag()
    private var _annotations: [MKPointAnnotation] = []
    private var _jobs: [Job] = []
    
    var selectedCellIndex = PublishSubject<Int>()
    var selectedAnnotationIndex = PublishSubject<Int>()
    var selectedAnnotation = PublishSubject<MKPointAnnotation>()
    
    var jobs = BehaviorSubject<[Job]>(value: [])
    var annotations = BehaviorSubject<[MKAnnotation]>(value: [])
    var centerCoordinate = PublishSubject<CLLocationCoordinate2D>()
    
    init(jobs: [Job]) {
        _jobs = jobs
        makeAnnotations()
    }
    
    func makeAnnotations() {
        _annotations = _jobs.flatMap { (job) -> [MKPointAnnotation] in
            let lat = job.jobDescription?.reportAddress?.geo?.lat ?? 0.0
            let lon = job.jobDescription?.reportAddress?.geo?.lon ?? 0.0
            let location = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            
            let annotation = MKPointAnnotation()
            annotation.title = "€ \(job.earningsPerHour?.amount ?? 0.0)"
            annotation.coordinate = location
            
            return [ annotation ]
        }
        // emit the coordinate, which the map should center
        if let firstAnnotation = _annotations.first {
            centerCoordinate.onNext(firstAnnotation.coordinate)
        }
        
        // emit the annotations
        annotations.onNext(_annotations)
        // emit the jobs
        jobs.onNext(_jobs)
        
        selectedCellIndex.subscribe {
            self.centerCoordinate.onNext(self._annotations[$0].coordinate)
        }.disposed(by: disposeBag)
        
        selectedAnnotation.subscribe {
            self.selectedAnnotationIndex.onNext(self._annotations.firstIndex(of: $0)!)
        }.disposed(by: disposeBag)
    }
    
}
