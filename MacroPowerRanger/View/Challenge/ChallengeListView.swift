//
//  PracticeListView.swift
//  Bisyarat
//
//  Created by Muhammad Gilang Nursyahroni on 10/11/21.
//

import SwiftUI

struct ChallengeListView: View {
    @ObservedObject var viewModel = ChallengeListViewModel()
    
    private let gridItems = [GridItem(.flexible(), spacing: 10),GridItem(.flexible(), spacing: 110)]
    
    var body: some View {
        
            ScrollView{
                LazyVGrid(columns: gridItems, content: {
                    ForEach(viewModel.challenges, id: \.id){practice in
                        NavigationLink(destination: ChallengeView()){
                            ChallengeListCellView(
                                title: practice.title,
                                bgImage: practice.bgImage
                            )
                        }
                    }
                })
            }
        
        .navigationTitle("Tantangan")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PracticeListView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeListView()
    }
}