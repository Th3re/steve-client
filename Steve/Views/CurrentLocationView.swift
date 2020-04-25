//
//  CurrentLocationView.swift
//  Steve
//
//  Created by Piotr Persona on 15/04/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import SwiftUI

struct CurrentLocationView: View {
    @ObservedObject var model: CurrentLocationViewModel = CurrentLocationViewModel()
    var body: some View {
        ZStack {
            Color.theme
            VStack {
                Text("Current Location")
                    .foregroundColor(.white)
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                Text("\(model.location?.coordinate.latitude ?? 0) \(model.location?.coordinate.longitude ?? 0)")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
            }
        }
    }
}

struct CurrentLocationView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentLocationView()
    }
}
