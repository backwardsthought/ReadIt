//
// Created by Felipe Lobo on 21/08/18.
// Copyright (c) 2018 Copyisright. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {

	static func equal(from a: Any, to b: Any?, attr: NSLayoutAttribute, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0) -> NSLayoutConstraint {
		return create(from: a, attr, to: b, b != nil ? attr : .notAnAttribute, multiplier: multiplier, constant: constant)
	}

	static func equal(from a: Any, to b: Any?, attrs: [NSLayoutAttribute], multiplier: CGFloat = 1.0, constant: CGFloat = 0.0) -> [NSLayoutConstraint] {
		return attrs.map {
			create(from: a, $0, to: b, b != nil ? $0 : .notAnAttribute, multiplier: multiplier, constant: constant)
		}
	}

	static func gte(from a: Any, to b: Any?, attr: NSLayoutAttribute, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0) -> NSLayoutConstraint {
		return create(.greaterThanOrEqual, from: a, attr, to: b, b != nil ? attr : .notAnAttribute, multiplier: multiplier, constant: constant)
	}

	static func gte(from a: Any, to b: Any?, attrs: [NSLayoutAttribute], multiplier: CGFloat = 1.0, constant: CGFloat = 0.0) -> [NSLayoutConstraint] {
		return attrs.map {
			create(.greaterThanOrEqual, from: a, $0, to: b, b != nil ? $0 : .notAnAttribute, multiplier: multiplier, constant: constant)
		}
	}

	static func lte(from a: Any, to b: Any?, _ attr: NSLayoutAttribute, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0) -> NSLayoutConstraint {
		return create(.lessThanOrEqual, from: a, attr, to: b, b != nil ? attr : .notAnAttribute, multiplier: multiplier, constant: constant)
	}

	static func lte(from a: Any, to b: Any?, _ attrs: [NSLayoutAttribute], multiplier: CGFloat = 1.0, constant: CGFloat = 0.0) -> [NSLayoutConstraint] {
		return attrs.map {
			create(.lessThanOrEqual, from: a, $0, to: b, b != nil ? $0 : .notAnAttribute, multiplier: multiplier, constant: constant)
		}
	}

	static func width(_ relation: NSLayoutRelation = .equal, value: CGFloat, of a: Any) -> NSLayoutConstraint {
		return create(relation, from: a, .width, to: nil, .notAnAttribute, constant: value)
	}

	static func height(_ relation: NSLayoutRelation = .equal, value: CGFloat, of a: Any) -> NSLayoutConstraint {
		return create(relation, from: a, .height, to: nil, .notAnAttribute, constant: value)
	}

	static func create(_ relation: NSLayoutRelation = .equal, from a: Any, _ attrA: NSLayoutAttribute, to b: Any?, _ attrB: NSLayoutAttribute, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0) -> NSLayoutConstraint {
		return NSLayoutConstraint(item: a, attribute: attrA, relatedBy: relation, toItem: b, attribute: attrB, multiplier: multiplier, constant: constant)
	}

}
