//
//  FilterView.swift
//  MarsPhoto
//
//  Created by Анастасия Кутняхова on 28.08.2024.
//

import SwiftUI

struct FilterView: View {
    private var title: String {
        switch filterType {
        case .camera:
            "Camera"
        case .rover:
            "Rover"
        }
    }

    let filterType: FilterType
    let onClose: () -> Void
    let onConfirm: () -> Void

    var body: some View {
        VStack {
            makePickerToolbar()
                .padding(.horizontal, 16)
            makePicker()
        }
    }

    private func makePickerToolbar() -> some View {
        HStack {
            Button(
                action: onClose,
                label: {
                    Image("closeButtonDark")
                }
            )

            Spacer()

            Text(title)
                .font(.custom("SF Pro", size: 22))
                .bold()

            Spacer()

            Button(
                action: onConfirm,
                label: {
                    Image("orangeCheckmark")
                }
            )
        }
    }

    private func makePicker() -> some View {
        Group {
            switch filterType {
            case let .camera(elements, onFiltered):
                Picker(
                    selection: Binding(
                        get: {
                            "All"
                        },
                        set: { newValue in
                            onFiltered(newValue)
                        }
                    ),
                    content: {
                        ForEach(elements, id: \.name) { element in
                            Text(element.fullName)
                        }
                    },
                    label: {
                        EmptyView()
                    }
                )
                .pickerStyle(.wheel)
            case .rover:
                Picker(
                    selection: .constant(""),
                    content: {
                        EmptyView()
                    },
                    label: {
                        EmptyView()
                    }
                )
                .pickerStyle(.wheel)
            }
        }
    }
}
