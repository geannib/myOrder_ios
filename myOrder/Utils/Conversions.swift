//
//  Conversions.swift
//  myOrder
//
//  Created by Apple on 08/02/2019.
//  Copyright © 2019 Manu. All rights reserved.
//

import Foundation
import UIKit


//An iOS point is equivalent to 1/163 of an inch
//This size is always the same regardless of the resolution of the phone it is on, and comes from the 163DPI of the original iPhone

func scaledFont(designSize: CGFloat) -> CGFloat {
    
    let screenHeight = UIScreen.main.bounds.height
    let ret = screenHeight * designSize / 1334.0
    
    return ret
}

func pixelToPoints(px:CGFloat) -> CGFloat {
    
    let pointsPerInch: CGFloat = 72.0; // see: http://en.wikipedia.org/wiki/Point%5Fsize#Current%5FDTP%5Fpoint%5Fsystem
    let scale:CGFloat = 1;
    var pixelPerInch:CGFloat; // DPI
    
    if (UIDevice.current.userInterfaceIdiom == .pad) {
        
        pixelPerInch = 132 * scale
        
    } else if (UIDevice.current.userInterfaceIdiom == .phone) {
        
        pixelPerInch = 163 * scale
        
    } else {
        
        pixelPerInch = 160 * scale;
    }
    
    let points: CGFloat = (px * pointsPerInch / 401.0) * 3;
    
    return points;
}

//https://blog.fluidui.com/designing-for-mobile-101-pixels-points-and-resolutions/
