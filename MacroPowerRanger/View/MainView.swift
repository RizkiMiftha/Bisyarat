//
//  MainView.swift
//  MacroPowerRanger
//
//  Created by Muhammad Gilang Nursyahroni on 26/10/21.
//

import SwiftUI

struct MainView: View {
    
    @AppStorage("shouldShowOnboarding") var shouldShowOnboarding: Bool = true
    
    var body: some View {
        NavigationView {
            TabView() {
                CourseListView()
                    .tabItem {
                        Label("Belajar", systemImage: "book.fill")
                    }
                ChallengeListView()
                    .tabItem {
                        Label("Tantangan", systemImage: "flag.2.crossed.fill")
                    }
            }
            //.navigationBarHidden(true)
            .fullScreenCover(isPresented: $shouldShowOnboarding, content: { OnboardingView(shouldShowOnboarding: $shouldShowOnboarding)
                
            })
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
