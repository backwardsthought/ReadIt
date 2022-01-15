//  
//  AuthenticationContextProviding.swift
//  ReadIt
//
//  Created by Felipe Lobo on 27/05/21.
//  Copyright (c) 2021 Copyisright. All rights reserved.
//

import Foundation
import AuthenticationServices

protocol AuthenticationPresentationContextWrapping {

	func getPresentationContextProvider() -> ASWebAuthenticationPresentationContextProviding

}
