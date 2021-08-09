//
//  JobsTableViewCell.swift
//  tmpr
//
//  Created by Isuru on 2021-08-06.
//

import UIKit
import SDWebImage

class JobsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel?
    @IBOutlet weak var lblCity: UILabel?
    @IBOutlet weak var lblTimeShift: UILabel?
    @IBOutlet weak var imgJob: UIImageView?
    @IBOutlet weak var lblHourlyCost: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        styling()
    }

    func updateCell(job: Job) {
        lblTitle?.text = job.jobDescription?.title
        
        var distanceText = job.jobDescription?.reportAddress?.city ?? "City"
        if let distance = job.distance {
            distanceText = "\(distanceText) . \(distance)km"
        }
        
        lblCity?.text = distanceText
        imgJob?.sd_setImage(with: job.jobDescription?.project?.client?.links?.heroImage, placeholderImage: UIImage(named: "Placeholder"))
        lblTimeShift?.text = "\(job.startsAt?.formattedTime ?? "...") - \(job.endsAt?.formattedTime ?? "...")"
        lblHourlyCost?.text = "€ \(job.earningsPerHour?.amount ?? 0.0)"
    }
    
    func styling() {
        imgJob?.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 8.0)
    }

}
