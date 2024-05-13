//
//  ViewController.swift
//  hhh
//
//  Created by Youngbin Choi on 1/10/24.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let instance = SomeType()
        let bstance = AnyType()
        
        let young = A()
        young.a(instance)
        let Young = A()
        Young.a(bstance)
        
        let bin = C()
        bin.c(instance)
        let Bin = C()
        Bin.c(bstance)
    }
}

protocol Ax {
    func a<S: Bx>(_ b: S)
}

protocol Cx {
    func c(_ b: Bx)
}

protocol Bx {
    func b()
}

class A: Ax {
    func a<S>(_ b: S) where S : Bx {
        print("Hi")
    }
}

class C: Cx {
    func c(_ b: Bx) {
        print("Bye")
    }
}

class SomeType: Bx, Equatable {
    static func == (lhs: SomeType, rhs: SomeType) -> Bool {
        return true
    }
    
    func b() {
        print("SomeType's implementation of b")
    }
}

class AnyType: Bx{
    
    func b() {
        print("SomeType's implementation of b")
    }
}



