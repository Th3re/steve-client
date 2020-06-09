//
//  MapView.swift
//  Steve
//
//  Created by Mateusz Stompór on 08/06/2020.
//  Copyright © 2020 Th3re. All rights reserved.
//

import UIKit
import MapKit
import SwiftUI

protocol AnnotationSelectionDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView)
}

class MKMapViewDelegateProxy: NSObject, MKMapViewDelegate {
    // MARK: - Properties
    var delegate: AnnotationSelectionDelegate?
    // MARK: - MKMapViewDelegate
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        delegate?.mapView(mapView, didSelect: view)
    }
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        delegate?.mapView(mapView, didDeselect: view)
    }
}

struct MapView: UIViewRepresentable, AnnotationSelectionDelegate {
    // MARK: - Properties
    @Binding var selectedPlace: Place?
    let shownPlaces: [Place]
    private var annotations = [MKPointAnnotation]()
    private let proxy = MKMapViewDelegateProxy()
    // MARK: - Initialization
    init(selectedPlace: Binding<Place?>, places: [Place]) {
        self.shownPlaces = places
        self._selectedPlace = selectedPlace
        proxy.delegate = self
    }
    // MARK: - Private
    private func buildAnnotations() -> [MKPointAnnotation] {
        var result = [MKPointAnnotation]()
        for place in shownPlaces {
            let annotation = MKPointAnnotation()
            annotation.title = place.address
            annotation.coordinate = place.location
            result.append(annotation)
        }
        return result
    }
    // MARK: - UIViewRepresentable
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: UIScreen.main.bounds)
        return mapView
    }
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.delegate = proxy
        uiView.removeAnnotations(annotations)
        let annotations = buildAnnotations()
        uiView.addAnnotations(annotations)
        uiView.showAnnotations(annotations, animated: true)
    }
    // MARK: - AnnotationSelectionDelegate
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        selectedPlace = shownPlaces.first { $0.location.latitude == view.annotation?.coordinate.latitude &&
            $0.location.longitude == view.annotation?.coordinate.longitude
        }
    }
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        selectedPlace = nil
    }
}
