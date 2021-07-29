//
//  AuthRequestFactory.swift
//  GBShop
//
//  Created by ALEKSANDR GRIGOREV on 29.07.2021.
//

import Foundation
import Alamofire

protocol AuthRequestFactory {
    func login(userName: String, password: String, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void)
}

