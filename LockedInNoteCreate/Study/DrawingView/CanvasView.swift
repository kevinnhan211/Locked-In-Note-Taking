//
//  CanvasView.swift
//  LockedInNoteCreate
//

import SwiftUI
import PencilKit

struct CanvasView: UIViewRepresentable {
    @Binding var isDrawingEnabled: Bool
    @Binding var isTextModeEnabled: Bool
    @Binding var drawing : PKDrawing?
    @Binding var textData : [TextData]
    
    @Binding var selectedTextViewBinding: CanvasTextView?
    @Binding var saveText : Bool
    
    let toolPicker = PKToolPicker()
    
    func makeCoordinator() -> CanvasCoordinator {
        CanvasCoordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> PKCanvasView {
        if (drawing == nil) {
            drawing = PKDrawing()
        }
        
        let canvasView = PKCanvasView()
        let contentSize = CGSize(width: 5000, height: 5000)
        
        canvasView.contentSize = contentSize
        canvasView.backgroundColor = .white
        
        // Add data
        canvasView.drawing = drawing ?? PKDrawing()

        // Start in centre
        let viewSize = canvasView.bounds.size
        let centerOffset = CGPoint(
            x: max(0, (contentSize.width - viewSize.width) / 2),
            y: max(0, (contentSize.height - viewSize.height) / 2)
        )
        canvasView.setContentOffset(centerOffset, animated: false)
        
        // Grid background
        let gridView = DotGridView(frame: CGRect(origin: .zero, size: contentSize))
        gridView.backgroundColor = .clear
        gridView.isUserInteractionEnabled = false
        canvasView.addSubview(gridView)
        
        // Drawing
        canvasView.drawingPolicy = .pencilOnly
        canvasView.isScrollEnabled = true
        canvasView.alwaysBounceVertical = true
        canvasView.alwaysBounceHorizontal = true
        
        // Zoom
        canvasView.minimumZoomScale = 0.5
        canvasView.maximumZoomScale = 1.6
        canvasView.zoomScale = 1.0
        
        // Add text (RESET to base canvas space)
        for data in textData {
            let textView = CanvasTextView(
                frame: CGRect(x: 0, y: 0, width: data.width, height: data.height)
            )

            textView.text = data.text
            textView.font = UIFont(name: data.fontName, size: data.fontSize)
            textView.textColor = UIColor(
                red: data.textColorRed,
                green: data.textColorGreen,
                blue: data.textColorBlue,
                alpha: data.textColorAlpha
            )

            // Store original logical position
            textView.canvasPosition = CGPoint(
                x: data.centerX,
                y: data.centerY
            )

            textView.transform = .identity
            textView.center = textView.canvasPosition

            textView.coordinator = context.coordinator
            context.coordinator.textViews.append(textView)
            canvasView.addSubview(textView)
        }
        
        // Tool Picker
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        canvasView.becomeFirstResponder()
        
        // Set scroll delegate
        canvasView.delegate = context.coordinator
        
        // Add text
        let tap = UITapGestureRecognizer(
            target: context.coordinator,
            action: #selector(CanvasCoordinator.handleTap)
        )
        tap.cancelsTouchesInView = false
        canvasView.addGestureRecognizer(tap)
        
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        uiView.drawingPolicy = isDrawingEnabled ? .anyInput : .pencilOnly
        
        // Allow mouse / single-finger pan in Pan mode
        uiView.panGestureRecognizer.minimumNumberOfTouches =
        isDrawingEnabled ? 2 : 1
        
        if !isTextModeEnabled {
            context.coordinator.deselectText()
            selectedTextViewBinding = nil
        }
        
        if saveText {
            context.coordinator.saveAllText()
            DispatchQueue.main.async {
                drawing = uiView.drawing
            }
        }
        
        if isTextModeEnabled == false && isDrawingEnabled {
            toolPicker.setVisible(true, forFirstResponder: uiView)
            toolPicker.addObserver(uiView)
            uiView.becomeFirstResponder()
        }

    }


}

struct DrawingView: View {
    @State private var isDrawingEnabled = true
    @State private var isTextModeEnabled = false
    @State private var doSave = false
    @State private var selectedTextView: CanvasTextView? = nil
    
    @Binding var title : String
    @Binding var drawing : PKDrawing?
    @Binding var textData : [TextData]
    @Binding var showingCanvas : Bool
    
    @Environment(\.undoManager) var undoManager
    
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(LinearGradient(colors: [.gradientBottom, .gradientTop], startPoint: .bottom, endPoint: .top))
                
                CanvasView(
                    isDrawingEnabled: $isDrawingEnabled,
                    isTextModeEnabled: $isTextModeEnabled,
                    drawing:$drawing,
                    textData: $textData,
                    selectedTextViewBinding: $selectedTextView,
                    saveText: $doSave
                )
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.clear)
                
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            HStack (spacing:15) {
                                Button {
                                    if !isTextModeEnabled {
                                        isDrawingEnabled.toggle()
                                    }
                                } label: {
                                    Image(systemName: isDrawingEnabled ? "pencil" : "hand.draw")
                                }
                                
                                Button {
                                    isTextModeEnabled.toggle()
                                    if isTextModeEnabled {
                                        isDrawingEnabled = false
                                    } else {
                                        isDrawingEnabled = true
                                    }
                                    
                                } label: {
                                    Image(systemName: "textformat")
                                        .symbolVariant(isTextModeEnabled ? .fill : .none)
                                }
                                
                                // Export
                                ShareLink(item: "Kevin Nhan's \(title) - https://notelinkshare.ca") {
                                    Image(systemName: "square.and.arrow.up")
                                }
                            }
                        }
                        
                        ToolbarItem(placement: .principal) {
                            Text("\(title)")
                                .font(.custom("Futura Medium", size: 20))
                        }
                        
                        ToolbarItem(placement: .topBarLeading) {
                            HStack (spacing:15) {
                                Button {
                                    doSave = true
                                    showingCanvas = false
                                } label: {
                                    Text("Back")
                                        .font(.custom("Futura Medium", size: 18))
                                }
                                
                                Button {
                                    undoManager?.undo()
                                } label: {
                                    Image(systemName: "arrow.uturn.backward")
                                }
                                
                                Button {
                                    undoManager?.redo()
                                } label: {
                                    Image(systemName: "arrow.uturn.forward")
                                }
                            }
                            
                            
                        }
                    }
                    .foregroundStyle(.white)
                
                HStack {
                    Spacer()
                    
                    TextToolbar(
                        isVisible: .constant(isTextModeEnabled && selectedTextView != nil),
                        onFontChange: { font in
                            selectedTextView?.font = font
                        },
                        onFontSizeChange: { size in
                            guard let tv = selectedTextView else { return }
                            tv.font = tv.font?.withSize(size)
                        },
                        onTextColorChange: { color in
                            selectedTextView?.textColor = color
                        }
                    )

                }
                
            }
        }
    }
}

struct DrawingViewPreviewWrapper: View {
    @State private var title = "asdf"
    @State private var drawing: PKDrawing? = PKDrawing()
    @State private var textData : [TextData] = []
    @State private var showingCanvas = true

    var body: some View {
        DrawingView(
            title: $title,
            drawing: $drawing,
            textData: $textData,
            showingCanvas: $showingCanvas
        )
    }
}


#Preview {
    DrawingViewPreviewWrapper()
}
