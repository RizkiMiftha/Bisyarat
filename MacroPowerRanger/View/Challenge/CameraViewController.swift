//
//  CameraViewController.swift
//  Bisyarat
//
//  Created by Muhammad Gilang Nursyahroni on 09/11/21.
//

import UIKit
import SwiftUI
import AVFoundation
import Vision

final class CameraViewController: UIViewController {
    
    var vm: ChallengePageViewModel
    
    var videoCapture: VideoCapture
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    var pointsLayer = CAShapeLayer()

    var isRightHandActionDetected = false
    var isLeftHandActionDetected = false
    
    var leftHandActionName = ""
    
    var ActionA = 0
    
    init(vm: ChallengePageViewModel) {
        self.vm = vm
        videoCapture = VideoCapture(vm: vm)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVideoPreview()
        
        videoCapture.predictor.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        videoCapture.stopCaptureSession()
    }
    
    private func setupVideoPreview() {
        videoCapture.startCaptureSession()
        previewLayer = AVCaptureVideoPreviewLayer(session: videoCapture.captureSession)
        
        guard let previewLayer = previewLayer else {
            return
        }
        

        //previewLayer.frame = view.frame
        previewLayer.frame = UIScreen.main.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        
        //view.layer.addSublayer(pointsLayer)
        pointsLayer.frame = view.frame
        pointsLayer.strokeColor = UIColor.green.cgColor
    }
    
}

extension CameraViewController: PredictorDelegate {
    
    func rightHandPredictor(_ predictor: Predictor, didLabelAction action: String, with confidence: Double) {
        if vm.shouldStartClassifying == false {
            return
        } else {
            if action == "A" && confidence > 0.95 && isRightHandActionDetected == false {
                print("Kanan: ", action)
                isRightHandActionDetected = true
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    if self.vm.materialBeingAsked == "A" {
                        if self.leftHandActionName == "A" {
                            self.vm.isGuessedTrue = true
                        }
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.isRightHandActionDetected = false
                }
            } else if action == "I" && confidence > 0.95 && isRightHandActionDetected == false {
                print("Kanan: ", action)
                isRightHandActionDetected = true
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    if self.vm.materialBeingAsked == "I" {
                        self.vm.isGuessedTrue = true
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.isRightHandActionDetected = false
                }
            } else if action == "J" && confidence > 0.95 && isRightHandActionDetected == false{
                print("Kanan: ", action)
                isRightHandActionDetected = true
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    if self.vm.materialBeingAsked == "J" {
                        self.vm.isGuessedTrue = true
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.isRightHandActionDetected = false
                }
            } else if action == "R" && confidence > 0.95 && isRightHandActionDetected == false {
                print("Kanan: ", action)
                isRightHandActionDetected = true
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    if self.vm.materialBeingAsked == "R" {
                        self.vm.isGuessedTrue = true
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.isRightHandActionDetected = false
                }
            } else if action == "F Kanan" && confidence > 0.95 && isRightHandActionDetected == false {
                print("Kanan: ", action)
                isRightHandActionDetected = true
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    if self.vm.materialBeingAsked == "F" {
                        if self.leftHandActionName == "Telunjuk" {
                            self.vm.isGuessedTrue = true
                        }
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.isRightHandActionDetected = false
                }
            } else if action == "E : B Kanan" && confidence > 0.95 && isRightHandActionDetected == false {
                print("Kanan: ", action)
                isRightHandActionDetected = true
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    if self.vm.materialBeingAsked == "E" {
                        self.vm.isGuessedTrue = true
                    } else if self.vm.materialBeingAsked == "B" {
                        if self.leftHandActionName == "Telunjuk" {
                            self.vm.isGuessedTrue = true
                        }
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.isRightHandActionDetected = false
                }
            } else if action == "C : D kanan" && confidence > 0.95 && isRightHandActionDetected == false {
                print("Kanan: ", action)
                isRightHandActionDetected = true
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    if self.vm.materialBeingAsked == "C" {
                        self.vm.isGuessedTrue = true
                    } else if self.vm.materialBeingAsked == "D" {
                        if self.leftHandActionName == "Telunjuk" {
                            self.vm.isGuessedTrue = true
                        }
                    } else if self.vm.materialBeingAsked == "S" {
                        if self.leftHandActionName == "C : D kanan" {
                            self.vm.isGuessedTrue = true
                        }
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.isRightHandActionDetected = false
                }
            } else if action == "Other" && isRightHandActionDetected == false && confidence > 0.75 {
                //isActionDetected = true
                //showLabel(actionLabel: action)
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    print("other")
                    self.isRightHandActionDetected = false
                }
            }
        }
        
        if action == "A" {
            ActionA += 1
            isRightHandActionDetected = true
            if ActionA > 30 {
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    if self.vm.materialBeingAsked == "C" {
                        self.vm.isGuessedTrue = true
                    } else if self.vm.materialBeingAsked == "D" {
                        if self.leftHandActionName == "Telunjuk" {
                            self.vm.isGuessedTrue = true
                        }
                    } else if self.vm.materialBeingAsked == "S" {
                        if self.leftHandActionName == "C : D kanan" {
                            self.vm.isGuessedTrue = true
                        }
                    }
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.isRightHandActionDetected = false
            }
        } else {
            ActionA = 0
        }
        
        

    }
    
    func leftHandPredictor(_ predictor: Predictor, didLabelAction action: String, with confidence: Double) {
        if vm.shouldStartClassifying == false {
            return
        } else {
            if action == "A" && confidence > 0.95 && isLeftHandActionDetected == false {
                print("Kiri: ", action)
                isLeftHandActionDetected = true
                leftHandActionName = action
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.isLeftHandActionDetected = false
                }
            } else if action == "Telunjuk" && confidence > 0.95 && isLeftHandActionDetected == false {
                print("Kiri: ", action)
                isLeftHandActionDetected = true
                leftHandActionName = action
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.isLeftHandActionDetected = false
                }
            } else if action == "C : D kanan" && confidence > 0.95 && isLeftHandActionDetected == false {
                print("Kiri: ", action)
                isLeftHandActionDetected = true
                leftHandActionName = action
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.isLeftHandActionDetected = false
                }
            } else if action == "Other" && isLeftHandActionDetected == false && confidence > 0.75 {
                //isActionDetected = true
                //showLabel(actionLabel: action)
                leftHandActionName = action
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    print("other")
                    self.isLeftHandActionDetected = false
                }
            } else {
                //leftHandActionName = ""
            }
        }
        
        
//        if isLeftHandActionDetected == true {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                self.isLeftHandActionDetected = false
//            }
//        }
        
    }
  
    func predictor(_ predictor: Predictor, didFindNewRecognizedPoints points: [CGPoint], hand: String) {
        guard let previewLayer = previewLayer else { return }
        
        let convertedPoints = points.map {
            previewLayer.layerPointConverted(fromCaptureDevicePoint: $0)
        }
        let combinedPath = CGMutablePath()
        
        for point in convertedPoints {
            let dotPath = UIBezierPath(ovalIn: CGRect(x: point.x, y: point.y, width: 5, height: 5))
            combinedPath.addPath(dotPath.cgPath)
        }
        
        pointsLayer.path = combinedPath
        
        DispatchQueue.main.async {
            if points.count >= 5 {
                if self.vm.showTutorial == false {
                    self.vm.isHandInFrame = true
                }
            } else {
                self.vm.isHandInFrame = false
            }
            self.pointsLayer.didChangeValue(for: \.path)
            if hand == "left" {
                self.pointsLayer.strokeColor = UIColor.yellow.cgColor
            } else {
                self.pointsLayer.strokeColor = UIColor.green.cgColor
            }
        }
    }
}
    
//    ///
//    private var cameraView: CameraPreview { view as! CameraPreview }
//
//    private let videoDataOutputQueue = DispatchQueue(
//        label: "CameraFeedOutput",
//        qos: .userInteractive
//    )
//    private var cameraFeedSession: AVCaptureSession?
//    private let handPoseRequest: VNDetectHumanHandPoseRequest = {
//        let request = VNDetectHumanHandPoseRequest()
//        request.maximumHandCount = 2
//        return request
//    }()
//
//    var pointsProcessorHandler: (([CGPoint]) -> Void)?
//
//    override func loadView() {
//        view = CameraPreview()
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        do {
//            if cameraFeedSession == nil {
//                try setupAVSession()
//                cameraView.previewLayer.session = cameraFeedSession
//                cameraView.previewLayer.videoGravity = .resizeAspectFill
//            }
//            cameraFeedSession?.startRunning()
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        cameraFeedSession?.stopRunning()
//        super.viewWillDisappear(animated)
//    }
//
//    func setupAVSession() throws {
//        // Select a front facing camera, make an input.
//        guard let videoDevice = AVCaptureDevice.default(
//            .builtInWideAngleCamera,
//            for: .video,
//            position: .front)
//        else {
//            throw AppError.captureSessionSetup(
//                reason: "Could not find a front facing camera."
//            )
//        }
//
//        guard let deviceInput = try? AVCaptureDeviceInput(
//            device: videoDevice
//        ) else {
//            throw AppError.captureSessionSetup(
//                reason: "Could not create video device input."
//            )
//        }
//
//        let session = AVCaptureSession()
//        session.beginConfiguration()
//        session.sessionPreset = AVCaptureSession.Preset.high
//
//        // Add a video input.
//        guard session.canAddInput(deviceInput) else {
//            throw AppError.captureSessionSetup(
//                reason: "Could not add video device input to the session"
//            )
//        }
//        session.addInput(deviceInput)
//
//        let dataOutput = AVCaptureVideoDataOutput()
//        if session.canAddOutput(dataOutput) {
//            session.addOutput(dataOutput)
//            // Add a video data output.
//            dataOutput.alwaysDiscardsLateVideoFrames = true
//            dataOutput.setSampleBufferDelegate(self, queue: videoDataOutputQueue)
//        } else {
//            throw AppError.captureSessionSetup(
//                reason: "Could not add video data output to the session"
//            )
//        }
//        session.commitConfiguration()
//        cameraFeedSession = session
//    }
//}
//
//extension
//CameraViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
//}
