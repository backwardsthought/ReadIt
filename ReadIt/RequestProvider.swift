//  
//  RequestProvider.swift
//  ReadIt
//
//  Created by Felipe Lobo on 13/05/21.
//  Copyright (c) 2021 Copyisright. All rights reserved.
//

import Foundation
import Combine

protocol RequestProvider {

	func request<R, T>(_: T, decodedType: R.Type) -> AnyPublisher<R, Error> where T: Target, R: Decodable

}
