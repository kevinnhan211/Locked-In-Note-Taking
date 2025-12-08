//
//  EditNoteTags.swift
//  LockedInNoteCreate
//
//  Created by Kevin Nhan on 2025-12-08.
//

import SwiftUI

struct EditNoteTags: View {
    @Binding var note: Note
    @Environment(\.dismiss) var dismiss

    @State private var newTag: String = ""
    @State private var selectedTag: String? = nil

    var body: some View {
        NavigationStack {
            Form {

                // Current Tags Section
                Section(header: Text("Tags")
                    .font(.custom("Futura Medium", size: 16))
                    .foregroundStyle(.white)
                ) {

                    List(note.tags, id: \.self) { tag in
                        HStack {
                            Text(tag)
                                .font(.custom("Futura Medium", size: 18))
                                .foregroundStyle(.white)

                            Spacer()

                            Button {
                                note.tags.removeAll(where: { $0 == tag })
                            } label: {
                                Image(systemName: "trash")
                                    .foregroundStyle(.red)
                            }
                            .buttonStyle(.borderless)
                        }
                        .listRowBackground(Color.gray.opacity(0.3))
                    }
                }

                // Add New Tag
                Section(header: Text("Add Tag")
                    .font(.custom("Futura Medium", size: 16))
                    .foregroundStyle(.white)
                ) {
                    HStack {
                        TextField("New tag", text: $newTag)
                            .font(.custom("Futura Medium", size: 18))
                            .foregroundStyle(.white)
                            .tint(.white)

                        Button {
                            let trimmed = newTag.trimmingCharacters(in: .whitespaces)
                            if !trimmed.isEmpty && !note.tags.contains(trimmed) {
                                note.tags.append(trimmed)
                                newTag = ""
                            }
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                                .foregroundStyle(.blue)
                        }
                    }
                    .listRowBackground(Color.gray.opacity(0.3))
                }
            }

            // Make the form background invisible so your custom color shows
            .scrollContentBackground(.hidden)
            .background(Color.buttonColour)
            .navigationTitle("Edit Tags")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                        .font(.custom("Futura Medium", size: 16))
                        .foregroundStyle(.white)
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                        .font(.custom("Futura Medium", size: 16))
                        .foregroundStyle(.white)
                }
            }
        }
    }
}
