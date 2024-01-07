//
//  OnboardingPresender.swift
//  Movie Today
//
//  Created by Uladzislau Yatskevich on 6.01.24.
//

import Foundation
import UIKit

protocol OnboardingViewProtocol {

}

protocol OnboardingViewPresenterProtocol {
    var slides: [OnboardingView] { get }
    init(view: OnboardingViewProtocol)
}

class OnboardingPresenter: OnboardingViewPresenterProtocol {

    var view: OnboardingViewProtocol?

    var slides: [OnboardingView] = []

    required init(view: OnboardingViewProtocol) {
        self.view = view
        slides = createSlides()
    }
    
    private func createSlides() -> [OnboardingView] {
        var slides: [OnboardingView] = []
        
        for index in 0 ..< OnboardingTexts.titles.count {
            let onboardingView = OnboardingView()
            onboardingView.setFirstLabelText(text: OnboardingTexts.titles[index])
            onboardingView.setSecondLabelText(text: OnboardingTexts.descriptions[index])
            onboardingView.setOnboardingImage(image: UIImage(named: "Image\(index + 1)")!)
            
            slides.append(onboardingView)
        }
        
        return slides
    }

}
