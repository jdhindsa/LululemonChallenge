//
//  JDGarmentAddVC.swift
//  LululemonChallenge
//
//  Created by Jason Dhindsa on 2021-08-28.
//

import UIKit

protocol GarmentAddDelegate: AnyObject {
    func garmentAdded(_ garment: JDGarment)
}

final class JDGarmentAddVC: UIViewController {
    lazy var garmentNameLabel = JDLabel(text: "Garment Name:")
    lazy var garmentTextField = JDTextField()
    
    private var isGarmentEntered: Bool {
        guard let enteredText = garmentTextField.text else { return false }
        return !enteredText.isEmpty
    }
    private var garmentData: JDGarment?
    weak var delegate: GarmentAddDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        setupNavigationBar()
        layoutUI()
        createDismissKeyboardTapGesture()
    }
    
    private func configureVC() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem =
            UIBarButtonItem(
                title: "Save",
                style: .plain,
                target: self,
                action: #selector(saveGarment)
            )
        navigationItem.leftBarButtonItem =
            UIBarButtonItem(
                title: "Cancel",
                style: .plain,
                target: self,
                action: #selector(cancelGarment)
            )
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Add Garment"
    }
    
    private func layoutUI() {
        view.addSubviews(garmentNameLabel, garmentTextField)
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        
        garmentNameLabel.anchor(
            top: safeAreaLayoutGuide.topAnchor,
            leading: safeAreaLayoutGuide.leadingAnchor,
            bottom:nil,
            trailing: safeAreaLayoutGuide.trailingAnchor,
            identifier: "GarmentAddViewController.garmentNameLabel.directionalAnchors",
            padding: .init(top: 10, left: 16, bottom: 0, right: 16)
        )
        garmentNameLabel.constrainHeightToConstant(50, identifier: "GarmentAddViewController.garmentNameLabel.heightAnchor")
        
        garmentTextField.anchor(
            top: garmentNameLabel.bottomAnchor,
            leading: safeAreaLayoutGuide.leadingAnchor,
            bottom: nil,
            trailing: safeAreaLayoutGuide.trailingAnchor,
            identifier: "GarmentAddViewController.garmentTextField.directionalAnchors",
            padding: .init(top: 10, left: 16, bottom: 0, right: 16)
        )
        garmentTextField.constrainHeightToConstant(35, identifier: "GarmentAddViewController.garmentTextField.heightAnchor")
    }
    
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - UITextField Helper Methods
    private func validateUserInput() -> Bool {
        guard isGarmentEntered else {
            return false
        }
        guard let enteredText = garmentTextField.text else { return false }
        garmentData = JDGarment(garmentName: enteredText, creationDate: Date())
        guard let garmentData = self.garmentData else { return false }
        delegate?.garmentAdded(garmentData)
        return true
    }
    
    private func clearTextField() {
        garmentTextField.text?.removeAll()
    }
    
    // MARK: - Selector Methods
    @objc private func saveGarment(sender: UIButton) {
        if validateUserInput() {
            clearTextField()
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc private func cancelGarment(sender: UIButton) {
        clearTextField()
        dismiss(animated: true, completion: nil)
    }
}

extension JDGarmentAddVC: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        if validateUserInput() {
            clearTextField()
        }
    }
}
