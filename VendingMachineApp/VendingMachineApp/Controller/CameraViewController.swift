//
//  CameraViewController.swift
//  VendingMachineApp
//
//  Created by 채훈기 on 2020/09/23.
//  Copyright © 2020 채훈기. All rights reserved.
//

import UIKit
import AVFoundation
import Vision

class CameraViewController: UIViewController {

    private var requests = [VNRequest]()
    private var detectionOverlay = CALayer()
    private let textLayer = CATextLayer()
    private var shouldTakePicture = false
    private let capturedImageView = CapturedImageView()
    private var windowOrientation: UIInterfaceOrientation {
        return view.window?.windowScene?.interfaceOrientation ?? .unknown
    }

    private var videoOutput : AVCaptureVideoDataOutput!
    private var captureSession : AVCaptureSession!
    private var backCamera : AVCaptureDevice!
    private var frontCamera : AVCaptureDevice!
    private var backInput : AVCaptureInput!
    private var frontInput : AVCaptureInput!
    private var previewLayer : AVCaptureVideoPreviewLayer!
    
    @IBOutlet weak var takePicture: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkPermissions()
        setupVision()
        setupAndStartCaptureSession()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        // Divice의 방향이 변경되었을때 preview와 videoOutout의 방향도 변경해줌
        if let videoPreviewLayerConnection = previewLayer.connection {
            let deviceOrientation = UIDevice.current.orientation
            guard let newVideoOrientation = AVCaptureVideoOrientation(rawValue: deviceOrientation.rawValue),
                deviceOrientation.isPortrait || deviceOrientation.isLandscape else {
                    return
            }
            // preview의 frame도 재설정 해줌
            let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
            previewLayer.frame = rect
            videoPreviewLayerConnection.videoOrientation = newVideoOrientation
            videoOutput.connections.first?.videoOrientation = newVideoOrientation
        }
    }
    
    @IBAction func didPressTakePhoto(_ sender: UIButton) {
        shouldTakePicture = true
    }
    
    @IBAction func cancelTouched(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupUI() {
        view.addSubview(capturedImageView)
        
        takePicture.translatesAutoresizingMaskIntoConstraints = false
        capturedImageView.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            takePicture.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            takePicture.heightAnchor.constraint(equalToConstant: 50),
            takePicture.widthAnchor.constraint(equalToConstant: 50),
            takePicture.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            capturedImageView.heightAnchor.constraint(equalToConstant: 55),
            capturedImageView.widthAnchor.constraint(equalToConstant: 55),
            capturedImageView.topAnchor.constraint(equalTo: takePicture.bottomAnchor, constant: 30),
            capturedImageView.trailingAnchor.constraint(equalTo: takePicture.trailingAnchor),
            
            cancelButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)

        ])
        takePicture.layer.cornerRadius = 25
        capturedImageView.layer.cornerRadius = 10
        
        detectionOverlay.borderWidth = 2
        detectionOverlay.borderColor = UIColor.yellow.cgColor
        detectionOverlay.backgroundColor = UIColor.clear.cgColor
        detectionOverlay.cornerRadius = 10
        
        view.layer.insertSublayer(detectionOverlay, above: previewLayer)
        textLayer.backgroundColor = UIColor.yellow.cgColor
        textLayer.fontSize = 5
        textLayer.cornerRadius = 5
        detectionOverlay.addSublayer(textLayer)
    }
    
    private func setupAndStartCaptureSession(){
        // 세션을 초기화 하고 인풋 아웃풋 설정 한 후 세션을 시작함
        DispatchQueue.global(qos: .userInitiated).async{
            self.captureSession = AVCaptureSession()
            
            self.captureSession.beginConfiguration()
            
            if self.captureSession.canSetSessionPreset(.photo) {
                self.captureSession.sessionPreset = .photo
            }
            self.captureSession.automaticallyConfiguresCaptureDeviceForWideColor = true
            
            // input
            self.setupInputs()
            
            // preview
            DispatchQueue.main.async {
                self.setupPreviewLayer()
            }

            // input
            self.setupOutput()
            
            self.captureSession.commitConfiguration()

            self.captureSession.startRunning()
        }
    }
    
    private func setupVision() -> NSError? {
        // 모델 셋업
        let error: NSError! = nil
        
        guard let modelURL = Bundle.main.url(forResource: "ObjectDetector", withExtension: "mlmodelc") else {
            return NSError(domain: "CameraViewController", code: -1, userInfo: [NSLocalizedDescriptionKey: "Model file is missing"])
        }
        do {
            let visionModel = try VNCoreMLModel(for: MLModel(contentsOf: modelURL))
            let objectRecognition = VNCoreMLRequest(model: visionModel, completionHandler: { (request, error) in
                // 물체를 인식할 때마다 이 핸들러가 불림
                DispatchQueue.main.async(execute: {
                    if let results = request.results {
                        self.drawVisionRequestResults(results)
                    }
                })
            })
            self.requests = [objectRecognition]
        } catch let error as NSError {
            print("Model loading went wrong: \(error)")
        }
        return error
    }
    
    private func drawVisionRequestResults(_ results: [Any]) {

        for observation in results where observation is VNRecognizedObjectObservation {
            guard let objectObservation = observation as? VNRecognizedObjectObservation else {
                continue
            }
            // 일치율이 높은 첫번째 오브젝트를 사용
            let first = objectObservation.labels[0]
            let objectBounds = VNImageRectForNormalizedRect(objectObservation.boundingBox, Int(view.bounds.width), Int(view.bounds.height))

            DispatchQueue.main.async {
                self.detectionOverlay.bounds = objectBounds
                self.detectionOverlay.position = CGPoint(x: objectBounds.midX, y: objectBounds.midY)
                let formattedString = NSMutableAttributedString(string: String(format: "\(first.identifier)\nConfidence:  %.2f", first.confidence))
                self.textLayer.string = formattedString
                self.textLayer.frame = CGRect(x: objectBounds.minX + 2, y: objectBounds.minY + 2, width: objectBounds.width - 2, height: 30)
            }
        }
    }

    private func setupOutput(){
        videoOutput = AVCaptureVideoDataOutput()
        let videoQueue = DispatchQueue(label: "videoQueue", qos: .userInteractive)
        videoOutput.setSampleBufferDelegate(self, queue: videoQueue)

        if captureSession.canAddOutput(videoOutput) {
            captureSession.addOutput(videoOutput)
        } else {
            fatalError("could not add video output")
        }
        videoOutput.connections.first?.videoOrientation = .landscapeRight
    }
    
    private func setupPreviewLayer(){
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(previewLayer)
        view.layer.insertSublayer(previewLayer, below: takePicture.layer)
        previewLayer.frame = self.view.layer.frame
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.connection?.videoOrientation = orientation()
    }
    
    private func orientation() -> AVCaptureVideoOrientation {
        var initialVideoOrientation: AVCaptureVideoOrientation = .portrait
        if self.windowOrientation != .unknown {
            if let videoOrientation = AVCaptureVideoOrientation(rawValue: self.windowOrientation.rawValue) {
                initialVideoOrientation = videoOrientation
            }
        }
        return initialVideoOrientation
    }
    
    private func setupInputs(){
        // 앞 뒤의 카메라를 다 설정하지만 초기값은 뒤의 카메라를 사용
        // 카메라 스위치는 구현 안되어있음.
        //get back camera
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
            backCamera = device
        } else {
            //handle this appropriately for production purposes
            fatalError("no back camera")
        }
        //get front camera
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
            frontCamera = device
        } else {
            fatalError("no front camera")
        }
        
        //now we need to create an input objects from our devices
        guard let bInput = try? AVCaptureDeviceInput(device: backCamera) else {
            fatalError("could not create input device from back camera")
        }
        backInput = bInput
        if !captureSession.canAddInput(backInput) {
            fatalError("could not add back camera input to capture session")
        }
        
        guard let fInput = try? AVCaptureDeviceInput(device: frontCamera) else {
            fatalError("could not create input device from front camera")
        }
        frontInput = fInput
        if !captureSession.canAddInput(frontInput) {
            fatalError("could not add front camera input to capture session")
        }
        
        //connect back camera input to session
        captureSession.addInput(backInput)
    }
    
    private func checkPermissions() {
        let cameraAuthStatus =  AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch cameraAuthStatus {
          case .authorized:
            return
          case .denied:
            abort()
          case .notDetermined:
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler:
            { (authorized) in
              if(!authorized){
                abort()
              }
            })
          case .restricted:
            abort()
          @unknown default:
            fatalError()
        }
    }
}

extension CameraViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        if !shouldTakePicture {
            guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
                return
            }
            
            let exifOrientation = exifOrientationFromDeviceOrientation()
            
            let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: exifOrientation, options: [:])
            do {
                try imageRequestHandler.perform(self.requests)
            } catch {
                print(error)
            }
            return
        }

        //try and get a CVImageBuffer out of the sample buffer
        guard let cvBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }

        //get a CIImage out of the CVImageBuffer
        let ciImage = CIImage(cvImageBuffer: cvBuffer)

        //get UIImage out of CIImage
        let uiImage = UIImage(ciImage: ciImage)
        DispatchQueue.main.async {
            self.capturedImageView.image = uiImage
            self.shouldTakePicture = false
        }
    }
    
    public func exifOrientationFromDeviceOrientation() -> CGImagePropertyOrientation {
        let curDeviceOrientation = UIDevice.current.orientation
        let exifOrientation: CGImagePropertyOrientation
        
        switch curDeviceOrientation {
        case UIDeviceOrientation.portraitUpsideDown:  // Device oriented vertically, home button on the top
            exifOrientation = .left
        case UIDeviceOrientation.landscapeLeft:       // Device oriented horizontally, home button on the right
            exifOrientation = .upMirrored
        case UIDeviceOrientation.landscapeRight:      // Device oriented horizontally, home button on the left
            exifOrientation = .down
        case UIDeviceOrientation.portrait:            // Device oriented vertically, home button on the bottom
            exifOrientation = .up
        default:
            exifOrientation = .up
        }
        return exifOrientation
    }
}
