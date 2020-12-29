
protocol OCRViewControllerDelegate {
    func OCRCodeScanner(str:String)
}
import UIKit
// [START import_vision]
import FirebaseMLVision
// [END import_vision]

import FirebaseMLVisionObjectDetection
import FirebaseMLVisionAutoML
import FirebaseMLCommon

/// Main view controller class.
@objc(OCRViewController)
class OCRViewController:  UIViewController, UINavigationControllerDelegate {
    /// Firebase vision instance.
    // [START init_vision]
    lazy var vision = Vision.vision()
    // [END init_vision]
    var delegate:OCRViewControllerDelegate?
    /// Manager for local and remote models.
    lazy var modelManager = ModelManager.modelManager()
    // var imagess:UIImage?
    /// Whether the AutoML models are registered.
    var areAutoMLModelsRegistered = false
    
    /// A string holding current results from detection.
    var resultsText = ""
    
    /// An overlay view that displays detection annotations.
    private lazy var annotationOverlayView: UIView = {
        precondition(isViewLoaded)
        let annotationOverlayView = UIView(frame: .zero)
        annotationOverlayView.translatesAutoresizingMaskIntoConstraints = false
        return annotationOverlayView
    }()
    
    /// An image picker for accessing the photo library or camera.
    var imagePicker = UIImagePickerController()
    
    // Image counter.
    var currentImage = 0
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet fileprivate weak var detectorPicker: UIPickerView!
    @IBOutlet fileprivate weak var imageView: UIImageView!
    @IBOutlet fileprivate weak var photoCameraButton: UIBarButtonItem!
    @IBOutlet fileprivate weak var videoCameraButton: UIBarButtonItem!
    @IBOutlet weak var detectButton: UIBarButtonItem!
    @IBOutlet var downloadProgressView: UIProgressView!
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.indicator.isHidden = true
        imageView.image = UIImage(named: Constants.images[currentImage])
        imageView.addSubview(annotationOverlayView)
        NSLayoutConstraint.activate([
            annotationOverlayView.topAnchor.constraint(equalTo: imageView.topAnchor),
            annotationOverlayView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            annotationOverlayView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            annotationOverlayView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            ])
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        
        // detectorPicker.delegate = self
        // detectorPicker.dataSource = self
        
        let isCameraAvailable = UIImagePickerController.isCameraDeviceAvailable(.front) ||
            UIImagePickerController.isCameraDeviceAvailable(.rear)
        //        if isCameraAvailable {
        //
        //                 photoCameraButton.isEnabled = false
        //
        //        } else {
        //              photoCameraButton.isEnabled = true
        //        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func backbtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - IBActions
    
    @IBAction func detect(_ sender: Any) {
        
        clearResults()
        detectDocumentTextInCloud(image: imageView.image)
        
    }
    
    @IBAction func openPhotoLibrary(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
    
    @IBAction func openCamera(_ sender: Any) {
        guard UIImagePickerController.isCameraDeviceAvailable(.front) ||
            UIImagePickerController.isCameraDeviceAvailable(.rear)
            else {
                return
        }
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true)
    }
    
    @IBAction func changeImage(_ sender: Any) {
        clearResults()
        currentImage = (currentImage + 1) % Constants.images.count
        imageView.image = UIImage(named: Constants.images[currentImage])
    }
    
    // MARK: - Private
    
    /// Removes the detection annotations from the annotation overlay view.
    private func removeDetectionAnnotations() {
        for annotationView in annotationOverlayView.subviews {
            annotationView.removeFromSuperview()
        }
    }
    
    /// Clears the results text view and removes any frames that are visible.
    private func clearResults() {
        removeDetectionAnnotations()
        self.resultsText = ""
    }
    
    private func showResults() {
        let resultsAlertController = UIAlertController(
            title: "Detection Results",
            message: nil,
            preferredStyle: .actionSheet   )
        resultsAlertController.addAction(
            UIAlertAction(title: "OK", style: .destructive) { _ in
                resultsAlertController.dismiss(animated: true, completion: nil)
                self.delegate?.OCRCodeScanner(str: self.resultsText)
                self.navigationController?.popViewController(animated: true)
            }
        )
        resultsAlertController.message = resultsText
        resultsAlertController.popoverPresentationController?.barButtonItem = detectButton
        resultsAlertController.popoverPresentationController?.sourceView = self.view
        present(resultsAlertController, animated: true, completion: nil)
        
    }
    
    /// Updates the image view with a scaled version of the given image.
    private func updateImageView(with image: UIImage) {
        let orientation = UIApplication.shared.statusBarOrientation
        var scaledImageWidth: CGFloat = 0.0
        var scaledImageHeight: CGFloat = 0.0
        switch orientation {
        case .portrait, .portraitUpsideDown, .unknown:
            scaledImageWidth = imageView.bounds.size.width
            scaledImageHeight = image.size.height * scaledImageWidth / image.size.width
        case .landscapeLeft, .landscapeRight:
            scaledImageWidth = image.size.width * scaledImageHeight / image.size.height
            scaledImageHeight = imageView.bounds.size.height
        }
        DispatchQueue.global(qos: .userInitiated).async {
            // Scale image while maintaining aspect ratio so it displays better in the UIImageView.
            var scaledImage = image.scaledImage(
                with: CGSize(width: scaledImageWidth, height: scaledImageHeight)
            )
            scaledImage = scaledImage ?? image
            guard let finalImage = scaledImage else { return }
            DispatchQueue.main.async {
                self.imageView.image = finalImage
            }
        }
    }
    
    private func transformMatrix() -> CGAffineTransform {
        guard let image = imageView.image else { return CGAffineTransform() }
        let imageViewWidth = imageView.frame.size.width
        let imageViewHeight = imageView.frame.size.height
        let imageWidth = image.size.width
        let imageHeight = image.size.height
        
        let imageViewAspectRatio = imageViewWidth / imageViewHeight
        let imageAspectRatio = imageWidth / imageHeight
        let scale = (imageViewAspectRatio > imageAspectRatio) ?
            imageViewHeight / imageHeight :
            imageViewWidth / imageWidth
        
        // Image view's `contentMode` is `scaleAspectFit`, which scales the image to fit the size of the
        // image view by maintaining the aspect ratio. Multiple by `scale` to get image's original size.
        let scaledImageWidth = imageWidth * scale
        let scaledImageHeight = imageHeight * scale
        let xValue = (imageViewWidth - scaledImageWidth) / CGFloat(2.0)
        let yValue = (imageViewHeight - scaledImageHeight) / CGFloat(2.0)
        
        var transform = CGAffineTransform.identity.translatedBy(x: xValue, y: yValue)
        transform = transform.scaledBy(x: scale, y: scale)
        return transform
    }
    
    private func pointFrom(_ visionPoint: VisionPoint) -> CGPoint {
        return CGPoint(x: CGFloat(visionPoint.x.floatValue), y: CGFloat(visionPoint.y.floatValue))
    }
    
    
    
    private func process(_ visionImage: VisionImage, with textRecognizer: VisionTextRecognizer?) {
        textRecognizer?.process(visionImage) { text, error in
            guard error == nil, let text = text else {
                let errorString = error?.localizedDescription ?? Constants.detectionNoResultsMessage
                self.resultsText = "Text recognizer failed with error: \(errorString)"
                self.showResults()
                return
            }
            // Blocks.
            for block in text.blocks {
                let transformedRect = block.frame.applying(self.transformMatrix())
                UIUtilities.addRectangle(
                    transformedRect,
                    to: self.annotationOverlayView,
                    color: UIColor.purple
                )
                
                // Lines.
                for line in block.lines {
                    let transformedRect = line.frame.applying(self.transformMatrix())
                    UIUtilities.addRectangle(
                        transformedRect,
                        to: self.annotationOverlayView,
                        color: UIColor.orange
                    )
                    
                    // Elements.
                    for element in line.elements {
                        let transformedRect = element.frame.applying(self.transformMatrix())
                        UIUtilities.addRectangle(
                            transformedRect,
                            to: self.annotationOverlayView,
                            color: UIColor.green
                        )
                        let label = UILabel(frame: transformedRect)
                        label.text = element.text
                        label.adjustsFontSizeToFitWidth = true
                        self.annotationOverlayView.addSubview(label)
                    }
                }
            }
            self.resultsText += "\(text.text)\n"
            self.showResults()
        }
    }
    
    private func process(
        _ visionImage: VisionImage,
        with documentTextRecognizer: VisionDocumentTextRecognizer?
        ) {
        documentTextRecognizer?.process(visionImage) { text, error in
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
            guard error == nil, let text = text else {
                let errorString = error?.localizedDescription ?? Constants.detectionNoResultsMessage
                //self.resultsText = "----- text detection-----\n\nDocument text recognizer failed with error: \(errorString)\n"
                self.showResults()
                // self.detectCloudLabels(image: self.imageView.image)
                return
            }
            // Blocks.
            for block in text.blocks {
                let transformedRect = block.frame.applying(self.transformMatrix())
                UIUtilities.addRectangle(
                    transformedRect,
                    to: self.annotationOverlayView,
                    color: UIColor.purple
                )
                
                // Paragraphs.
                for paragraph in block.paragraphs {
                    let transformedRect = paragraph.frame.applying(self.transformMatrix())
                    UIUtilities.addRectangle(
                        transformedRect,
                        to: self.annotationOverlayView,
                        color: UIColor.orange
                    )
                    
                    // Words.
                    for word in paragraph.words {
                        let transformedRect = word.frame.applying(self.transformMatrix())
                        UIUtilities.addRectangle(
                            transformedRect,
                            to: self.annotationOverlayView,
                            color: UIColor.green
                        )
                        
                        // Symbols.
                        for symbol in word.symbols {
                            let transformedRect = symbol.frame.applying(self.transformMatrix())
                            UIUtilities.addRectangle(
                                transformedRect,
                                to: self.annotationOverlayView,
                                color: UIColor.cyan
                            )
                            let label = UILabel(frame: transformedRect)
                            label.text = symbol.text
                            label.adjustsFontSizeToFitWidth = true
                            self.annotationOverlayView.addSubview(label)
                        }
                    }
                }
            }
            self.resultsText += "\(text.text)\n"
            // self.detectCloudLabels(image: self.imageView.image)
            // self.delegate?.OCRCodeScanner(str: self.resultsText)
            self.showResults()
        }
    }
    
    private func registerAutoMLModelsIfNeeded() {
        if areAutoMLModelsRegistered {
            return
        }
        
        let initialConditions = ModelDownloadConditions()
        let updateConditions = ModelDownloadConditions(
            allowsCellularAccess: false,
            allowsBackgroundDownloading: true
        )
//        let remoteModel = RemoteModel(
//            name: Constants.remoteAutoMLModelName,
//            allowsModelUpdates: true,
//            initialConditions: initialConditions,
//            updateConditions: updateConditions
//        )
        //modelManager.register(remoteModel)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(remoteModelDownloadDidSucceed(_:)),
            name: .firebaseMLModelDownloadDidSucceed,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(remoteModelDownloadDidFail(_:)),
            name: .firebaseMLModelDownloadDidFail,
            object: nil
        )
        downloadProgressView.isHidden = false
        //downloadProgressView.observedProgress = modelManager.download(remoteModel)
        
//        guard let localModelFilePath = Bundle.main.path(
//            forResource: Constants.localModelManifestFileName,
//            ofType: Constants.autoMLManifestFileType
//            ) else {
//                print("Failed to find AutoML local model manifest file.")
//                return
//        }
//        let localModel = LocalModel(name: Constants.localAutoMLModelName, path: localModelFilePath)
//        modelManager.register(localModel)
        areAutoMLModelsRegistered = true
    }
    
    // MARK: - Notifications
    
    @objc
    private func remoteModelDownloadDidSucceed(_ notification: Notification) {
        let notificationHandler = {
            self.downloadProgressView.isHidden = true
            guard let userInfo = notification.userInfo,
                let remoteModel =
                userInfo[ModelDownloadUserInfoKey.remoteModel.rawValue] as? RemoteModel
                else {
                    self.resultsText += "firebaseMLModelDownloadDidSucceed notification posted without a RemoteModel instance."
                    return
            }
            self.resultsText += "Successfully downloaded the remote model with name: \(remoteModel.name). The model is ready for detection."
        }
        if Thread.isMainThread { notificationHandler(); return }
        DispatchQueue.main.async { notificationHandler() }
    }
    
    @objc
    private func remoteModelDownloadDidFail(_ notification: Notification) {
        let notificationHandler = {
            self.downloadProgressView.isHidden = true
            guard let userInfo = notification.userInfo,
                let remoteModel =
                userInfo[ModelDownloadUserInfoKey.remoteModel.rawValue] as? RemoteModel,
                let error = userInfo[ModelDownloadUserInfoKey.error.rawValue] as? NSError
                else {
                    self.resultsText += "firebaseMLModelDownloadDidFail notification posted without a RemoteModel instance or error."
                    return
            }
            self.resultsText += "Failed to download the remote model with name: \(remoteModel.name), error: \(error)."
        }
        if Thread.isMainThread { notificationHandler(); return }
        DispatchQueue.main.async { notificationHandler() }
    }
}


extension OCRViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        clearResults()
        //        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
        //
        //        }
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
            
        }
        updateImageView(with: selectedImage)
        dismiss(animated: true)
    }
}

extension OCRViewController {
    
    func detectBarcodes(image: UIImage?) {
        guard let image = image else { return }
        
        // Define the options for a barcode detector.
        // [START config_barcode]
        let format = VisionBarcodeFormat.all
        let barcodeOptions = VisionBarcodeDetectorOptions(formats: format)
        
        // [END config_barcode]
        
        // Create a barcode detector.
        // [START init_barcode]
        let barcodeDetector = vision.barcodeDetector(options: barcodeOptions)
        // [END init_barcode]
        
        // Define the metadata for the image.
        let imageMetadata = VisionImageMetadata()
        imageMetadata.orientation = UIUtilities.visionImageOrientation(from: image.imageOrientation)
        
        // Initialize a VisionImage object with the given UIImage.
        let visionImage = VisionImage(image: image)
        visionImage.metadata = imageMetadata
        
        // [START detect_barcodes]
        barcodeDetector.detect(in: visionImage) { features, error in
            guard error == nil, let features = features, !features.isEmpty else {
                // [START_EXCLUDE]
                let errorString = error?.localizedDescription ?? Constants.detectionNoResultsMessage
                self.resultsText = "On-Device barcode detection failed with error: \(errorString)"
                self.showResults()
                // [END_EXCLUDE]
                return
            }
            
            // [START_EXCLUDE]
            features.forEach { feature in
                let transformedRect = feature.frame.applying(self.transformMatrix())
                UIUtilities.addRectangle(
                    transformedRect,
                    to: self.annotationOverlayView,
                    color: UIColor.green
                )
            }
            self.resultsText = features.map { feature in
                return "DisplayValue: \(feature.displayValue ?? ""), RawValue: " +
                "\(feature.rawValue ?? ""), Frame: \(feature.frame)"
                }.joined(separator: "\n")
            self.showResults()
            // [END_EXCLUDE]
        }
        // [END detect_barcodes]
    }
    
    /// Detects labels on the specified image using On-Device label API.
    ///
    /// - Parameter image: The image.
    func detectLabels(image: UIImage?) {
        guard let image = image else { return }
        
        // [START config_label]
        let options = VisionOnDeviceImageLabelerOptions()
        options.confidenceThreshold = Constants.labelConfidenceThreshold
        // [END config_label]
        
        // [START init_label]
        let onDeviceLabeler = vision.onDeviceImageLabeler(options: options)
        // [END init_label]
        
        // Define the metadata for the image.
        let imageMetadata = VisionImageMetadata()
        imageMetadata.orientation = UIUtilities.visionImageOrientation(from: image.imageOrientation)
        
        // Initialize a VisionImage object with the given UIImage.
        let visionImage = VisionImage(image: image)
        visionImage.metadata = imageMetadata
        
        // [START detect_label]
        onDeviceLabeler.process(visionImage) { labels, error in
            guard error == nil, let labels = labels, !labels.isEmpty else {
                // [START_EXCLUDE]
                let errorString = error?.localizedDescription ?? Constants.detectionNoResultsMessage
                self.resultsText = "On-Device label detection failed with error: \(errorString)"
                self.showResults()
                // [END_EXCLUDE]
                return
            }
            
            // [START_EXCLUDE]
            self.resultsText = labels.map { label -> String in
                return "Label: \(label.text), "
                //          "Confidence: \(label.confidence ?? 0), " +
                //          "EntityID: \(label.entityID ?? "")"
                }.joined(separator: "\n")
            self.showResults()
            // [END_EXCLUDE]
        }
        // [END detect_label]
    }
    
    /// Detects labels on the specified image using On-Device AutoML Image Labeling API.
    ///
    /// - Parameter image: The image.
//    func detectImageLabelsAutoML(image: UIImage?) {
//        guard let image = image else { return }
//        registerAutoMLModelsIfNeeded()
//        
//        // [START config_automl_label]
////        let options = VisionOnDeviceAutoMLImageLabelerOptions(
////            remoteModelName: Constants.remoteAutoMLModelName,
////            localModelName: Constants.localAutoMLModelName
////        )
////        options.confidenceThreshold = Constants.labelConfidenceThreshold
////        // [END config_automl_label]
////
////        // [START init_automl_label]
////        let autoMLOnDeviceLabeler = vision.onDeviceAutoMLImageLabeler(options: options)
////        // [END init_automl_label]
//        
//        // Define the metadata for the image.
//        let imageMetadata = VisionImageMetadata()
//        imageMetadata.orientation = UIUtilities.visionImageOrientation(from: image.imageOrientation)
//        
//        // Initialize a VisionImage object with the given UIImage.
//        let visionImage = VisionImage(image: image)
//        visionImage.metadata = imageMetadata
//        
//        // [START detect_automl_label]
//        autoMLOnDeviceLabeler.process(visionImage) { labels, error in
//            guard error == nil, let labels = labels, !labels.isEmpty else {
//                // [START_EXCLUDE]
//                let errorString = error?.localizedDescription ?? Constants.detectionNoResultsMessage
//                self.resultsText = "On-Device AutoML label detection failed with error: \(errorString)"
//                self.showResults()
//                // [END_EXCLUDE]
//                return
//            }
//            
//            // [START_EXCLUDE]
//            self.resultsText = labels.map { label -> String in
//                return " \(label.text)"
//                //        , Confidence: \(label.confidence ?? 0)"
//                }.joined(separator: "\n")
//            self.showResults()
//            // [END_EXCLUDE]
//        }
//        // [END detect_automl_label]
//    }
    /// - Parameter image: The image.
    func detectTextOnDevice(with image: UIImage) {
        let textRecognizer = vision.onDeviceTextRecognizer()
        let visionImage = VisionImage(image: image)
        textRecognizer.process(visionImage) { features, error in
            self.processResult(from: features, error: error)
            print(features!)
        }
    }
    
    func processResult(from text: VisionText?, error: Error?) {
        removeDetectionAnnotations()
        guard error == nil, let text = text else {
            let errorString = error?.localizedDescription ?? Constants.detectionNoResultsMessage
            print("Text recognizer failed with error: \(errorString)")
            return
        }
        
        // let transform = self.transformMatrix()
        
        // Blocks.
        for block in text.blocks {
            let transformedRect = block.frame.applying(self.transformMatrix())
            UIUtilities.addRectangle(
                transformedRect,
                to: self.annotationOverlayView,
                color: UIColor.purple
            )
            
            // Lines.
            for line in block.lines {
                let transformedRect = line.frame.applying(self.transformMatrix())
                UIUtilities.addRectangle(
                    transformedRect,
                    to: self.annotationOverlayView,
                    color: UIColor.orange
                )
                
                // Elements.
                for element in line.elements {
                    let transformedRect = element.frame.applying(self.transformMatrix())
                    UIUtilities.addRectangle(
                        transformedRect,
                        to: self.annotationOverlayView,
                        color: UIColor.green
                    )
                    let label = UILabel(frame: transformedRect)
                    label.text = element.text
                    label.adjustsFontSizeToFitWidth = true
                    self.annotationOverlayView.addSubview(label)
                }
            }
            self.resultsText += "\(text.text)\n"
            self.showResults()
        }
    }
    /// - Parameter image: The image.
    func detectTextInCloud(image: UIImage?, options: VisionCloudTextRecognizerOptions? = nil) {
        guard let image = image else { return }
        
        // Define the metadata for the image.
        let imageMetadata = VisionImageMetadata()
        imageMetadata.orientation = UIUtilities.visionImageOrientation(from: image.imageOrientation)
        
        // Initialize a VisionImage object with the given UIImage.
        let visionImage = VisionImage(image: image)
        visionImage.metadata = imageMetadata
        
        // [START init_text_cloud]
        var cloudTextRecognizer: VisionTextRecognizer?
        var modelTypeString = Constants.sparseTextModelName
        if let options = options {
            modelTypeString = (options.modelType == .dense) ?
                Constants.denseTextModelName :
            modelTypeString
            cloudTextRecognizer = vision.cloudTextRecognizer(options: options)
        } else {
            cloudTextRecognizer = vision.cloudTextRecognizer()
        }
        // [END init_text_cloud]
        
        self.resultsText += " (\(modelTypeString) model)...\n"
        process(visionImage, with: cloudTextRecognizer)
    }
    func detectDocumentTextInCloud(image: UIImage?) {
        guard let image = image else { return }
        indicator.isHidden = false
        indicator.startAnimating()
        // Define the metadata for the image.
        let imageMetadata = VisionImageMetadata()
        imageMetadata.orientation = UIUtilities.visionImageOrientation(from: image.imageOrientation)
        
        // Initialize a VisionImage object with the given UIImage.
        let visionImage = VisionImage(image: image)
        visionImage.metadata = imageMetadata
        
        // [START init_document_text_cloud]
        let cloudDocumentTextRecognizer = vision.cloudDocumentTextRecognizer()
        // [END init_document_text_cloud]
        
        //  self.resultsText += "----- text detection-----\n\n"
        process(visionImage, with: cloudDocumentTextRecognizer)
    }
    
    /// Detects landmarks on the specified image and draws a frame around the detected landmarks using
    /// cloud landmark API.
    ///
    /// - Parameter image: The image.
    func detectCloudLandmarks(image: UIImage?) {
        guard let image = image else { return }
        
        // Define the metadata for the image.
        let imageMetadata = VisionImageMetadata()
        imageMetadata.orientation = UIUtilities.visionImageOrientation(from: image.imageOrientation)
        
        // Initialize a VisionImage object with the given UIImage.
        let visionImage = VisionImage(image: image)
        visionImage.metadata = imageMetadata
        
        // Create a landmark detector.
        // [START config_landmark_cloud]
        let options = VisionCloudDetectorOptions()
        options.modelType = .latest
        options.maxResults = 20
        // [END config_landmark_cloud]
        
        // [START init_landmark_cloud]
        let cloudDetector = vision.cloudLandmarkDetector(options: options)
        // Or, to use the default settings:
        // let cloudDetector = vision.cloudLandmarkDetector()
        // [END init_landmark_cloud]
        
        // [START detect_landmarks_cloud]
        cloudDetector.detect(in: visionImage) { landmarks, error in
            guard error == nil, let landmarks = landmarks, !landmarks.isEmpty else {
                // [START_EXCLUDE]
                let errorString = error?.localizedDescription ?? Constants.detectionNoResultsMessage
                self.resultsText = "Cloud landmark detection failed with error: \(errorString)"
                self.showResults()
                // [END_EXCLUDE]
                return
            }
            
            // Recognized landmarks
            // [START_EXCLUDE]
            landmarks.forEach { landmark in
                let transformedRect = landmark.frame.applying(self.transformMatrix())
                UIUtilities.addRectangle(
                    transformedRect,
                    to: self.annotationOverlayView,
                    color: UIColor.green
                )
            }
            self.resultsText = landmarks.map { landmark -> String in
                return "Landmark: \(String(describing: landmark.landmark ?? "")), " +
                    "Confidence: \(String(describing: landmark.confidence ?? 0) ), " +
                    "EntityID: \(String(describing: landmark.entityId ?? "") ), " +
                "Frame: \(landmark.frame)"
                }.joined(separator: "\n")
            self.showResults()
            // [END_EXCLUDE]
        }
        // [END detect_landmarks_cloud]
    }
    
    /// Detects labels on the specified image using cloud label API.
    ///
    /// - Parameter image: The image.
    func detectCloudLabels(image: UIImage?) {
        let texts = self.resultsText
        indicator.isHidden = false
        indicator.startAnimating()
        guard let image = image else { return }
        
        // [START init_label_cloud]
        let cloudLabeler = vision.cloudImageLabeler()
        // Or, to change the default settings:
        // let cloudLabeler = vision.cloudImageLabeler(options: options)
        // [END init_label_cloud]
        
        // Define the metadata for the image.
        let imageMetadata = VisionImageMetadata()
        imageMetadata.orientation = UIUtilities.visionImageOrientation(from: image.imageOrientation)
        
        // Initialize a VisionImage object with the given UIImage.
        let visionImage = VisionImage(image: image)
        visionImage.metadata = imageMetadata
        
        // [START detect_label_cloud]
        cloudLabeler.process(visionImage) { labels, error in
            self.indicator.stopAnimating()
            self.indicator.isHidden = true
            guard error == nil, let labels = labels, !labels.isEmpty else {
                // [START_EXCLUDE]
                let errorString = error?.localizedDescription ?? Constants.detectionNoResultsMessage
                self.resultsText = "Cloud label detection failed with error: \(errorString)"
                
                //self.showResults()
                // [END_EXCLUDE]
                return
            }
            
            // Labeled image
            // START_EXCLUDE
            self.resultsText = labels.map { label -> String in
                " \(label.text) "
                //            +
                //        "Confidence: \(label.confidence ?? 0), " +
                //        "EntityID: \(label.entityID ?? "")"
                }.joined(separator: "\n")
            
            self.resultsText =  texts +  "----object detection---\n\n" + self.resultsText
            self.showResults()
            // [END_EXCLUDE]
        }
        // [END detect_label_cloud]
    }
    
    
    /// Detects objects on the specified image and draws a frame around them.
    ///
    /// - Parameter image: The image.
    /// - Parameter options: The options for object detector.
    private func detectObjectsOnDevice(in image: UIImage?, options: VisionObjectDetectorOptions) {
        guard let image = image else { return }
        
        // Define the metadata for the image.
        let imageMetadata = VisionImageMetadata()
        imageMetadata.orientation = UIUtilities.visionImageOrientation(from: image.imageOrientation)
        
        // Initialize a VisionImage object with the given UIImage.
        let visionImage = VisionImage(image: image)
        visionImage.metadata = imageMetadata
        
        // [START init_object_detector]
        // Create an objects detector with options.
        let detector = vision.objectDetector(options: options)
        // [END init_object_detector]
        
        // [START detect_object]
        detector.process(visionImage) { objects, error in
            guard error == nil else {
                // [START_EXCLUDE]
                let errorString = error?.localizedDescription ?? Constants.detectionNoResultsMessage
                self.resultsText = "Object detection failed with error: \(errorString)"
                self.showResults()
                // [END_EXCLUDE]
                return
            }
            guard let objects = objects, !objects.isEmpty else {
                // [START_EXCLUDE]
                self.resultsText = "On-Device object detector returned no results."
                self.showResults()
                // [END_EXCLUDE]
                return
            }
            
            objects.forEach { object in
                // [START_EXCLUDE]
                let transform = self.transformMatrix()
                let transformedRect = object.frame.applying(transform)
                UIUtilities.addRectangle(
                    transformedRect,
                    to: self.annotationOverlayView,
                    color: .green
                )
                // [END_EXCLUDE]
            }
            
            // [START_EXCLUDE]
//            self.resultsText = objects.map { object in
//                return "Class: \(object.label ?? ""), frame: \(object.frame), ID: \(object.trackingID ?? 0)"
//                }.joined(separator: "\n")
            self.showResults()
            // [END_EXCLUDE]
        }
        // [END detect_object]
    }
}


private enum Constants {
    static let images = ["grace_hopper.jpg","beach.jpg",
                         "image_has_text.jpg", "liberty.jpg"]
    static let modelExtension = "tflite"
    static let localModelName = "mobilenet"
    static let quantizedModelFilename = "mobilenet_quant_v1_224"
    
    static let detectionNoResultsMessage = "No results returned."
    static let failedToDetectObjectsMessage = "Failed to detect objects in image."
    static let sparseTextModelName = "Sparse"
    static let denseTextModelName = "Dense"
    
    static let localAutoMLModelName = "local_automl_model"
    static let remoteAutoMLModelName = "remote_automl_model"
    static let localModelManifestFileName = "automl_labeler_manifest"
    static let autoMLManifestFileType = "json"
    
    static let labelConfidenceThreshold: Float = 0.75
    static let smallDotRadius: CGFloat = 5.0
    static let largeDotRadius: CGFloat = 10.0
    static let lineColor = UIColor.yellow.cgColor
    static let fillColor = UIColor.clear.cgColor
}
