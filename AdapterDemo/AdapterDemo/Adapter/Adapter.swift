//
//  Adapter.swift
//  TableAdatperDemo
//
//  Created by hallfry on 2019/11/11.
//  Copyright © 2019 hallfry. All rights reserved.
//

import UIKit

// 对象适配器：适配器引用被适配对象
class Adapter: NSObject {
    let adaptee = Adaptee()
}

extension Adapter: Target {
    func getCNY() -> Float {
        return adaptee.getUSD()*6.88
    }
}

// 类适配器：适配器继承被适配对象
// 因为适配器继承自被适配者，耦合性高，不建议使用，推荐使用对象适配器
//class Adapter: Adaptee {
//
//}
//
//extension Adapter: Target {
//    func getCNY() -> Float {
//        return self.getUSD()*6.88
//    }
//}



