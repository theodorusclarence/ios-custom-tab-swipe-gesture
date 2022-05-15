//
//  ContentView.swift
//  furniture-app
//
//  Created by Clarence on 15/05/22.
//

import SwiftUI

struct ContentView: View {
    @State var currentTab = "house.fill"
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    // Curve Axis Value
    @State var curveAxis: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentTab) {
                Home()
                    .tag("house.fill")
                
                Text("Search")
                    .tag("magnifyingglass")
                
                Text("Account")
                    .tag("person.fill")
            }
            .clipShape(CustomTabCurve(curveAxis: curveAxis))
            .padding(.bottom, -90)
            
            HStack(spacing: 0) {
                TabButtons()
            }
            .frame(height: 50)
            .padding(.horizontal, 35)
        } //: VStack
        .background(Color("Brown"))
        .ignoresSafeArea(.container, edges: .top)
    }
    
    @ViewBuilder
    func TabButtons() -> some View {
        ForEach(["house.fill", "magnifyingglass", "person.fill"], id: \.self) { image in
            
            GeometryReader { proxy in
                Button {
                    withAnimation {
                        currentTab = image
                        curveAxis = proxy.frame(in: .global).midX
                    }
                } label: {
                    Image(systemName: image)
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 45, height: 45)
                        .background(
                            Circle()
                                .fill(Color("Brown"))
                        )
                        .offset(y: currentTab == image ? -25 : 0)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                // initial update
                .onAppear {
                    if curveAxis == 0, image == "house.fill" {
                        curveAxis = proxy.frame(in: .global).midX
                    }
                }
            }.frame(height: 40)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
