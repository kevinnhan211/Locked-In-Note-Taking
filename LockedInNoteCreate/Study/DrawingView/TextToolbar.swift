import SwiftUI

struct TextToolbar: View {
    @Binding var isVisible: Bool

    // Closures for toolbar actions
    var onFontChange: ((UIFont) -> Void)?
    var onFontSizeChange: ((CGFloat) -> Void)?
    var onTextColorChange: ((UIColor) -> Void)?
    
    // Local UI state
    @State private var fontSize: CGFloat = 20
    @State private var textColor: Color = .black
    @State private var selectedFontName: String = "System"

    // Apple system fonts
    private var fonts: [String] {
        UIFont.familyNames.sorted()
    }

    var body: some View {
        if isVisible {
            HStack(spacing: 12) {

                // MARK: - Font Picker
                VStack(alignment: .leading, spacing: 6) {
                    Text("Font")
                        .font(.custom("Futura Medium", size: 16))
                        .foregroundColor(.gray)

                    Menu {
                        ForEach(fonts, id: \.self) { font in
                            Button(font) {
                                selectedFontName = font
                                applyFont()
                            }
                        }
                    } label: {
                        Text(selectedFontName)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(Color(.systemGray6))
                            .cornerRadius(6)
                            .font(.custom("Futura Medium", size: 16))
                    }
                }

                // MARK: - Font Size Slider
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text("Size")
                            .font(.custom("Futura Medium", size: 16))
                            .foregroundColor(.gray)
                        Spacer()
                        Text("\(Int(fontSize))")
                            .font(.custom("Futura Medium", size: 16))
                            .foregroundColor(.blue)
                            .padding(.trailing, 4)
                    }
                    
                    Slider(value: $fontSize, in: 8...72, step: 1) { _ in
                        applyFontSize()
                    }
                    .accentColor(.blue)
                }
                .frame(width: 150)

                // MARK: - Color Picker
                VStack(alignment: .leading, spacing: 6) {
                    Text("Color")
                        .font(.custom("Futura Medium", size: 16))
                        .foregroundColor(.gray)
                    
                    HStack(spacing: 8) {
                        ColorPicker("", selection: $textColor)
                            .labelsHidden()
                            .frame(width: 36, height: 36)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray.opacity(0.4), lineWidth: 1))
                            .onChange(of: textColor) { newColor in
                                onTextColorChange?(UIColor(newColor))
                            }

                        Button(action: {
                            textColor = .black
                            onTextColorChange?(UIColor.black)
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .offset(x:25,y:2)

                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(.ultraThinMaterial)
            .cornerRadius(12)
            .shadow(radius: 5)
            .padding(.trailing, 10)
            .padding(.bottom, 550)
            .transition(.move(edge: .trailing))
            .animation(.easeInOut, value: isVisible)
        }
    }

    // MARK: - Helpers
    private func applyFont() {
        let font = UIFont(name: selectedFontName, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
        onFontChange?(font)
    }

    private func applyFontSize() {
        onFontSizeChange?(fontSize)
        applyFont()
    }
}
