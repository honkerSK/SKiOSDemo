//
//  ViewController.swift
//  ExtensionWidgetDemo-swift
//
//  Created by sunke on 2018/5/25.
//  Copyright © 2018 sunke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Documnets目录
        //方法1
        //  /Users/sunke/Library/Developer/CoreSimulator/Devices/54473623-447E-4228-B259-F3416726335A/data/Containers/Data/Application/A93B5235-F2BA-49E0-94A8-FE7A872B20E5/Documents
//        let documentPaths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,
//                                                                FileManager.SearchPathDomainMask.userDomainMask, true)
//        let documnetPath = documentPaths[0]
//        print(documnetPath)

        //方法2
//        let ducumentPath2 = NSHomeDirectory() + "/Documents"

        let libraryPath:String = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        print("library路径----\(libraryPath)")
        
        let cachePath:String = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        print("Cache路径----\(cachePath)")
        
        let preferPath:String = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.preferencePanesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        print("Prefer路径----\(preferPath)")
        
        let homeDir:String = NSHomeDirectory()
        print("沙盒地址---\(homeDir)")
        
//        let imagePath = Bundle.main.path(forResource: "sale", ofType: "png")!
//        print("FlyElephnt-图片路径----\(imagePath)")
        
        let bundlePath = Bundle.main.bundleURL.path
        print("FlyElephnt-App资源文件路径--\(bundlePath)")
        
        let testDataPath = Bundle.main.bundleURL.appendingPathComponent("FlyElephant").path
        print("压缩文件的路径---\(testDataPath)")
        
       
        
        
    }


}


