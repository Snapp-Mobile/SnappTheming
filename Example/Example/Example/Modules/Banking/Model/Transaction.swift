//
//  Transaction.swift
//  Example
//
//  Created by Volodymyr Voiko on 29.01.2025.
//

import Foundation

struct Transaction: Identifiable {
    enum Category: String {
        case entertainment = "Entertainemnt"
        case cardTransfer = "Card Transfer"
        case groceries = "Groceries"
        case subscriptions = "Subscriptions"
    }

    struct Identity {
        static let timCook = Self(name: "Tim Cook", image: "tim_cook_avatar")
        static let netflix = Self(name: "Netflix", image: "netflix_logo")
        static let lidl = Self(name: "Lidl", image: "lidl_logo")
        static let apple = Self(name: "Apple", image: "apple_logo")

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
}
