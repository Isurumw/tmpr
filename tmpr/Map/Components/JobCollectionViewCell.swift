//
//  JobCollectionViewCell.swift
//  tmpr
//
//  Created by Isuru on 2021-08-09.
//

import UIKit
import SDWebImage

class JobCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgJob: UIImageView?
    @IBOutlet weak var lblHourlyCost: UILabel?
    @IBOutlet weak var lblTimeShift: UILabel?
    @IBOutlet weak var lblTitle: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        styling()
    }
    
    func updateCell(job: Job) {
        DispatchQueue.main.async {
            self.lblTitle?.text = job.jobDescription?.title
            self.imgJob?.sd_setImage(with: job.jobDescription?.project?.client?.links?.heroImage, placeholderImage: UIImage(named: "Placeholder"))
            self.lblTimeShift?.text = "\(job.startsAt?.formattedTime ?? "...") - \(job.endsAt?.formattedTime ?? "...")"
            self.lblHourlyCost?.text = "€ \(job.earningsPerHour?.amount ?? 0.0)"
        }
    }
    
    func styling() {
        imgJob?.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 8.0)
    }
    
}
