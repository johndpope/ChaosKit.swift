//
//  vec3f.swift
//  ChaosKit
//
//  Created by Fu Lam Diep on 20.01.15.
//  Copyright (c) 2015 Fu Lam Diep. All rights reserved.
//

import Foundation

public struct vec3f : VectorType {
	public static let rows : Int = 3
	
	public static let cols : Int = 1
	
	public static var byteSize : Int {get {return elementCount * sizeof(GLfloat)}}
	
	/** The size of a vector */
	public static var elementCount : Int {get {return rows * cols}}
	
	private var vec : (x: GLfloat, y: GLfloat, z: GLfloat) = (0, 0, 0)
	
	public var x : GLfloat {
		get {return vec.x} set {vec.x = newValue}
	}
	
	public var y : GLfloat {
		get {return vec.y} set {vec.y = newValue}
	}
	
	public var z : GLfloat {
		get {return vec.z} set {vec.z = newValue}
	}
	
	public var array : [GLfloat] {
		return [x, y, z]
	}
	
	public var magnitude : GLfloat {
		return sqrt(self * self)
	}
	
	public var normalized : vec3f {
		let m = magnitude
		return vec3f(x/m, y/m, z/m)
	}
	
	public init () {
		
	}
	
	public init (_ x: GLfloat, _ y: GLfloat, _ z: GLfloat) {
		vec = (x, y, z)
	}
	
	public init (_ v: vec2) {
		vec = (v.x, v.y, 0)
	}
	
	public init (_ v: vec4) {
		vec = (v.x, v.y, v.z)
	}
	
	
	public init(_ array: [GLfloat]) {
		x = array.count > 0 ? array[0] : 0
		y = array.count > 1 ? array[1] : 0
		z = array.count > 2 ? array[2] : 0
	}
	
	
	subscript (index: Int) -> GLfloat {
		get {
			assert(valid(index), "Bad index access for vec2")
			switch index {
			case 0: return x
			case 1: return y
			default: return z
			}
		}
		
		set {
			assert(valid(index), "Bad index access for vec2")
			switch index {
			case 0: x = newValue
			case 1: y = newValue
			default: z = newValue
			}
		}
	}
	
	private func valid(index: Int) -> Bool {
		return index >= 0 && index < Int(vec3f.elementCount)
	}
}


extension vec3f : ArrayLiteralConvertible {
	public init(arrayLiteral elements: GLfloat...) {
		x = elements.count > 0 ? elements[0] : 0
		y = elements.count > 1 ? elements[1] : 0
		z = elements.count > 2 ? elements[2] : 0
	}
}


extension vec3f : Equatable {}

extension vec3f : Printable {
	public var description : String {get {return "(\(x), \(y), \(z))"}}
}

public func ==(l: vec3f, r: vec3f) -> Bool {
	return l.x == r.x && l.y == r.y && l.z == r.z
}


public prefix func -(v: vec3f) -> vec3f {
	return vec3f(-v.x, -v.y, -v.z)
}


public func +(l: vec3f, r: vec3f) -> vec3f {
	return vec3f(l.x + r.x, l.y + r.y, l.z + r.z)
}


public func -(l: vec3f, r: vec3f) -> vec3f {
	return l + -r
}


public func *(l: vec3f, r: vec3f) -> GLfloat {
	return l.x * r.x + l.y * r.y + l.z * r.z
}


public func *(l: vec3f, r: GLfloat) -> vec3f {
	return vec3f(l.x * r, l.y * r, l.z * r)
}


public func *(l: GLfloat, r: vec3f) -> vec3f {
	return r * l
}


public func •(l: vec3f, r: vec3f) -> vec3f {
	return vec3f(
		l.y * r.z - l.z * r.y,
		l.z * r.x - l.x * r.z,
		l.x * r.y - l.y * r.x
	)
}