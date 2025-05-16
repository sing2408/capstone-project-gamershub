//
//  RoutingProtocol.swift
//  Shared
//
//  Created by Singgih Tulus Makmud on 13/05/25.
//

import SwiftUI

public protocol RoutingProtocol {
    associatedtype DetailViewType: View
    associatedtype SavedViewType: View
    associatedtype AboutViewType: View
    associatedtype HomeViewType: View

    func makeDetailView(for gameId: Int) -> DetailViewType
    func makeSavedView() -> SavedViewType
    func makeAboutView() -> AboutViewType
    func makeHomeView() -> HomeViewType
}
