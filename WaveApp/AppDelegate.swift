//
//  AppDelegate.swift
//  WaveApp
//
//  Created by Johann Garces on 10/29/17.
//  Copyright © 2017 johannmg. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    
    lazy var screenSaverView = Wave(frame: NSZeroRect, isPreview: false)

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        screenSaverView?.frame = window.contentView!.frame
        window.contentView?.addSubview(screenSaverView!)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

/*
 
 lazy var screenSaverView = ImageStreamView(frame: NSZeroRect, isPreview: false)
 
 func applicationDidFinishLaunching(aNotification: NSNotification) {
 if let screenSaverView = screenSaverView {
 screenSaverView.frame = window.contentView.bounds;
 window.contentView.addSubview(screenSaverView);
 }
 }
 */
