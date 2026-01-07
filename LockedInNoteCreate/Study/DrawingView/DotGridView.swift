//
//  DotGridView.swift
//  LockedInNoteCreate
//
//  Created by Kevin Nhan on 2026-01-06.
//


import SwiftUI
import PencilKit

// Dot Grid
class DotGridView: UIView {
    var gridSpacing: CGFloat = 25
    var dotRadius: CGFloat = 1.5
    var dotColor: UIColor = .systemGray3
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(dotColor.cgColor)
        
        let columns = Int(rect.width / gridSpacing)
        let rows = Int(rect.height / gridSpacing)
        
        for i in 0...columns {
            for j in 0...rows {
                let x = CGFloat(i) * gridSpacing
                let y = CGFloat(j) * gridSpacing
                let dotRect = CGRect(x: x - dotRadius, y: y - dotRadius, width: dotRadius * 2, height: dotRadius * 2)
                context.fillEllipse(in: dotRect)
            }
        }
    }
}
