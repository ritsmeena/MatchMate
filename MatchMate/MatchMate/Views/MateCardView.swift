//
//  MateCardView.swift
//  MatchMate
//
//  Created by Ritika Meena on 11/02/25.
//

import Foundation
import SwiftUI

struct MateCardView: View {
    
    var profile: User
    var onAction: () -> Void
    
    @State private var offset = CGSize.zero

    var body: some View {
        ZStack {
            if let imageUrl = URL(string: profile.picture.large) {
                AsyncImage(url: imageUrl) { image in
                    image.resizable()
                        .scaledToFill()
                        .frame(width: 300, height: 400)
                        .clipped()
                        .cornerRadius(20)
                        .shadow(radius: 5)
                } placeholder: {
                    Color.gray
                        .frame(width: 300, height: 400)
                        .cornerRadius(20)
                }
            }

            VStack {
                Spacer()
                HStack {
                    Text("\(profile.name.first), \(profile.dob.age)")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                        .shadow(radius: 2)
                    Spacer()
                }
                .padding()
                .background(Color.black.opacity(0.5))
            }
            .cornerRadius(20)
            .frame(width: 300, height: 400)

            HStack {
                Button(action: {
                    print("\(profile.name.first) disliked")
                    onAction()
                }) {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.red)
                        .padding()
                }
                Spacer()
                Button(action: {
                    print("\(profile.name.first) liked")
                    onAction()
                }) {
                    Image(systemName: "heart.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.green)
                        .padding()
                }
            }
            .frame(width: 300)
            .position(x: UIScreen.main.bounds.width / 2, y: 500)
        }
        .offset(x: offset.width, y: offset.height)
        .rotationEffect(.degrees(Double(offset.width / 20)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded { _ in
                    if offset.width > 100 {
                        print("\(profile.name.first) liked")
                        onAction()
                    } else if offset.width < -100 {
                        print("\(profile.name.first) disliked")
                        onAction()
                    }
                    offset = .zero
                }
        )
    }
}
