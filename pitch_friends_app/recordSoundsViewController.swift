//
//  ViewController.swift
//  pitch_friends_app
//
//  Created by Daniel Felipe Valencia Rodriguez on 27/02/22.
//

import UIKit
import AVFoundation

class recordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var RecordButton: UIButton!
    @IBOutlet weak var StopButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("starting recording process")
    }

    @IBAction func recordAudio(_ sender: AnyObject) {
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string : pathArray.joined(separator: "/"))
        print (filePath ?? "sorry nothig to save")
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options:
                                    AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        print("recording in progress")
        
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        print("recording stopped")
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }else {
            print("recording was not successful")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording"{
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL }
    }
}
/**
    
     func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
         if flag {
             performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
         }else {
             print("recording was not successful")
         }
     }
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "stopRecording"{
             let playSoundsVC = segue.destination as! PlaySoundsViewController
             let recordedAudioURL = sender as! URL
             playSoundsVC.recordedAudioURL = recordedAudioURL }
     }

 }
 */
