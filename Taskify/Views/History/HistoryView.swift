//
//  HistoryView.swift
//  Taskify
//
//  Created by Jan Zimola on 31.01.2024.
//

import SwiftUI

import SwiftUI

struct HistoryView: View {
    @Binding var history: History

    var body: some View {

        ScrollView {
            VStack(alignment: .leading){
                Divider()
                    .padding(.bottom)
                Text(history.formattedDuration())
            }
        }
        .navigationTitle(Text(history.formattedDuration()))
        .padding()
    }
}

#Preview {
    HistoryView(
        history: .constant(History.sampleHistories[0]))
}
