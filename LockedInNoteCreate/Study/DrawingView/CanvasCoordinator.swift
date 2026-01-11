//
//  CanvasCoordinator.swift
//  LockedInNoteCreate
//
//  Created by Kevin Nhan on 2026-01-08.
//


import UIKit
import PencilKit

final class CanvasCoordinator: NSObject,
                               PKCanvasViewDelegate,
                               UITextViewDelegate,
                               UIFontPickerViewControllerDelegate {

    // MARK: - References
    let parent: CanvasView
    
    weak var selectedTextView: CanvasTextView?
    var textViews: [CanvasTextView] = []

    init(parent: CanvasView) {
        self.parent = parent
    }

    // MARK: - Tap Handling
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        guard parent.isTextModeEnabled else { return }
        guard let canvas = gesture.view as? PKCanvasView else { return }

        let location = canvas.convert(
            gesture.location(in: canvas),
            to: canvas
        )

        // If tap hit an existing text view, show selection
        if let textView = textView(at: location, in: canvas) {
            select(textView)
            textView.becomeFirstResponder()
            return
        }

        // Clean up empty previously selected text
        cleanupEmptyTextIfNeeded()

        let textView = createTextView(at: location, in: canvas)
        configure(textView)
        select(textView)
        textView.becomeFirstResponder()
    }

    // MARK: - Text View Helpers

    private func textView(at point: CGPoint, in canvas: PKCanvasView) -> CanvasTextView? {
        canvas.subviews.compactMap { $0 as? CanvasTextView }
            .first { $0.frame.contains(point) }
    }

    private func createTextView(at point: CGPoint, in canvas: PKCanvasView) -> CanvasTextView {
        let textView = CanvasTextView(
            frame: CGRect(x: point.x, y: point.y, width: 240, height: 40)
        )
        textView.canvasPosition = point
        canvas.addSubview(textView)
        
        textViews.append(textView)
        return textView
    }
    
    func saveAllText() {
        var newData: [TextData] = []

        for textView in textViews {
            let trimmed = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)

            if trimmed.isEmpty {
                textView.removeFromSuperview()
                continue
            }

            newData.append(textView.toTextData())
        }

        parent.textData = newData
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard let textView = textView as? CanvasTextView else { return }
        select(textView)
        textView.setSelected(true)
    }

    private func configure(_ textView: CanvasTextView) {
        textView.coordinator = self
        textView.delegate = self
    }
    
    private func cleanupIfEmpty(_ textView: CanvasTextView?) {
        guard let textView else { return }
        let trimmed = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.isEmpty {
            textView.removeFromSuperview()
            if selectedTextView === textView {
                selectedTextView = nil
            }
        }
    }
    
    func cleanupEmptyTextIfNeeded() {
        guard let textView = selectedTextView else { return }

        let trimmed = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.isEmpty {
            textView.removeFromSuperview()
            selectedTextView = nil
        }
    }
    
    func deselectText() {
        selectedTextView?.setSelected(false)
        selectedTextView?.resignFirstResponder()
        selectedTextView = nil
    }


    // MARK: - Font Picker

    private func presentFontPicker() {
        let config = UIFontPickerViewController.Configuration()
        config.includeFaces = true

        let picker = UIFontPickerViewController(configuration: config)
        picker.delegate = self

        guard let rootVC = UIApplication.shared
            .connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first?
            .keyWindow?
            .rootViewController
        else { return }

        rootVC.present(picker, animated: true)
    }

    func fontPickerViewControllerDidPickFont(
        _ viewController: UIFontPickerViewController
    ) {
        guard
            let descriptor = viewController.selectedFontDescriptor,
            let textView = selectedTextView
        else { return }

        let size = textView.font?.pointSize ?? 17
        textView.font = UIFont(descriptor: descriptor, size: size)
    }

    // MARK: - UITextViewDelegate
    func select(_ textView: CanvasTextView) {
        selectedTextView?.setSelected(false)
        selectedTextView = textView
        textView.setSelected(true)
        
        parent.selectedTextViewBinding = textView
    }
    
    // MARK: - Text Styling API (Used by SwiftUI)

    func setFont(_ font: UIFont) {
        guard let textView = selectedTextView else { return }
        textView.font = font
    }

    func setFontSize(_ size: CGFloat) {
        guard let textView = selectedTextView else { return }
        let currentFont = textView.font ?? .systemFont(ofSize: size)
        textView.font = currentFont.withSize(size)
    }

    func setTextColor(_ color: UIColor) {
        guard let textView = selectedTextView else { return }
        textView.textColor = color
    }


    func textViewDidEndEditing(_ textView: UITextView) {
        guard let textView = textView as? CanvasTextView else { return }
        
        let trimmed = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.isEmpty {
            textView.removeFromSuperview()
        }
        
        textView.setSelected(false)
    }


    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: textView.frame.width, height: .infinity)
        textView.frame.size.height = textView.sizeThatFits(size).height
    }
}

extension CanvasCoordinator: UIScrollViewDelegate {
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        guard let canvas = scrollView as? PKCanvasView else { return }

        let scale = canvas.zoomScale

        for case let textView as CanvasTextView in canvas.subviews {

            // scale text
            textView.transform = CGAffineTransform(scaleX: scale, y: scale)

            // reposition from ORIGINAL canvas space
            textView.center = CGPoint(
                x: textView.canvasPosition.x * scale,
                y: textView.canvasPosition.y * scale
            )
        }
    }

}
