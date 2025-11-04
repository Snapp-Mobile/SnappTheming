//
//  Transaction.swift
//  Example
//
//  Created by Volodymyr Voiko on 29.01.2025.
//

import Foundation
import SwiftUI

@MainActor
struct Transaction: Identifiable, @MainActor CaseIterable {
    enum Category: String {
        case entertainment = "Entertainment"
        case cardTransfer = "Card Transfer"
        case groceries = "Groceries"
        case subscriptions = "Subscriptions"
    }

    struct Identity {
        static let timCook = Self(name: "Tim C.", image: "tim_cook_avatar")
        static let netflix = Self(name: "Netflix", image: "netflix_logo")
        static let lidl = Self(name: "Lidl", image: "lidl_logo")
        static let apple = Self(name: "Apple", image: "apple_logo")
        static let mark = Self(name: "Mark S.", image: "mark_avatar")
        static let helly = Self(name: "Helly R.", image: "helly_avatar")
        static let irving = Self(name: "Irving B.", image: "irving_avatar")
        static let dylan = Self(name: "Dylan J.", image: "dylan_avatar")

        let name: String
        let image: String
    }

    let id = UUID()
    let amount: Double
    let category: Category
    let identity: Identity
    let date: Date

    #if os(tvOS) || os(macOS) || os(visionOS)
        static var allCases: [Transaction] = extended
    #else
        static var allCases: [Transaction] {
            #if os(iOS)
                if UIDevice.current.userInterfaceIdiom == .pad {
                    return extended
                }
            #endif
            return base
        }
    #endif
    static private var extended: [Transaction] = base + additional

    static private var base: [Transaction] = [
        Transaction(
            amount: -9.99, category: .entertainment, identity: .netflix,
            date: Date(timeIntervalSinceNow: -24 * 60 * 60)),
        Transaction(
            amount: 999.99, category: .cardTransfer, identity: .timCook,
            date: Date(timeIntervalSinceNow: -2 * 24 * 60 * 60)),
        Transaction(
            amount: -125.12, category: .groceries, identity: .lidl,
            date: Date(timeIntervalSinceNow: -2 * 24 * 60 * 60 - 2 * 60 * 60)),
        Transaction(
            amount: -5.99, category: .subscriptions, identity: .apple,
            date: Date(timeIntervalSinceNow: -7 * 24 * 60 * 60)),
    ]

    static private var additional: [Transaction] = [
        Transaction(
            amount: 0.99, category: .cardTransfer, identity: .mark,
            date: Date(timeIntervalSinceNow: -4 * 24 * 60 * 60)),
        Transaction(
            amount: 434.00, category: .cardTransfer, identity: .dylan,
            date: Date(timeIntervalSinceNow: -5 * 24 * 60 * 60)),
        Transaction(
            amount: 661.44, category: .cardTransfer, identity: .irving,
            date: Date(timeIntervalSinceNow: -6 * 24 * 60 * 60)),
        Transaction(
            amount: 239.11, category: .cardTransfer, identity: .helly,
            date: Date(timeIntervalSinceNow: -8 * 24 * 60 * 60)),
        Transaction(
            amount: -15.42, category: .groceries, identity: .lidl,
            date: Date(timeIntervalSinceNow: -3 * 24 * 60 * 60 - 2 * 60 * 60)),
    ]
}
