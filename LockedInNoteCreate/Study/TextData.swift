//
//  TextData.swift
//  LockedInNoteCreate
//
//  Created by Kevin Nhan on 2026-01-10.
//


import UIKit

struct TextData: Identifiable, Codable {
    let id: UUID

    var text: String
    var centerX: CGFloat
    var centerY: CGFloat
    var width: CGFloat
    var height: CGFloat

    var fontName: String
    var fontSize: CGFloat

    var textColorRed: CGFloat
    var textColorGreen: CGFloat
    var textColorBlue: CGFloat
    var textColorAlpha: CGFloat
}
