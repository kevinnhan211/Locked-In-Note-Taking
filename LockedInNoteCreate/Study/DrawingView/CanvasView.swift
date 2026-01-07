//
//  CanvasView.swift
//  LockedInNoteCreate
//

import SwiftUI
import PencilKit

struct CanvasView: UIViewRepresentable {
    @Binding var isDrawingEnabled: Bool
    @Binding var drawing : PKDrawing?
    
    let toolPicker = PKToolPicker()
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> PKCanvasView {
        if (drawing == nil) {
            drawing = PKDrawing()
        }
        
        let canvasView = PKCanvasView()
        let contentSize = CGSize(width: 5000, height: 5000)
        
        canvasView.contentSize = contentSize
        canvasView.backgroundColor = .clear
        
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
        canvasView.delegate = context.coordinator as? any PKCanvasViewDelegate
        
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
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: CanvasView
        
        init(parent: CanvasView) {
            self.parent = parent
        }
    }
}

struct DrawingView: View {
    @State private var isDrawingEnabled = true
    
    @Binding var title : String
    @Binding var drawing : PKDrawing?
    @Binding var showingCanvas : Bool
    
    @Environment(\.undoManager) var undoManager
    
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(LinearGradient(colors: [.gradientBottom, .gradientTop], startPoint: .bottom, endPoint: .top))
                
                CanvasView(isDrawingEnabled: $isDrawingEnabled, drawing:$drawing)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    //.clipped()
                    .background(Color.clear)
                
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            HStack (spacing:15) {
                                Button {
                                    isDrawingEnabled.toggle()
                                } label: {
                                    Image(systemName: isDrawingEnabled ? "pencil" : "hand.draw")
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

//#Preview {
//    DrawingView()
//}
