//
//  HomeNavigationBarView.swift
//  MarsPhoto
//
//  Created by Анастасия Кутняхова on 25.08.2024.
//

import SwiftUI

struct HomeNavigationBarView: View {    
    var body: some View {
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
                
                DateFilterButtonView()
            }
            .padding(.bottom, 22)
            
            HStack(spacing: .zero) {
                FilterButtonView(action: {}, imageName: "rover")
                FilterButtonView(action: {}, imageName: "camera")
                
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

#Preview {
    HomeNavigationBarView()
}

struct AddButtonView: View {
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

struct DateFilterButtonView: View {
    var body: some View {
        Button(
            action: {},
            label: {
                Image("calendar")
                    .frame(width: 44, height: 44)
            }
        )
    }
}
