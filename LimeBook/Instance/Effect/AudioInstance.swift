//
//  AudioInstance.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/29/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit
import AVFoundation

let  audioInstance = AudioInstance.sharedInstance()

class AudioInstance: NSObject {
    
    var player: AVAudioPlayer!

    static var instance: AudioInstance!

    class func sharedInstance() -> AudioInstance
    {
        if(self.instance == nil)
        {
            self.instance = (self.instance ?? AudioInstance())
            notifyInstance.addM(self.instance, .messageReceive, selector: #selector(playSound))

            self.instance.configAudio()
        }
        return self.instance
    }

    func configAudio()
    {
        do {
            guard let url = Bundle.main.url(forResource: "chord", withExtension: "mp3") else { return }
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    @objc func playSound()
    {
        player?.play()
    }

}
