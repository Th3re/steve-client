//
//  MultiselectView.swift
//  Steve
//
//  Created by Mateusz Stompór on 09/05/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import SwiftUI

struct MultiselectView<T: Selectable, V: View>: View {
    // MARK: - Properties
    @Binding var items: [T]
    var rowBuilder: (T) -> V
    var body: some View {
        List(items) { item in
            Button(action: { self.items.toggleSelected(item) }) { 
                self.rowBuilder(item)
            }
        }
    }
}
