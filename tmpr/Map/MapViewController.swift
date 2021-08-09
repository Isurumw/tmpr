//
//  MapViewController.swift
//  tmpr
//
//  Created by Isuru on 2021-08-08.
//

import UIKit
import MapKit
import RxSwift
import RxCocoa

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnClose: UIButton!
    
    private let disposeBag = DisposeBag()
    var viewModal: MapViewModal!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        mapView.delegate = self

        setupViewModelListners()
        styling()
    }
    

    func setupViewModelListners() {
        // Load annotations on the map
        viewModal.annotations.subscribe {
            if let annotations = $0.element {
                self.mapView.addAnnotations(annotations)
            }
            self.mapView.fitAll()
        }.disposed(by: disposeBag)
        //Zoom to the annotations
        viewModal.centerCoordinate.subscribe {
            self.mapView.setCenter($0, zoomLevel: 200, animated: true)
        }.disposed(by: disposeBag)
        // scroll to the collection view cell, when the user tapped an annotation
        viewModal.selectedAnnotationIndex.subscribe {
            self.collectionView.scrollToItem(at: IndexPath(item: $0, section: 0), at: .centeredHorizontally, animated: true)
        }.disposed(by: disposeBag)
    }
    
    @IBAction func actionClose(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func styling() {
        btnClose.dropShadow(color: UIColor(named: "Satin")!, opacity: 0.3, offSet: CGSize(width: 1, height: 1), radius: 6)
    }
    
}

extension MapViewController:
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModal._jobs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "JobCollectionCell", for: indexPath) as! JobCollectionViewCell
        cell.updateCell(job: viewModal._jobs[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModal.selectedCellIndex.onNext(indexPath.row)
    }
    
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation as? MKPointAnnotation else {
            return
        }
        
        viewModal.selectedAnnotation.onNext(annotation)
    }
    
}
