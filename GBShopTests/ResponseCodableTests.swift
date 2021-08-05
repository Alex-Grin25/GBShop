//
//  ResponseCodableTests.swift
//  GBShopTests
//
//  Created by ALEKSANDR GRIGOREV on 05.08.2021.
//

import XCTest
import Alamofire

struct PostStub: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

enum ApiErrorStub: Error {
    case fatalError
}

struct ErrorParserStub: AbstractErrorParser {
    func parse(_ result: Error) -> Error {
        return ApiErrorStub.fatalError
    }
    
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
        return error
    }
}

let urlString = "https://jsonplaceholder.typicode.com/posts/1"
class ResponseCodableTests: XCTestCase {
    
    let expectation = XCTestExpectation(description: "Download \(urlString)")
    var errorParser: ErrorParserStub!

    override func setUp() {
        super.setUp()
        errorParser = ErrorParserStub()
    }
    
    override func tearDown() {
        super.tearDown()
        errorParser = nil
    }
    
    func testShouldDownloadAndParse() {
        AF
            .request(urlString)
            .responseCodable(errorParser: errorParser) { [weak self] (response: DataResponse<PostStub,AFError>) in
                switch response.result {
                case .success(_): break
                case .failure:
                    XCTFail()
                }
                self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
}
