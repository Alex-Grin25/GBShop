//
//  AbstractErrorParser.swift
//  GBShop
//
//  Created by ALEKSANDR GRIGOREV on 29.07.2021.
//

import Foundation

protocol AbstractErrorParser {
    func parse(_ result: Error) -> Error
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
}
