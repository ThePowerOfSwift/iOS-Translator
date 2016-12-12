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

    // MARK: Properties
    var languageTranslationService : LanguageTranslator!
    var textToSpeechService : TextToSpeech!
    var audioPlayer : AVAudioPlayer!
    var selectedVoice : String!
    
    @IBOutlet weak var toTranslateField: UITextField!
    
    // MARK: Actions
    @IBAction func translateButtonPressed(_ sender: UIButton) {
        let failure = { (error: Error) in print(error) }
        
        // If the text field has text in it
        if let text = self.toTranslateField?.text {
            // translate it to french
            self.languageTranslationService.translate(text, from: "en", to: "fr", failure: failure) { translation in
                
                // from the result, get the first provided translation, as there can be more than one provided
                let firstTranslation = translation.translations[0].translation
                
                print(firstTranslation)
                
                // Say the translated text using the french voice
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
        
        // MARK: Insert credentials for bluemix Watson services here before using, otherwise the program won't work!
        self.textToSpeechService = TextToSpeech(username: "", password: "")
        self.languageTranslationService = LanguageTranslator(username: "", password: "")
        self.audioPlayer = AVAudioPlayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

