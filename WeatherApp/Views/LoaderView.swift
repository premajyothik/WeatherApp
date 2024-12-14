//
//  LoaderView.swift
//  WeatherApp
//
//  Created by Premajyothi kilaparti on 14/12/24.
//

import SwiftUI

struct LoaderView: View {
    var body: some View {
        ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    LoaderView()
}
