//
//  FilterController.swift
//  LambdaTimeline
//
//  Created by Waseem Idelbi on 9/6/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import CoreImage
import CoreImage.CIFilterBuiltins

struct FilterController {
    
    //MARK: - Properties -
    
    let context = CIContext()
    
    let bokehFilter = CIFilter.bokehBlur()
    let hueFilter = CIFilter.hueAdjust()
    let vignetteFilter = CIFilter.vignette()
    let xrayFilter = CIFilter.xRay()
    let sepiaFilter = CIFilter.sepiaTone()
    
    //MARK: - Methods -
    
    func applyBokehFilter(image: UIImage, radius: NSNumber, ringAmount: NSNumber, ringSize: NSNumber, softness: NSNumber) -> UIImage? {
        
        guard let cgImage = image.cgImage else { return nil }
        let ciImage = CIImage(cgImage: cgImage)
        
        bokehFilter.inputImage = ciImage
        bokehFilter.radius = Float(radius)
        bokehFilter.ringAmount = Float(ringAmount)
        bokehFilter.ringSize = Float(ringSize)
        bokehFilter.softness = Float(softness)
        
        guard let outputCIImage = bokehFilter.outputImage else { return nil }
        guard let outputCGImage = context.createCGImage(outputCIImage, from: ciImage.extent) else { return nil }
        
        return UIImage(cgImage: outputCGImage)
    }
    
}
