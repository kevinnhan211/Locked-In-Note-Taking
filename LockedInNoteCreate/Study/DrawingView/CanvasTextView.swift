//
//  CanvasTextView.swift
//  LockedInNoteCreate
//
//  Created by Kevin Nhan on 2026-01-08.
//


import UIKit

final class CanvasTextView: UITextView {
    weak var fontPickerDelegate: UIFontPickerViewControllerDelegate?
    var onRequestFontPicker: (() -> Void)?

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func configure() {
        backgroundColor = .clear
        isScrollEnabled = false
        font = .systemFont(ofSize: 20)
        textColor = .label
        textAlignment = .left

        layer.borderWidth = 1
        layer.cornerRadius = 6
        layer.borderColor = UIColor.clear.cgColor
    }

    func setSelected(_ selected: Bool) {
        layer.borderColor = selected ? UIColor.systemBlue.cgColor : UIColor.clear.cgColor
    }

    // MARK: - Apple-style formatting menu
    override func buildMenu(with builder: UIMenuBuilder) {
        super.buildMenu(with: builder)
        
        let fontAction = UIAction(title: "Font…") { _ in
            self.onRequestFontPicker?()
        }

        let increaseSize = UIAction(title: "Increase Size") { _ in
            self.font = self.font?.withSize((self.font?.pointSize ?? 17) + 2)
        }

        let decreaseSize = UIAction(title: "Decrease Size") { _ in
            self.font = self.font?.withSize((self.font?.pointSize ?? 17) - 2)
        }

        let black = UIAction(title: "Black") { _ in
            self.textColor = .label
        }

        let red = UIAction(title: "Red") { _ in
            self.textColor = .systemRed
        }

        let blue = UIAction(title: "Blue") { _ in
            self.textColor = .systemBlue
        }

        let sizeMenu = UIMenu(title: "Size", children: [increaseSize, decreaseSize])
        let colorMenu = UIMenu(title: "Color", children: [black, red, blue])
        let fontMenu = UIMenu(title: "Font", children: [fontAction])

        let textMenu = UIMenu(title: "Text Style", children: [sizeMenu, colorMenu, fontMenu])

        builder.insertChild(textMenu, atStartOfMenu: .format)
    }
}
