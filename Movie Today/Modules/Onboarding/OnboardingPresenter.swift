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
        let firstOnboardingView = OnboardingView()
        firstOnboardingView.setFirstLabelText(text: "Lorem ipsum dolor sit amet consecteur esplicit")
        firstOnboardingView.setSecondLabelText(text: "Semper in cursus magna et eu varius nunc adipiscing. Elementum justo, laoreet id sem semper parturient.")
        firstOnboardingView.setOnboardingImage(image: UIImage(named: "FirstImage")! )

        let secondOnboardingView = OnboardingView()
        secondOnboardingView.setFirstLabelText(text: "Lorem ipsum dolor sit amet consecteur esplicit")
        secondOnboardingView.setSecondLabelText(text: "Semper in cursus magna et eu varius nunc adipiscing. Elementum justo, laoreet id sem semper parturient.")
        secondOnboardingView.setOnboardingImage(image: UIImage(named: "SecondImage")!)


        let thirdOnboardingView = OnboardingView()
        thirdOnboardingView.setFirstLabelText(text: "Lorem ipsum dolor sit amet consecteur esplicit")
        thirdOnboardingView.setSecondLabelText(text: "Semper in cursus magna et eu varius nunc adipiscing. Elementum justo, laoreet id sem semper parturient.")
        thirdOnboardingView.setOnboardingImage(image: UIImage(named: "ThirdImage")!)

        return [firstOnboardingView, secondOnboardingView, thirdOnboardingView]
    }


}
