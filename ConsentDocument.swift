//
//  ConsentDocument.swift
//  workaday
//
//  Created by Adam Preston on 4/12/16.
//  Copyright © 2016 RTI. All rights reserved.
//


import ResearchKit

class ConsentDocument: ORKConsentDocument {
    

    
    
    // MARK: Initialization
    
    override init() {
        super.init()
        
        title = NSLocalizedString("Research Health Study Consent Form", comment: "")
        
        let sectionTypes: [ORKConsentSectionType] = [
            .Overview,
            .DataGathering,
            .Privacy,
            .DataUse,
            .Withdrawing
        ]
        
        
        let consentSections: [ORKConsentSection] = sectionTypes.map {
            contentSectionType in
            
            let consentSection = ORKConsentSection(type: contentSectionType)
            
            if contentSectionType == .Overview {
                consentSection.htmlContent = loadHTMLContent("Consent_Welcome")
            }else if contentSectionType == .DataGathering {
                consentSection.htmlContent = loadHTMLContent("Consent_DataGathering")
            }else if contentSectionType == .Privacy {
                consentSection.htmlContent = loadHTMLContent("Consent_Privacy")
            }else if contentSectionType == .DataUse {
                consentSection.htmlContent = loadHTMLContent("Consent_DataUse")
            }else if contentSectionType == .Withdrawing {
                consentSection.htmlContent = loadHTMLContent("Consent_Withdrawing")
            }
            
            return consentSection
            
        }
    
        sections = consentSections
        
        let signature = ORKConsentSignature(forPersonWithTitle: nil, dateFormatString: nil, identifier: "ConsentDocumentParticipantSignature")
        addSignature(signature)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


