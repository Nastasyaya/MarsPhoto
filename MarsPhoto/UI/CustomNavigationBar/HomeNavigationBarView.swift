//
//  HomeNavigationBarView.swift
//  MarsPhoto
//
//  Created by Анастасия Кутняхова on 25.08.2024.
//

import SwiftUI

struct HomeNavigationBarView: View {
    let onShowDatePicker: () -> Void
    let onShowFilter: (FilterType) -> Void

    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Mars.Camera".uppercased())
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("June 6, 2024")
                            .fontWeight(.semibold)
                    }
                    
                    Spacer()
                    
                    DateFilterButtonView(
                        onShowDatePicker: onShowDatePicker
                    )
                }
                .padding(.bottom, 22)
                
                HStack(spacing: .zero) {
                    FilterButtonView(
                        action: {
                            onShowFilter(.rover)
                        },
                        imageName: "rover"
                    )
                    FilterButtonView(
                        action: {
                            onShowFilter(
                                .camera(
                                    elements: [],
                                    onFiltered: { _ in }
                                )
                            )
                        },
                        imageName: "camera"
                    )
                    
                    Spacer()
                    
                    AddButtonView()
                }
            }
            .padding(
                EdgeInsets(
                    top: 2,
                    leading: 20,
                    bottom: 20,
                    trailing: 20
                )
            )
            .background(
                Color.accentOne
                    .ignoresSafeArea(edges: .top)
            )
            
            Spacer()
        }
    }
}

private struct AddButtonView: View {
    var body: some View {
        Button(
            action: {},
            label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.backgroundOne)
                        .frame(width: 38, height: 38)
                    
                    Image("addButton")
                        .frame(width: 24, height: 24)
                }
            }
        )
    }
}

private struct DateFilterButtonView: View {
    let onShowDatePicker: () -> Void

    var body: some View {
        Button(
            action: onShowDatePicker,
            label: {
                Image("calendar")
                    .frame(width: 44, height: 44)
            }
        )
    }
}

#Preview {
    HomeNavigationBarView(
        onShowDatePicker: {},
        onShowFilter: { _ in }
    )
}

struct DatePickerView: View {
    @Binding var isDatePickerShown: Bool
    @Binding var selectedDate: Date

    @State private var scale: Double = 0.5

    let onClose: () -> Void
    let onConfirm: (Date) -> Void

    var body: some View {
        if isDatePickerShown {
            ZStack {
                RoundedRectangle(cornerRadius: 50)
                    .foregroundStyle(Color.white)

                VStack {
                    makeDatePickerToolbar(selectedDate: selectedDate)
                        .padding(.horizontal, 16)

                    DatePicker(
                        "",
                        selection: $selectedDate,
                        displayedComponents: .date
                    )
                    .datePickerStyle(.wheel)
                }
            }
            .frame(width: 353, height: 312)
            .scaleEffect(scale)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.2)) {
                    scale = 1
                }
            }
            .onDisappear {
                scale = 0.5
            }
        }
    }

    private func makeDatePickerToolbar(selectedDate: Date) -> some View {
        HStack {
            Button(
                action: onClose,
                label: {
                    Image("closeButtonDark")
                }
            )

            Spacer()

            Text("Date")
                .font(.custom("SF Pro", size: 22))
                .bold()

            Spacer()

            Button(
                action: {
                    onConfirm(selectedDate)
                },
                label: {
                    Image("orangeCheckmark")
                }
            )
        }
    }
}
