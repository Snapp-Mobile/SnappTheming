//
//  Transaction.swift
//  Example
//
//  Created by Volodymyr Voiko on 29.01.2025.
//

import Foundation
import SwiftUI

struct Transaction: Identifiable {
    enum Category: String {
        case entertainment = "Entertainemnt"
        case cardTransfer = "Card Transfer"
        case groceries = "Groceries"
        case subscriptions = "Subscriptions"
    }

    struct Identity {
        static let timCook = Self(name: "Tim C.", image: "tim_cook_avatar")
        static let netflix = Self(name: "Netflix", image: "netflix_logo")
        static let lidl = Self(name: "Lidl", image: "lidl_logo")
        static let apple = Self(name: "Apple", image: "apple_logo")
        #if os(tvOS)
            static let mark = Self(name: "Mark S.", image: "mark_avatar")
            static let helly = Self(name: "Helly R.", image: "helly_avatar")
            static let irving = Self(name: "Irving B.", image: "irving_avatar")
            static let dylan = Self(name: "Dylan J.", image: "dylan_avatar")
        #endif

        let name: String
        let image: String
    }

    let id = UUID()
    let amount: Double
    let category: Category
    let identity: Identity
    let date: Date
}

extension Transaction: CaseIterable {
    #if os(tvOS)
        static var allCases: [Transaction] = [
            .init(
                amount: -9.99, category: .entertainment, identity: .netflix,
                date: .init(timeIntervalSinceNow: -24 * 60 * 60)),
            .init(
                amount: 999.99, category: .cardTransfer, identity: .timCook,
                date: .init(timeIntervalSinceNow: -2 * 24 * 60 * 60)),
            .init(
                amount: -125.12, category: .groceries, identity: .lidl,
                date: .init(timeIntervalSinceNow: -2 * 24 * 60 * 60 - 2 * 60 * 60)),
            .init(
                amount: -5.99, category: .subscriptions, identity: .apple,
                date: .init(timeIntervalSinceNow: -7 * 24 * 60 * 60)),
            .init(
                amount: 0.99, category: .cardTransfer, identity: .mark,
                date: .init(timeIntervalSinceNow: -4 * 24 * 60 * 60)),
            .init(
                amount: 434.00, category: .cardTransfer, identity: .dylan,
                date: .init(timeIntervalSinceNow: -5 * 24 * 60 * 60)),
            .init(
                amount: 661.44, category: .cardTransfer, identity: .irving,
                date: .init(timeIntervalSinceNow: -6 * 24 * 60 * 60)),
            .init(
                amount: 239.11, category: .cardTransfer, identity: .helly,
                date: .init(timeIntervalSinceNow: -8 * 24 * 60 * 60)),
            .init(
                amount: -15.42, category: .groceries, identity: .lidl,
                date: .init(timeIntervalSinceNow: -3 * 24 * 60 * 60 - 2 * 60 * 60)),
        ]
    #else
    static var allCases: [Transaction] = [
        .init(
            amount: -9.99, category: .entertainment, identity: .netflix,
            date: .init(timeIntervalSinceNow: -24 * 60 * 60)),
        .init(
            amount: 999.99, category: .cardTransfer, identity: .timCook,
            date: .init(timeIntervalSinceNow: -2 * 24 * 60 * 60)),
        .init(
            amount: -125.12, category: .groceries, identity: .lidl,
            date: .init(timeIntervalSinceNow: -2 * 24 * 60 * 60 - 2 * 60 * 60)),
        .init(
            amount: -5.99, category: .subscriptions, identity: .apple,
            date: .init(timeIntervalSinceNow: -7 * 24 * 60 * 60)),
    ]
    #endif
}
