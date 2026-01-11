import UIKit

final class CanvasTextView: UITextView {
    private enum ResizeCorner {
        case topLeft, topRight, bottomLeft, bottomRight
    }

    // MARK: - State
    var canvasPosition: CGPoint = .zero
    weak var coordinator: CanvasCoordinator?

    private let selectionBorder = CAShapeLayer()
    private let handleSize: CGFloat = 22
    private var resizeHandles: [(corner: ResizeCorner, view: UIView)] = []

    // MARK: - Init
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
        addPanGesture()
        setupSelectionBorder()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Setup
    private func configure() {
        backgroundColor = .clear
        isScrollEnabled = false
        font = .systemFont(ofSize: 20)
        textColor = .label
        textAlignment = .left

        layer.cornerRadius = 6
        layer.masksToBounds = false
    }

    private func setupSelectionBorder() {
        selectionBorder.strokeColor = UIColor.systemBlue.cgColor
        selectionBorder.fillColor = UIColor.clear.cgColor
        selectionBorder.lineWidth = 2
        selectionBorder.isHidden = true
        layer.addSublayer(selectionBorder)
    }
    
    private func createResizeHandlesIfNeeded() {
        guard resizeHandles.isEmpty else { return }

        let corners: [ResizeCorner] = [
            .topLeft, .topRight, .bottomLeft, .bottomRight
        ]

        for corner in corners {
            let handle = UIView()
            handle.backgroundColor = .systemBlue
            handle.layer.cornerRadius = handleSize / 2

            let pan = UIPanGestureRecognizer(
                target: self,
                action: #selector(handleResizePan(_:))
            )
            handle.addGestureRecognizer(pan)

            addSubview(handle)
            resizeHandles.append((corner, handle))
        }
    }
    
    private func layoutResizeHandles() {
        for (corner, handle) in resizeHandles {
            let frame: CGRect

            switch corner {
            case .topLeft:
                frame = CGRect(x: -handleSize/2, y: -handleSize/2, width: handleSize, height: handleSize)
            case .topRight:
                frame = CGRect(x: bounds.width - handleSize/2, y: -handleSize/2, width: handleSize, height: handleSize)
            case .bottomLeft:
                frame = CGRect(x: -handleSize/2, y: bounds.height - handleSize/2, width: handleSize, height: handleSize)
            case .bottomRight:
                frame = CGRect(x: bounds.width - handleSize/2, y: bounds.height - handleSize/2, width: handleSize, height: handleSize)
            }

            handle.frame = frame
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        selectionBorder.path = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: 6
        ).cgPath
        selectionBorder.frame = bounds

        if !selectionBorder.isHidden {
            createResizeHandlesIfNeeded()
            layoutResizeHandles()
        }
    }

    // MARK: - Selection
    func setSelected(_ selected: Bool) {
        selectionBorder.isHidden = !selected
        resizeHandles.forEach { $0.view.isHidden = !selected }
    }

    // MARK: - Dragging
    private func addPanGesture() {
        let pan = UIPanGestureRecognizer(
            target: self,
            action: #selector(handlePan(_:))
        )
        addGestureRecognizer(pan)
    }

    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let superview else { return }

        if !isFirstResponder {
            coordinator?.select(self)
        }

        let translation = gesture.translation(in: superview)
        center = CGPoint(
            x: center.x + translation.x,
            y: center.y + translation.y
        )

        canvasPosition = center
        gesture.setTranslation(.zero, in: superview)
    }
    
    @objc private func handleResizePan(_ gesture: UIPanGestureRecognizer) {
        guard let handle = gesture.view else { return }
        let translation = gesture.translation(in: superview)

        var newFrame = frame

        if let entry = resizeHandles.first(where: { $0.view === handle }) {
            switch entry.corner {
            case .bottomRight:
                newFrame.size.width += translation.x
                newFrame.size.height += translation.y

            case .bottomLeft:
                newFrame.origin.x += translation.x
                newFrame.size.width -= translation.x
                newFrame.size.height += translation.y

            case .topRight:
                newFrame.origin.y += translation.y
                newFrame.size.width += translation.x
                newFrame.size.height -= translation.y

            case .topLeft:
                newFrame.origin.x += translation.x
                newFrame.origin.y += translation.y
                newFrame.size.width -= translation.x
                newFrame.size.height -= translation.y
            }
        }

        // Minimum size
        newFrame.size.width = max(60, newFrame.size.width)
        newFrame.size.height = max(30, newFrame.size.height)

        frame = newFrame
        gesture.setTranslation(.zero, in: superview)
    }
    
    func toTextData() -> TextData {
        let color = textColor ?? .black
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        color.getRed(&r, green: &g, blue: &b, alpha: &a)

        return TextData(
            id: UUID(),
            text: text,
            centerX: center.x,
            centerY: center.y,
            width: bounds.width,
            height: bounds.height,
            fontName: font?.fontName ?? UIFont.systemFont(ofSize: 20).fontName,
            fontSize: font?.pointSize ?? 20,
            textColorRed: r,
            textColorGreen: g,
            textColorBlue: b,
            textColorAlpha: a
        )
    }

}
