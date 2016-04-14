//
//  OnboardingViewController.swift
//  workaday
//
//  Created by Adam Preston on 4/12/16.
//  Copyright © 2016 RTI. All rights reserved.
//

import UIKit
import ResearchKit

class OnboardingViewController: UIViewController {
    // MARK: IB actions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func joinButtonTapped(sender: UIButton) {
        let consentDocument = ConsentDocument()
        let consentStep = ORKVisualConsentStep(identifier: "VisualConsentStep", document: consentDocument)
        

        let signature = consentDocument.signatures!.first!
        
        let reviewConsentStep = ORKConsentReviewStep(identifier: "ConsentReviewStep", signature: signature, inDocument: consentDocument)
        
        reviewConsentStep.text = "Review the consent form."
        reviewConsentStep.reasonForConsent = "Consent to join the Developer Health Research Study."
        
        
        let completionStep = ORKCompletionStep(identifier: "CompletionStep")
        completionStep.title = "Welcome aboard."
        completionStep.text = "Thank you for joining this study."
        
        let orderedTask = ORKOrderedTask(identifier: "Join", steps: [consentStep, reviewConsentStep, completionStep])
        let taskViewController = ORKTaskViewController(task: orderedTask, taskRunUUID: nil)
        taskViewController.delegate = self
        
        presentViewController(taskViewController, animated: true, completion: nil)
    }
}

/// This task presents the Account Creation process.
private var accountCreationTask: ORKTask {
    /*
     A registration step provides a form step that is populated with email and password fields.
     If you wish to include any of the additional fields, then you can specify it through the `options` parameter.
     */
    let registrationTitle = NSLocalizedString("Registration", comment: "")
    let passcodeValidationRegex = "^(?=.*\\d).{4,8}$"
    let passcodeInvalidMessage = NSLocalizedString("A valid password must be 4 and 8 digits long and include at least one numeric character.", comment: "")
    let registrationOptions: ORKRegistrationStepOption = [.IncludeGivenName, .IncludeFamilyName, .IncludeGender, .IncludeDOB]
    let registrationStep = ORKRegistrationStep(identifier: String("registration_step"), title: registrationTitle, text: "Additional text can go here", passcodeValidationRegex: passcodeValidationRegex, passcodeInvalidMessage: passcodeInvalidMessage, options: registrationOptions)
    
    /*
     A wait step allows you to upload the data from the user registration onto your server before presenting the verification step.
     */
    let waitTitle = NSLocalizedString("Creating account", comment: "")
    let waitText = NSLocalizedString("Please wait while we upload your data", comment: "")
    let waitStep = ORKWaitStep(identifier: String("wait_step"))
    waitStep.title = waitTitle
    waitStep.text = waitText
    
    /*
     A verification step view controller subclass is required in order to use the verification step.
     The subclass provides the view controller button and UI behavior by overriding the following methods.
     */
    class VerificationViewController : ORKVerificationStepViewController {
        override func resendEmailButtonTapped() {
            let alertTitle = NSLocalizedString("Resend Verification Email", comment: "")
            let alertMessage = NSLocalizedString("Button tapped", comment: "")
            let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    let verificationStep = ORKVerificationStep(identifier: String("Verification Text d"), text: "verification text can go here.", verificationViewControllerClass: VerificationViewController.self)
    
    return ORKOrderedTask(identifier: String("Account Creation Task"), steps: [
        registrationStep,
        waitStep,
        verificationStep
        ])
}

extension OnboardingViewController : ORKTaskViewControllerDelegate {
    
    func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason: ORKTaskViewControllerFinishReason, error: NSError?) {
        switch reason {
        case .Completed:
            performSegueWithIdentifier("unwindToStudy", sender: nil)
            
        case .Discarded, .Failed, .Saved:
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    
}
