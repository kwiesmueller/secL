//
//  ViewController.swift
//  secL
//
//  Created by Kevin Wiesmüller on 6/8/17.
//  Copyright © 2017 Kevin Wiesmüller. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSWindowDelegate{

    override func viewDidAppear() {
        self.view.window?.delegate = self
    }
    
    func windowShouldClose(_ sender: Any) {
        NSApplication.shared().terminate(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //self.view.window?.styleMask = NSWindowStyleMask.
        self.view.window?.backgroundColor = NSColor.black
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    @IBAction func sendKey(_ sender: NSSecureTextField) {
        if sender.stringValue == "666" {
            let appDelegate = NSApplication.shared().delegate as! AppDelegate
            appDelegate.ok = true
            NSApplication.shared().terminate(self)
        } else {
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

