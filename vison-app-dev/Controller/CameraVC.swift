//
//  CameraVC.swift
//  vison-app-dev
//
//  Created by Kien on 12/11/18.
//  Copyright © 2018 Kien. All rights reserved.
//

import UIKit
import AVFoundation
import CoreML
import Vision

enum FlashState {
    case off
    case on
}


class CameraVC: UIViewController {
    
    var captureSession:AVCaptureSession!
    var cameraOutput:AVCapturePhotoOutput!
    var previewLayer:AVCaptureVideoPreviewLayer!
    
    
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var scoreLbl: UILabel!
    var photoData: Data?
    
    var flashControlState: FlashState = .off
    var inputPridiction:String?
    
    @IBOutlet weak var objectDetect: UILabel!
    
    var speechSynthesizer = AVSpeechSynthesizer()
    
    var count = 20
    var score = 0

    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var captureImageView: RoudedShadowImageView!

    @IBOutlet weak var flashBtn: UIButton!
    
    @IBOutlet weak var roundedLblView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        objectDetect.text = "Find \(inputPridiction!)"
        
//        var timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)

        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        previewLayer.frame = cameraView.bounds
        
        speechSynthesizer.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapCameraView))
        tap.numberOfTapsRequired = 1
        
        
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSession.Preset.hd1280x720
        let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
        do{
            let input =  try AVCaptureDeviceInput(device: backCamera!)
            if captureSession.canAddInput(input)  ==  true{
                captureSession.addInput(input)
                
            }
            
            cameraOutput =  AVCapturePhotoOutput();
            
            if captureSession.canAddOutput(cameraOutput) == true {
                captureSession.addOutput(self.cameraOutput)
                previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
                previewLayer.videoGravity =  AVLayerVideoGravity.resizeAspect
                previewLayer.connection?.videoOrientation =  AVCaptureVideoOrientation.portrait
                cameraView.layer.addSublayer(previewLayer!)
                cameraView.addGestureRecognizer(tap)
                captureSession.startRunning()            }
            
        }catch{
            
            debugPrint(error)
        }
    }
    
    
    
    @objc func didTapCameraView() {
        self.cameraView.isUserInteractionEnabled = false
        

        let settings = AVCapturePhotoSettings()
        let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
        let previewFormat = [kCVPixelBufferPixelFormatTypeKey as String: previewPixelType, kCVPixelBufferWidthKey as String: 160, kCVPixelBufferHeightKey as String: 160]
        
        settings.previewPhotoFormat = previewFormat
        
        if flashControlState == .off {
            settings.flashMode = .off
        } else {
            settings.flashMode = .on
        }
        
        cameraOutput.capturePhoto(with: settings, delegate: self)
    }
    
    @objc func update()  {
        if count > 0{
            count -= 1
            timerLbl.text = String(count)
            
        }
    }
    
    @available(iOS 11.0, *)
    func resultsMethod(request: VNRequest, error: Error?) {
        
        guard let results = request.results as? [VNClassificationObservation] else { return }
        
        
        for classification in results {
            let identification = classification.identifier

            if classification.confidence < 0.5 {
                
                let unknownObjectMessage = "Please try again"
                synthesizeSpeech(fromString: unknownObjectMessage)
                break
            }else if inputPridiction == identification{


//                DispatchQueue.main.async {
                    self.score += 1

                    self.scoreLbl.text = String(self.score)

                    let completeSentence = "Hey you found \(identification)"
                    self.synthesizeSpeech(fromString:completeSentence)
                
                    print("i'm here")

//                }
                
//                presentDetail()
                let result = ResultVC()
//
//                result.modalTransitionStyle = .coverVertical
//                result.modalPresentationStyle = .overCurrentContext
                self.present(result, animated: true, completion: nil)
            

            
                
                break
            }
        }
    }
    
    func synthesizeSpeech(fromString string: String) {
        let speechUtterance = AVSpeechUtterance(string: string)
        speechSynthesizer.speak(speechUtterance)
    }
    func presentDetail() {
        
    let result = ResultVC()

        result.modalTransitionStyle = .coverVertical
        result.modalPresentationStyle = .overCurrentContext
        self.present(result, animated: true, completion: nil)

//        guard let resultVC = storyboard?.instantiateViewController(withIdentifier: "popupResult") as? ResultVC else { return }
//        //
//        present(resultVC, animated: true, completion: nil)
//
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    


}

extension CameraVC: AVCapturePhotoCaptureDelegate {
    @available(iOS 11.0, *)
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            debugPrint(error)
        } else {
            photoData = photo.fileDataRepresentation()
            
            do {
                guard let model = try? VNCoreMLModel(for: ObjectClassifier().model) else {
                    
                    fatalError("can't load Places ML model")

                }
                
                let request = VNCoreMLRequest(model: model, completionHandler: resultsMethod)
                let handler = VNImageRequestHandler(data: photoData!)
                try handler.perform([request])
            } catch {
                debugPrint(error)
            }
            
            let image = UIImage(data: photoData!)
            self.captureImageView.image = image
        }
    }
}

extension CameraVC: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        self.cameraView.isUserInteractionEnabled = true
//        self.spinner.isHidden = true
//        self.spinner.stopAnimating()
    }
}


