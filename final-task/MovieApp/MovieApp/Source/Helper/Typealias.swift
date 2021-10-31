//
//  Typealias.swift
//  SpaseX
//
//  Created by rasul on 9/11/21.
//

import Foundation

typealias Models<T> = [T]
typealias ItemClosure<T> = ((T) -> Void)
typealias DoubleItemClosure<T, U> = ((T, U) -> Void)
typealias VoidClosure = (() -> Void)
//typealias Completion = (Result<Void, DatabaseError>) -> Void
//typealias CompletionItem = (Result<[WalletModel], DatabaseError>) -> Void
