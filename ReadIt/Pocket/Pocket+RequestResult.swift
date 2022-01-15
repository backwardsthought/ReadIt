//  
//  Pocket+RequestResult.swift
//  ReadIt
//
//  Created by Felipe Lobo on 27/05/21.
//  Copyright (c) 2021 Copyisright. All rights reserved.
//

import Foundation

extension Pocket {

	struct RequestResult: Decodable {
		let list: [String: Pocket]
		func getValues() -> [Pocket] {
            list.map { $1 }
		}
	}

}
