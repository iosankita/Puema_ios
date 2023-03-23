//
//  URL+Extension.swift
//  Pneuma
//
//  Created by Chitra on 24/02/21.
//  Copyright © 2021 iTechnolabs. All rights reserved.
//

import AVFoundation
import UIKit

extension URL {
    func imageThumbnail(fromTime time: Float64 = 0) -> UIImage? {
        let imageGenerator = AVAssetImageGenerator(asset: AVAsset(url: self))
        imageGenerator.appliesPreferredTrackTransform = true
        let time = CMTimeMakeWithSeconds(time, preferredTimescale: 1)
        var actualTime = CMTimeMake(value: 0, timescale: 0)

        guard let cgImage = try? imageGenerator.copyCGImage(at: time, actualTime: &actualTime) else {
            return nil
        }
        return UIImage(cgImage: cgImage)
    }
}

