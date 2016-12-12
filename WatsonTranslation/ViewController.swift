//
//  ViewController.swift
//  WatsonTranslation
//
//  Created by IIC on 12/12/16.
//  Copyright © 2016 IIC. All rights reserved.
//

import UIKit
import TextToSpeechV1
import LanguageTranslatorV2
import AVFoundation

class ViewController: UIViewController {

    var languageTranslationService : LanguageTranslator!
    var textToSpeechService : TextToSpeech!
    var audioPlayer : AVAudioPlayer!
    var selectedVoice : String!
    
    // MARK: Props
    // put in the watson services here. Text to speech and translation for now.
    @IBOutlet weak var toTranslateField: UITextField!
    
    // MARK: Actions
    @IBAction func translateButtonPressed(_ sender: UIButton) {
        let failure = { (error: Error) in print(error) }
        
        if let text = self.toTranslateField?.text {
            self.languageTranslationService.translate(text, from: "en", to: "fr", failure: failure) { translation in
                let firstTranslation = translation.translations[0].translation
                
                print(firstTranslation)
                
                self.textToSpeechService.synthesize(firstTranslation, voice: "fr-FR_ReneeVoice", failure: failure) { data in
                   self.audioPlayer = try! AVAudioPlayer(data: data)
                   self.audioPlayer.prepareToPlay()
                   self.audioPlayer.play()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.white
        self.textToSpeechService = TextToSpeech(username: "fcebe167-c753-4068-8e8c-e99c433c5621", password: "ARQRv0QYmY6e")
        self.languageTranslationService = LanguageTranslator(username: "509d8694-5f9e-443e-99a8-7b397c0626cb", password: "Ep4LCnwvnFiF")
        self.audioPlayer = AVAudioPlayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

