//
//  AddToSiriButton.swift
//  Throne
//
//  Created by Nicholas Josephson on 2020-03-19.
//  Copyright © 2020 Throne. All rights reserved.
//

import SwiftUI
import IntentsUI

struct AddToSiriButton: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> UIViewController {
        return AddShortcutViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {

    }

}

class AddShortcutViewController: UIViewController, INUIAddVoiceShortcutButtonDelegate, INUIAddVoiceShortcutViewControllerDelegate, INUIEditVoiceShortcutViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = INUIAddVoiceShortcutButton(style: .automaticOutline)
        button.shortcut = INShortcut(intent: FindWashroomsNearMeIntent())
        button.delegate = self
        view = button
    }
    
    func present(_ addVoiceShortcutViewController: INUIAddVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
        addVoiceShortcutViewController.delegate = self
        addVoiceShortcutViewController.modalPresentationStyle = .formSheet
        present(addVoiceShortcutViewController, animated: true, completion: nil)
    }
    
    func present(_ editVoiceShortcutViewController: INUIEditVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
        editVoiceShortcutViewController.delegate = self
        editVoiceShortcutViewController.modalPresentationStyle = .formSheet
        present(editVoiceShortcutViewController, animated: true, completion: nil)
    }
    
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didUpdate voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didDeleteVoiceShortcutWithIdentifier deletedVoiceShortcutIdentifier: UUID) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func editVoiceShortcutViewControllerDidCancel(_ controller: INUIEditVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}

struct AddToSiriButton_Previews: PreviewProvider {
    static var previews: some View {
        AddToSiriButton()
    }
}
