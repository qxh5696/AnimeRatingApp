//
//  CGLayerExtensions.swift
//  AnimeBrowsingApp
//
//  Created by qh on 7/16/20.
//  Copyright © 2020 qadir haqq. All rights reserved.
//

import Foundation

import UIKit

extension CALayer {
    func bringSublayerToFront(layer: CALayer, otherLayer: CALayer) {
        layer.removeFromSuperlayer()
        self.insertSublayer(layer, at: UInt32(self.sublayers!.count))
    }

    func sendSublayerToBack(layer: CALayer) {
        layer.removeFromSuperlayer()
        self.insertSublayer(layer, at: 0)
    }
}
