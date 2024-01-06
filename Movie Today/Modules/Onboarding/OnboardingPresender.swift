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
    var sliders: [OnboardingView] { get }
    init(view: OnboardingViewProtocol)
}

class OnboardingPresenter: OnboardingViewPresenterProtocol {

    var view: OnboardingViewProtocol?

    var sliders: [OnboardingView] = []

    required init(view: OnboardingViewProtocol) {
        self.view = view
        sliders = createSlides()
    }

    private func createSlides() -> [OnboardingView] {
        let firstOnboardingView = OnboardingView()
        firstOnboardingView.setFirstLabelText(text: "Lorem ipsum dolor sit amet consecteur esplicit")
        firstOnboardingView.setSecondLabelText(text: "Semper in cursus magna et eu varius nunc adipiscing. Elementum justo, laoreet id sem semper parturient.")
        firstOnboardingView.setOnboardingImage(image: UIImage(named: "SecondImage")! )

        let secondOnboardingView = OnboardingView()
        secondOnboardingView.setFirstLabelText(text: "Lorem ipsum dolor sit amet consecteur esplicit")
        secondOnboardingView.setSecondLabelText(text: "Semper in cursus magna et eu varius nunc adipiscing. Elementum justo, laoreet id sem semper parturient.")
        secondOnboardingView.setOnboardingImage(image: UIImage(named: "SecondImage")!)


        let thirdOnboardingView = OnboardingView()
        thirdOnboardingView.setFirstLabelText(text: "Lorem ipsum dolor sit amet consecteur esplicit")
        thirdOnboardingView.setSecondLabelText(text: "Semper in cursus magna et eu varius nunc adipiscing. Elementum justo, laoreet id sem semper parturient.")
        thirdOnboardingView.setOnboardingImage(image: #imageLiteral(resourceName: "ThirdImage"))

        return [firstOnboardingView, secondOnboardingView, thirdOnboardingView]
    }


}
