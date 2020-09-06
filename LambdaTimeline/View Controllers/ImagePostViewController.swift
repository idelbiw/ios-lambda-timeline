//
//  ImagePostViewController.swift
//  LambdaTimeline
//
//  Created by Spencer Curtis on 10/12/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit
import Photos

enum FilterType {
    case bokeh
    case hue
    case vignette
    case xray
    case sepia
}

class ImagePostViewController: ShiftableViewController {
    
    //MARK: - Properties -
    
    let filterController = FilterController()
    var postController: PostController!
    var post: Post?
    var imageData: Data?
    var selectedFilter: FilterType = .bokeh
    
    //MARK: - IBOutlets -
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var chooseImageButton: UIButton!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var postButton: UIBarButtonItem!
    
    //Labels - These will display the attribute for the filter that the use will be adjusting
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var labelThree: UILabel!
    @IBOutlet weak var labelFour: UILabel!
    @IBOutlet weak var labelFive: UILabel!
    
    //Sliders - These are what the user will be interacting with to apply filters
    @IBOutlet weak var sliderOne   :  UISlider!
    @IBOutlet weak var sliderTwo   :  UISlider!
    @IBOutlet weak var sliderThree :  UISlider!
    @IBOutlet weak var sliderFour  :  UISlider!
    @IBOutlet weak var sliderFive  :  UISlider!
    
    //MARK: - Methods -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
        setImageViewHeight(with: 1.0)
    }
    
    //This method handles updating all the control views based on the filter selected
    private func updateViews() {
        switch selectedFilter {
            
        ///Case for the Bokeh blur filter
        case .bokeh:
            
            //setting up labels and sliders based on selected filter
            labelOne.text = "Radius"
            labelTwo.text = "Ring Amount"
            labelThree.text = "Ring Size"
            labelFour.text = "Softness"
            
            sliderOne.minimumValue = 0
            sliderOne.maximumValue = 500
            sliderTwo.minimumValue = 0
            sliderTwo.maximumValue = 1
            sliderThree.minimumValue = 0
            sliderThree.maximumValue = 100
            sliderFour.minimumValue = 0
            sliderFour.maximumValue = 10
            
            //hiding/revealing views based on selected filter
            labelOne.isHidden    = false
            labelTwo.isHidden    = false
            labelThree.isHidden  = false
            labelFour.isHidden   = false
            labelFive.isHidden   = true
            
            sliderOne.isHidden   = false
            sliderTwo.isHidden   = false
            sliderThree.isHidden = false
            sliderFour.isHidden  = false
            sliderFive.isHidden  = true
            
        ///Case for the Hue filter
        case .hue:
            
            //setting up labels and sliders based on selected filter
            labelOne.text = "Angle"
            
            sliderOne.minimumValue = 0
            sliderOne.maximumValue = 90
            
            //hiding/revealing views based on selected filter
            labelOne.isHidden = false
            labelTwo.isHidden = true
            labelThree.isHidden = true
            labelFour.isHidden = true
            labelFive.isHidden = true
            
            sliderOne.isHidden  = false
            sliderTwo.isHidden = true
            sliderThree.isHidden = true
            sliderFour.isHidden = true
            sliderFive.isHidden = true
            
        ///Case for the Vignette filter
        case .vignette:
            
            //setting up labels and sliders based on selected filter
            labelOne.text = "Intensity"
            labelTwo.text = "Radius"
            
            sliderOne.minimumValue = -1
            sliderOne.maximumValue = 1
            sliderTwo.minimumValue = 0
            sliderTwo.maximumValue = 2
            
            //hiding/revealing views based on selected filter
            labelOne.isHidden = false
            labelTwo.isHidden = false
            labelThree.isHidden = true
            labelFour.isHidden = true
            labelFive.isHidden = true
            
            sliderOne.isHidden  = false
            sliderTwo.isHidden = false
            sliderThree.isHidden = true
            sliderFour.isHidden = true
            sliderFive.isHidden = true
            
        ///Case for the X-Ray filter
        case .xray:
            
            //setting up labels and sliders based on selected filter
            labelOne.text = "No adjustment needed for this one 🙂"
            
            //hiding/revealing views based on selected filter
            labelOne.isHidden = false
            labelTwo.isHidden = true
            labelThree.isHidden = true
            labelFour.isHidden = true
            labelFive.isHidden = true
            
            sliderOne.isHidden  = true
            sliderTwo.isHidden = true
            sliderThree.isHidden = true
            sliderFour.isHidden = true
            sliderFive.isHidden = true
            
        ///Case for the Vortex Distortion filter
        case .sepia:
            
            //setting up labels and sliders based on selected filter
            labelOne.text = "Intensity"
            
            sliderOne.minimumValue = 0
            sliderOne.maximumValue = 10
            
            //hiding/revealing views based on selected filter
            labelOne.isHidden = false
            labelTwo.isHidden = true
            labelThree.isHidden = true
            labelFour.isHidden = true
            labelFive.isHidden = true
            
            sliderOne.isHidden  = false
            sliderTwo.isHidden = true
            sliderThree.isHidden = true
            sliderFour.isHidden = true
            sliderFive.isHidden = true
        }
    }
    
    private func presentImagePickerController() {
        
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            presentInformationalAlertController(title: "Error", message: "The photo library is unavailable")
            return
        }
        
        DispatchQueue.main.async { 
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    private func setImageViewHeight(with aspectRatio: CGFloat) {
        
        imageHeightConstraint.constant = imageView.frame.size.width * aspectRatio
        
        view.layoutSubviews()
    }
    
    private func setFilter(To filter: FilterType) {
        
        switch filter {
        case .bokeh:
            selectedFilter = .bokeh
        case .hue:
            selectedFilter = .hue
        case .vignette:
            selectedFilter = .vignette
        case .xray:
            selectedFilter = .xray
        case .sepia:
            selectedFilter = .sepia
        }
        
    }
    
    //MARK: - IBActions -
    
    @IBAction func createPost(_ sender: Any) {
        
        view.endEditing(true)
        
        guard let image = imageView.image,
            let title = titleTextField.text, title != "" else {
                presentInformationalAlertController(title: "Uh-oh", message: "Make sure that you add a photo and a caption before posting.")
                return
        }
        
        postController.createImagePost(with: title, image: image, ratio: image.ratio)
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func chooseImage(_ sender: Any) {
        
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch authorizationStatus {
        case .authorized:
            presentImagePickerController()
        case .notDetermined:
            
            PHPhotoLibrary.requestAuthorization { (status) in
                
                guard status == .authorized else {
                    NSLog("User did not authorize access to the photo library")
                    self.presentInformationalAlertController(title: "Error", message: "In order to access the photo library, you must allow this application access to it.")
                    return
                }
                
                self.presentImagePickerController()
            }
            
        case .denied:
            self.presentInformationalAlertController(title: "Error", message: "In order to access the photo library, you must allow this application access to it.")
        case .restricted:
            self.presentInformationalAlertController(title: "Error", message: "Unable to access the photo library. Your device's restrictions do not allow access.")
        default:
            break
        }
        presentImagePickerController()
    }
    
    @IBAction func filterChangedSegmentedControl(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            selectedFilter = .bokeh
            updateViews()
        case 1:
            selectedFilter = .hue
            updateViews()
        case 2:
            selectedFilter = .vignette
            updateViews()
        case 3:
            selectedFilter = .xray
            updateViews()
        case 4:
            selectedFilter = .sepia
            updateViews()
        default:
            print("Could not detect selected filter segment")
        }
        
    }
    
    @IBAction func sliderOneAdjusted(_ sender: UISlider) {
        
    }
    
    @IBAction func sliderTwoAdjusted(_ sender: UISlider) {
        
    }
    
    @IBAction func sliderThreeAdjusted(_ sender: UISlider) {
        
    }
    
    @IBAction func sliderFourAdjusted(_ sender: UISlider) {
        
    }
    
    @IBAction func sliderFiveAdjusted(_ sender: UISlider) {
        
    }
    
}

extension ImagePostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        chooseImageButton.setTitle("", for: [])
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        imageView.image = image
        
        setImageViewHeight(with: image.ratio)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
