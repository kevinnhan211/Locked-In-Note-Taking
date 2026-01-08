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

    init(parent: CanvasView) {
        self.parent = parent
    }

    // MARK: - Tap Handling

    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        guard parent.isTextModeEnabled else { return }
        guard let canvas = gesture.view as? PKCanvasView else { return }

        let location = gesture.location(in: canvas)

        if let textView = textView(at: location, in: canvas) {
            configure(textView)
            select(textView)
            showTextEditMenu(for: textView)
            return
        }

        let textView = createTextView(at: location, in: canvas)
        configure(textView)
        select(textView)
        showTextEditMenu(for: textView)
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

        textView.delegate = self
        canvas.addSubview(textView)
        return textView
    }

    private func configure(_ textView: CanvasTextView) {
        textView.fontPickerDelegate = self
        textView.onRequestFontPicker = { [weak self] in
            self?.presentFontPicker()
        }
    }

    private func select(_ textView: CanvasTextView) {
        selectedTextView?.setSelected(false)
        selectedTextView = textView
        textView.setSelected(true)
    }

    // MARK: - Edit Menu

    private func showTextEditMenu(for textView: UITextView) {
        DispatchQueue.main.async {
            textView.becomeFirstResponder()

            // Force caret (required)
            let position = textView.endOfDocument
            textView.selectedTextRange = textView.textRange(
                from: position,
                to: position
            )

            let rect = CGRect(
                x: textView.bounds.midX,
                y: textView.bounds.minY,
                width: 1,
                height: 1
            )

            if let interaction = textView.interactions
                .compactMap({ $0 as? UIEditMenuInteraction })
                .first {

                interaction.presentEditMenu(
                    with: UIEditMenuConfiguration(
                        identifier: nil,
                        sourcePoint: CGPoint(x: rect.midX, y: rect.minY)
                    )
                )
            } else {
                UIMenuController.shared.showMenu(
                    from: textView,
                    rect: rect
                )
            }
        }
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

    func textViewDidEndEditing(_ textView: UITextView) {
        let trimmed = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.isEmpty {
            textView.removeFromSuperview()
        }
    }

    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: textView.frame.width, height: .infinity)
        textView.frame.size.height = textView.sizeThatFits(size).height
    }
}

extension CanvasCoordinator: UIScrollViewDelegate {
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        guard let canvas = scrollView as? PKCanvasView else { return }
        
        print("Pookie")

        for subview in canvas.subviews {
            if let textView = subview as? CanvasTextView {
                // Scale text to match canvas zoom
                let scale = canvas.zoomScale
                textView.transform = CGAffineTransform(scaleX: scale, y: scale)
                
                // Adjust position so it stays at the same logical location
                let originalCenter = textView.center
                textView.center = CGPoint(x: originalCenter.x, y: originalCenter.y)
            }
        }
    }
}
