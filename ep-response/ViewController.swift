//
//  ViewController.swift
//  ep-response
//
//  Created by 乐野 on 2016/12/9.
//  Copyright © 2016年 乐野. All rights reserved.
//

import UIKit
import Accelerate

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var numbersA: [NSNumber] = []
        var numbersB: [NSNumber] = []
        let result: NSMutableArray = []

 /*
        numbersA = [1.0, -3.5794348, 5.6586672, -4.9654152, 2.5294949, -0.70527411, 0.083756480]
        numbersB = [0.28940692, -1.7364415, 4.3411038, -5.7881383, 4.3411038, -1.7364415, 0.28940692]
        
        AM_RESPONSE.test_ep_amsponse_(ofB: numbersB, andA: numbersA, order: 7, am_result: result, length: 64)
        
        for number in result {
            print(number)
        }
 */
        AM_RESPONSE.test_fft()
//        AM_RESPONSE.test_dft()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

