//
//  RemoteImage.swift
//  Steve
//
//  Created by Mateusz Stompór on 27/04/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import SwiftUI
import Combine

class RemoteImageURL: ObservableObject {
    // MARK: - Properties
    var didChange = PassthroughSubject<UIImage?, Never>()
    var image: UIImage? {
        didSet {
            didChange.send(image)
            
        }
    }
    // MARK: - Internal
    func fetch(url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data else {
                self?.image = nil
                return
            }
            DispatchQueue.main.async {
                self?.image = UIImage(data: data)
            }
        }.resume()
    }
}

struct RemoteImage: View {
    @ObservedObject var imageDownloader = RemoteImageURL()
    @State var image = UIImage()
    init(url: URL) {
        imageDownloader.fetch(url: url)
    }
    init() {
    }
    var body: some View {
        Image(uiImage: image).resizable().onReceive(imageDownloader.didChange) { output in
            self.image = output ?? UIImage()
        }
    }
}

struct RemoteImage_Previews: PreviewProvider {
    static var previews: some View {
        RemoteImage()
    }
}
