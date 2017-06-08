//
//  AppDelegate.swift
//  secL
//
//  Created by Kevin Wiesmüller on 6/8/17.
//  Copyright © 2017 Kevin Wiesmüller. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var ok = false;
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        if ok == false {
            lockScreen()
        }
    }
    
    func setOk(v: Bool) {
        ok = v
    }

    func applicationWillResignActive(_ notification: Notification) {
        if ok == false {
            lockScreen()
        }
    }
    
    func lockScreen() {
        for _ in 1...5 {          
            let libHandle = dlopen("/System/Library/PrivateFrameworks/login.framework/Versions/Current/login", RTLD_LAZY)
            let sym = dlsym(libHandle, "SACLockScreenImmediate")
            typealias myFunction = @convention(c) (Void) -> Void
            let SACLockScreenImmediate = unsafeBitCast(sym, to: myFunction.self)
            SACLockScreenImmediate()
        }
    }
}

