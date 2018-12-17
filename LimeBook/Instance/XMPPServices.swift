//
//  XMPPServices.swift
//  LimeBook
//
//  Created by Lê Dũng on 10/23/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit
import XMPPFramework     // Swift

let  xmppServices = XMPPServices.sharedInstance()

class XMPPServices: NSObject , XMPPStreamDelegate{
    static var instance: XMPPServices!

    var xmppStream : XMPPStream = XMPPStream.init()
    class func sharedInstance() -> XMPPServices
    {
        if(self.instance == nil)
        {
            self.instance = (self.instance ?? XMPPServices())
        }
        return self.instance
    }
    
    func connect ()
    {
        xmppStream.hostName = "mibook.vn"
        xmppStream.hostPort = 5223 ;
        xmppStream.myJID = XMPPJID.init(string: "admin")
        xmppStream.startTLSPolicy = .required

        xmppStream.addDelegate(self, delegateQueue: DispatchQueue.main)
        do {

        _ = try xmppStream.connect(withTimeout: XMPPStreamTimeoutNone)
        }
        catch {
        }

    }
    
    
    func xmppStream(_ sender: XMPPStream, didReceive trust: SecTrust, completionHandler: @escaping (Bool) -> Void) {
        completionHandler(true)
    }
    
    func xmppStreamDidConnect(_ sender: XMPPStream) {
        print("xmppStreamDidConnect")
    }
    
    func xmppStreamDidDisconnect(_ sender: XMPPStream, withError error: Error?) {
        print("xmppStreamDidDisconnect : \(error?.localizedDescription)")

    }
    
    func xmppStreamConnectDidTimeout(_ sender: XMPPStream) {
        print("xmppStreamConnectDidTimeout )")

    }
    
    func xmppStream(_ sender: XMPPStream, willSecureWithSettings settings: NSMutableDictionary) {
        let expectedCertName: String? = xmppStream.myJID?.domain

        if expectedCertName != nil {
            settings[kCFStreamSSLPeerName as String] = expectedCertName
        }
            settings[GCDAsyncSocketManuallyEvaluateTrust] = true

    }

}
