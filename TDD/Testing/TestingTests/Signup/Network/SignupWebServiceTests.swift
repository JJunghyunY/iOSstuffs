//
//  SignupWebServiceTests.swift
//  TestingTests
//
//  Created by Junyoo on 3/2/24.
//

import XCTest
@testable import Testing

final class SignupWebServiceTests: XCTestCase {
    
    var sut: SignupWebService!
    var signFormRequestModel: SignupFormRequestModel!

    override func setUpWithError() throws {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        
        sut = SignupWebService(urlString: SignupConstants.signupURLString, urlSession: urlSession)
        signFormRequestModel = SignupFormRequestModel(firstName: "jun", lastName: "yoo", email: "test@test.com", password: "12345678")
    }

    override func tearDown() {
        sut = nil
        signFormRequestModel = nil
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.error = nil
    }
    
    func testSignupWebService_WhenGivenSuccessfullResponse_ReturnSuccess() {
        let jsonString = "{\"status\":\"ok\"}"
        MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)

        let expectation = self.expectation(description: "Signup Web service Response Expectation")
        
        sut.signup(withForm: signFormRequestModel) { (SignupResponseModel, error) in
            XCTAssertEqual(SignupResponseModel?.status, "ok")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testSignupWebService_WhenReceivedDifferentJsonResponse_ErrorTookPlace() {
        let jsonString = "{\"path\":\"/users\", \"error\":\"Internal Server Error\"}"
        MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)
                
        let expectation = self.expectation(description: "signup method expectation for a response that contains a different JSON structure")
        
        sut.signup(withForm: signFormRequestModel) { (SignupResponseModel, error) in
            XCTAssertNil(SignupResponseModel, "the response model for a request containing unknown JSON response, should have been nil")
            XCTAssertEqual(error, SignupError.invalidResponseModel, "the signup method did not return expected error")
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testSignupWebService_WhenEmptyURLStringProvided_ReturnsError() {
        let expectation = self.expectation(description: "An empty request URL String expectation")
        sut = SignupWebService(urlString: "")
        
        sut.signup(withForm: signFormRequestModel) { signupResponseModel, error in
            XCTAssertEqual(error, SignupError.invalidRequestURLString, "the signup method did not return an expected error for an invalidRequestURL error")
            XCTAssertNil(signupResponseModel, "when an invalidRequestURLString takes place, the response model must be nil ")
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 2)
    }
    
    func testSignupWebService_WhenURLRequestFails_ReturnsErrorMessageDescription() {
        let expectation = self.expectation(description: "a failed request expactation")
        let errorDescription = "A localized description of an error"
        MockURLProtocol.error = SignupError.failedRequest(description: errorDescription)
        
        sut.signup(withForm: signFormRequestModel) { signupResponseModel, error in
            XCTAssertEqual(error, SignupError.failedRequest(description: errorDescription), "the signup method did not return an expecter error for the failed request")
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 2)
    }
}
