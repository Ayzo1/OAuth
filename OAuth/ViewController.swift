//
//  ViewController.swift
//  OAuth
//
//  Created by ayaz on 30.10.2022.
//

import UIKit
import AuthenticationServices

class ViewController: UIViewController {
	
	private let configuration: URLSessionConfiguration = .default
	private lazy var urlSession: URLSession = .init(configuration: configuration, delegate: self, delegateQueue: nil)

	override func viewDidLoad() {
		super.viewDidLoad()
		
		var request = URLRequest(url: URL(string: "\(AuthConfiguration.baseUrl)\(AuthConfiguration.authUri)")!)
		request.httpMethod = "GET"
		request.setValue(AuthConfiguration.clientId, forHTTPHeaderField: "client_id")
		request.setValue(String(AuthConfiguration.scopes), forHTTPHeaderField: "scope")
		request.setValue(AuthConfiguration.callbackUrl, forHTTPHeaderField: "redirect_uri")
		
		let dataTask = urlSession.dataTask(with: request) { data, response, error in
			guard (response as? HTTPURLResponse)?.statusCode == 200,
				let data = data,
				error == nil
			else {
				return
			}
			var a = 0
		}
		dataTask.resume()
	}
}

extension ViewController: URLSessionTaskDelegate {
	
	func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
		
		let session = ASWebAuthenticationSession(url: request.url!, callbackURLScheme: "ayzo.OAuth") { (url, error) in
			var a = 0
		}
		
		session.presentationContextProvider = self
		session.start()
	}
}

extension ViewController: ASWebAuthenticationPresentationContextProviding {
	
	func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
		let window = UIApplication.shared.windows.first { $0.isKeyWindow }
		return window ?? ASPresentationAnchor()
	}
}

struct AuthConfiguration {
	static let baseUrl = "https://github.com/"
	static let authUri = "login/oauth/authorize"
	static let tokenUri = "login/oauth/access_token"
	static let endSessionUri = "logout"
	static let scopes = "user:email repo"
	static let clientId = "1827072973953a461d71"
	static let clientSecret = "484fc0d352e1a67eee4dad76e1a5ddb1653fb3ee"
	static let callbackUrl = "ayzo.OAuth://github.com/callback"
	static let logoutCallbackUrl = ""
}
