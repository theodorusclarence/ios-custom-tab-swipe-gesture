//
//  Home.swift
//  furniture-app
//
//  Created by Clarence on 15/05/22.
//

import SwiftUI

struct Home: View {
    // Sample Furnitures
    @State var furnitures = [
        Furniture(
            name: "Stylish Table Lamp",
            description: "We have amazing quality Lamp wide range.",
            price: "$20.00",
            image: "lamp"
        ),
        Furniture(
            name: "Modern Chair",
            description: "New style of tables for your home and office.",
            price: "$60.00",
            image: "chair"
        ),
        Furniture(
            name: "Wodden Stool",
            description: "New style of tables for your home and office.",
            price: "$35.00",
            image: "stool"
        )
    ]

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 18) {
                HStack {
                    Button {} label: {
                        Image(systemName: "sidebar.left")
                            .font(.title2)
                    }
                    
                    Spacer()
                    
                    Button {} label: {
                        Image(systemName: "slider.vertical.3")
                            .font(.title2)
                    }
                } //: HStack
                .foregroundColor(.black)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Furniture in\nUnique Style")
                        .font(.largeTitle.bold())
                    
                    Text("We have a wide range of furnitures")
                        .font(.caption)
                        .foregroundColor(.gray)
                } //: VStack
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 20)
                
                ForEach($furnitures) { $furniture in
                    CardView(furniture: $furniture)
                }
            }
        } //: VStack
        .padding()
        .padding(.bottom, 100)
    } //: ScrollView
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View {
    @Binding var furniture: Furniture
    @GestureState var gestureOffset: CGFloat = 0
    @State var offset: CGFloat = 0
    
    // Last stored offset
    @State var lastStoredOffset: CGFloat = 0
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(furniture.name)
                    .fontWeight(.bold)
                
                Text(furniture.description)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text(furniture.price)
                    .font(.title3.bold())
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(furniture.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
        }
        .padding(.horizontal)
        .padding(.vertical, 6)
        .background(
            ZStack {
                Color.white
                Color("Card")
                    .opacity(-offset / 100)
            }.cornerRadius(15)
        )
        .cornerRadius(15)
        .contentShape(Rectangle())
        .offset(x: offset)
        .background(
            ZStack(alignment: .trailing) {
                Color("Brown")
                
                VStack(spacing: 35) {
                    Button {
                        
                    } label: {
                        Image(systemName: "pencil.circle.fill")
                            .font(.title2)
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "cart.fill")
                            .font(.title2)
                    }
                }
                .foregroundColor(.white)
                .padding(.trailing, 35)
            }.cornerRadius(15)
                .padding(.horizontal, 2)
            
        )
        .gesture(
            DragGesture()
                .updating($gestureOffset, body: { value, out, _ in
                    out = value.translation.width
                }).onEnded { value in
                    let translation = value.translation.width
                    
                    // stay on 1 place
                    if translation < 0, -translation > 100 {
                        offset = -100
                    } else {
                        offset = 0
                    }

                    lastStoredOffset = offset
                }
        )
        .animation(.easeInOut, value: offset == 0)
        .onChange(of: gestureOffset) {
            _ in
            // to make swipe gesture only from right to left
            offset = (gestureOffset + lastStoredOffset) > 0 ? 0 : (gestureOffset + lastStoredOffset)
        }
    }
}
