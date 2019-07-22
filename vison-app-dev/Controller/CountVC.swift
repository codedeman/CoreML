//
//  CountVC.swift
//  vison-app-dev
//
//  Created by Apple on 7/5/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit
import AVFoundation
import CoreML
import Vision
import Firebase

class CountVC: UIViewController {
    
    @IBOutlet weak var findLbl: UILabel?
    @IBOutlet weak var countLabel: UILabel?
    @IBOutlet weak var backgroundResult: UIView?
    
    @IBOutlet weak var timerIncreaseLbl: UILabel!
    // variable
    var speechSynthesizer = AVSpeechSynthesizer()
    var count:Int? = 3
    var db : Firestore!
    var listener:ListenerRegistration!
    var categories = [Category]()
    var identifier:Category!
    var imageArr = [Data]()
    var number:Int?
    var timer:Timer?
    var timerDynamic:Int?
    var prediction:ObjectClassifier!
    var score:Int!
    var second  =  20;
    override func viewDidLoad() {
        super.viewDidLoad()
        timerIncreaseLbl.text =  "in under \(timerDynamic ?? 20) seconds"
        speechSynthesizer.delegate = self

        db =  .firestore()


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        db =  .firestore()

        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)

        self.backgroundResult?.isHidden = true

        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        speechSynthesizer.delegate = self

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)


    }
    
    
    @objc func update()
    {
        
        if count ?? 3 > 0{
            
            count! -= 1

            if count == 2{
                self.view.backgroundColor = #colorLiteral(red: 0.9608203769, green: 0.5931894183, blue: 0.1159928367, alpha: 1)
            }
            
            if count == 1{
                self.view.backgroundColor = #colorLiteral(red: 0, green: 0.9244301915, blue: 0, alpha: 1)
            }
            
            if count == 0{
            
                
                countLabel?.isHidden = true
                backgroundResult?.isHidden = false
                getPredict { (image) in
                    let thePixelBuffer : CVPixelBuffer?
                    thePixelBuffer = self.pixelBufferFromImage(image: image)
                    guard let prediction =  try? ObjectClassifier().prediction(image: thePixelBuffer!) else { return }
                    synthesizeSpeech(fromString: "I want you find \(prediction.classLabel)")
                    self.findLbl?.text = prediction.classLabel
                    print("predict\(prediction.classLabel)")
                    
//                    DispatchQueue.global().asyncAfter(wallDeadline: .now(), execute: {
                        
                    self.presentDetail(predict: prediction.classLabel, score: self.score ?? 0)
                    
                        
//                    })
                    
                }
                
            
            }
                if count != nil{
                    
                    countLabel?.text =  "\(count!)"

                }else{
                    debugPrint("Error")
                }
            
            
            
            

        }
    
    }
    
    func presentDetail(predict:String,score:Int) {
        
        guard let cameraVC = storyboard?.instantiateViewController(withIdentifier: "CameraVC") as? CameraVC else { return }
        cameraVC.inputPridiction = predict
        cameraVC.score = score
        
        
        if timerDynamic != nil {
            let timer = timerIncrease(timer:second)
            
            cameraVC.timerDynamic  = timer

        
        }else{
        
            cameraVC.timerDynamic = 20
        
        }
   
        present(cameraVC, animated:true, completion: nil)
        
    }
    
    func timerIncrease(timer:Int)->Int
    {
    
        let timeCount = timerDynamic!+timer
        return timeCount
    }
    
    
    
    
    
  
    
    func getPredict(handler:@escaping(_ prediction:UIImage)->())
    {
//        let collectionReference = db.collection("categories").addSnapshotListener({ (documentSnapshot, error) in

        let collectionReference = db.collection("categories")
        
        listener = collectionReference.addSnapshotListener({ (documentSnapshot, error) in
            
            var arr = [Data]()
            
            guard let document = documentSnapshot?.documents else {
                print("Error fetching document: \(error!)")
                return
            }
            
            for document in document{
                
                let data = document.data()
                
                    guard let urlString = data["imageUrl"] as? String else { return }
                    let url = URL(string: urlString)

                    if let convertData = try? Data.init(contentsOf: url!){
                        
                        arr.append(convertData)
                    }
            }
            
            let randomIndex = Int(arc4random_uniform(UInt32(arr.count)))
            print("random\(randomIndex)")
            let image = UIImage(data: arr[randomIndex])
            handler(image!)
        })
        
        
    
    }
  
    
    

    }





    
    
    func synthesizeSpeech(fromString string: String) {
//        let speechUtterance = AVSpeechUtterance(string: string)
        
    }
    
    @available(iOS 11.0, *)

   
    func processClassifications(for request: VNRequest, error: Error?){
        
        DispatchQueue.main.async {
            
            guard let results =  request.results as? [VNClassificationObservation] else {
                fatalError("can't load Places ML model")

            }
            
            for classification in results {
                let identification = classification.identifier
                
                print("your result \(identification)")
                
            }
        }
        
    }
    

    
    
    
    
    

    

@available(iOS 11.0, *)
extension CountVC{
  
    func pixelBufferFromImage(image: UIImage) -> CVPixelBuffer {
        
        let ciimage = CIImage(image: image)
        //let cgimage = convertCIImageToCGImage(inputImage: ciimage!)
        let tmpcontext = CIContext(options: nil)
        let cgimage =  tmpcontext.createCGImage(ciimage!, from: ciimage!.extent)
        let cfnumPointer = UnsafeMutablePointer<UnsafeRawPointer>.allocate(capacity: 1)
        let cfnum = CFNumberCreate(kCFAllocatorDefault, .intType, cfnumPointer)
        let keys: [CFString] = [kCVPixelBufferCGImageCompatibilityKey, kCVPixelBufferCGBitmapContextCompatibilityKey, kCVPixelBufferBytesPerRowAlignmentKey]
        let values: [CFTypeRef] = [kCFBooleanTrue, kCFBooleanTrue, cfnum!]
        let keysPointer = UnsafeMutablePointer<UnsafeRawPointer?>.allocate(capacity: 1)
        let valuesPointer =  UnsafeMutablePointer<UnsafeRawPointer?>.allocate(capacity: 1)
        keysPointer.initialize(to: keys)
        valuesPointer.initialize(to: values)
        let options = CFDictionaryCreate(kCFAllocatorDefault, keysPointer, valuesPointer, keys.count, nil, nil)
        let width = cgimage!.width
        let height = cgimage!.height
        var pxbuffer: CVPixelBuffer?
        // if pxbuffer = nil, you will get status = -6661
        var status = CVPixelBufferCreate(kCFAllocatorDefault, width, height,
                                         kCVPixelFormatType_32BGRA, options, &pxbuffer)
        status = CVPixelBufferLockBaseAddress(pxbuffer!, CVPixelBufferLockFlags(rawValue: 0));
        let bufferAddress = CVPixelBufferGetBaseAddress(pxbuffer!);
        
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB();
        let bytesperrow = CVPixelBufferGetBytesPerRow(pxbuffer!)
        let context = CGContext(data: bufferAddress,
                                width: width,
                                height: height,
                                bitsPerComponent: 8,
                                bytesPerRow: bytesperrow,
                                space: rgbColorSpace,
                                bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue);
        context?.concatenate(CGAffineTransform(rotationAngle: 0))
        context?.concatenate(__CGAffineTransformMake( 1, 0, 0, -1, 0, CGFloat(height) )) //Flip Vertical
        //        context?.concatenate(__CGAffineTransformMake( -1.0, 0.0, 0.0, 1.0, CGFloat(width), 0.0)) //Flip Horizontal
        
        context?.draw(cgimage!, in: CGRect(x:0, y:0, width:CGFloat(width), height:CGFloat(height)));
        status = CVPixelBufferUnlockBaseAddress(pxbuffer!, CVPixelBufferLockFlags(rawValue: 0));
        return pxbuffer!;
    
    }
    
}
extension CountVC:AVSpeechSynthesizerDelegate{
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        
        
    }

    
}
