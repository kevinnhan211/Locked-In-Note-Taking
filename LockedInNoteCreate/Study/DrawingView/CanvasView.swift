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
    @Binding var textData : [UITextView]?
    
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
        canvasView.backgroundColor = .clear
        
        // Add data
        canvasView.drawing = drawing ?? PKDrawing()
        for i in 0..<(textData?.count ?? 0) {
            let textView = textData![i]
            canvasView.addSubview(textView)
        }
        
        // Start in centre
        let viewSize = canvasView.bounds.size
        let centerOffset = CGPoint(
            x: max(0, (contentSize.width - viewSize.width) / 2),
            y: max(0, (contentSize.height - viewSize.height) / 2)
        )
        canvasView.setContentOffset(centerOffset, animated: false)
        
        // Grid background
        let gridView = DotGridView(frame: CGRect(origin: .zero, size: contentSize))
        gridView.backgroundColor = .white
        gridView.isUserInteractionEnabled = false
        canvasView.insertSubview(gridView, at: 0)
        
        // Drawing
        canvasView.drawingPolicy = .pencilOnly
        canvasView.isScrollEnabled = true
        canvasView.alwaysBounceVertical = true
        canvasView.alwaysBounceHorizontal = true
        
        // Zoom
        canvasView.minimumZoomScale = 0.5
        canvasView.maximumZoomScale = 1.6
        canvasView.zoomScale = 1.0
        
        // Tool Picker
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        canvasView.becomeFirstResponder()
        
        // Set scroll delegate
        canvasView.delegate = context.coordinator
        
        // Add text
        let tapGesture = UITapGestureRecognizer(
            target: context.coordinator,
            action: #selector(Coordinator.handleTap(_:))
        )
        canvasView.addGestureRecognizer(tapGesture)
        
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        uiView.drawingPolicy = isDrawingEnabled ? .anyInput : .pencilOnly
        
        // Allow mouse / single-finger pan in Pan mode
        uiView.panGestureRecognizer.minimumNumberOfTouches =
        isDrawingEnabled ? 2 : 1
        
        if drawing != uiView.drawing {
            DispatchQueue.main.async {
                drawing = uiView.drawing
            }
        }
        
        if isTextModeEnabled == false && isDrawingEnabled {
            toolPicker.setVisible(true, forFirstResponder: uiView)
            toolPicker.addObserver(uiView)
            uiView.becomeFirstResponder()
        }
        
        for i in 0..<(textData?.count ?? 0) {
            let textView = textData![i]
            print(textView.text!)
        }
    }


}

struct DrawingView: View {
    @State private var isDrawingEnabled = true
    @State private var isTextModeEnabled = false
    
    @Binding var title : String
    @Binding var drawing : PKDrawing?
    @Binding var textData : [UITextView]?
    @Binding var showingCanvas : Bool
    
    @Environment(\.undoManager) var undoManager
    
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(LinearGradient(colors: [.gradientBottom, .gradientTop], startPoint: .bottom, endPoint: .top))
                
                CanvasView(isDrawingEnabled: $isDrawingEnabled, isTextModeEnabled: $isTextModeEnabled, drawing:$drawing, textData: $textData)
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
                
            }
        }
    }
}

struct DrawingViewPreviewWrapper: View {
    @State private var title = "asdf"
    @State private var drawing: PKDrawing? = PKDrawing()
    @State private var textData : [UITextView]? = []
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
