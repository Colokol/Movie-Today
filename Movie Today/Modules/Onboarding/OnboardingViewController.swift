//
//  ViewController.swift
//  Movie Today
//
//  Created by Юрий on 25.12.2023.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    //MARK: - Properties
    
    private var slides = [OnboardingView]()
    
    //MARK: - UI Elements
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.bounces = false
        return scrollView
    }()
    
    private let pageControl: UIPageControl = {
        var customPageControl = UIPageControl()
        customPageControl.translatesAutoresizingMaskIntoConstraints = false
        customPageControl.numberOfPages = 3
        customPageControl.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        customPageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0, green: 0.8186600804, blue: 0.8617991805, alpha: 1)
        customPageControl.pageIndicatorTintColor = #colorLiteral(red: 0, green: 0.395287931, blue: 0.4508596659, alpha: 1)
        return customPageControl
    }()
    
    private lazy var nextButton: UIButton = {
        let nextButton = UIButton(type: .system)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitle("\u{203A}", for: .normal)
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        nextButton.backgroundColor = #colorLiteral(red: 0, green: 0.8186600804, blue: 0.8617991805, alpha: 1)
        nextButton.tintColor = .black
        nextButton.layer.cornerRadius = 15
        nextButton.addTarget(self, action: #selector(nextSlide), for: .touchUpInside)
        return nextButton
    }()
    
    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setDelegates()
        setConstraints()
        
        slides = createSlides()
        setupSlidesScrollView(slides: slides)

    }
    
    //MARK: - Private Methods
    
    private func setupViews() {
        view.backgroundColor = #colorLiteral(red: 0.09019417316, green: 0.09019757062, blue: 0.1494292915, alpha: 1)
        
        view.addSubview(scrollView)
        view.addSubview(pageControl)
        view.addSubview(nextButton)
    }
    
    private func setDelegates() {
        scrollView.delegate = self
    }
    
    private func createSlides() -> [OnboardingView] {
        let firstOnboardingView = OnboardingView()
        firstOnboardingView.setFirstLabelText(text: "Lorem ipsum dolor sit amet consecteur esplicit")
        firstOnboardingView.setSecondLabelText(text: "Semper in cursus magna et eu varius nunc adipiscing. Elementum justo, laoreet id sem semper parturient.")
        firstOnboardingView.setOnboardingImage(image: #imageLiteral(resourceName: "First"))
        
        let secondOnboardingView = OnboardingView()
        secondOnboardingView.setFirstLabelText(text: "Lorem ipsum dolor sit amet consecteur esplicit")
        secondOnboardingView.setSecondLabelText(text: "Semper in cursus magna et eu varius nunc adipiscing. Elementum justo, laoreet id sem semper parturient.")
        secondOnboardingView.setOnboardingImage(image: #imageLiteral(resourceName: "Second"))
        
        let thirdOnboardingView = OnboardingView()
        thirdOnboardingView.setFirstLabelText(text: "Lorem ipsum dolor sit amet consecteur esplicit")
        thirdOnboardingView.setSecondLabelText(text: "Semper in cursus magna et eu varius nunc adipiscing. Elementum justo, laoreet id sem semper parturient.")
        thirdOnboardingView.setOnboardingImage(image: #imageLiteral(resourceName: "Third"))
        
        return [firstOnboardingView, secondOnboardingView, thirdOnboardingView]
    }
    
    private func goToHomeScreen() {
        UserDefaults.standard.set(true, forKey: "onboardingCompleted")
        let viewController = AuthViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
 
    //MARK: - Actions

    @objc private func nextSlide() {
        let currentPageIndex = pageControl.currentPage
        let nextPageIndex = currentPageIndex + 1
        
        // Проверяем, что существует следующий слайд
        guard nextPageIndex < slides.count else {
            goToHomeScreen()
            return
        }
        
        // Прокручиваем scrollView до следующего слайда
        let xOffset = scrollView.frame.width * CGFloat(nextPageIndex)
        scrollView.setContentOffset(CGPoint(x: xOffset, y: scrollView.contentOffset.y), animated: true)
        
        // Обновляем текущую страницу в pageControl
        pageControl.currentPage = nextPageIndex
        
    }
    
    private func setupSlidesScrollView(slides: [OnboardingView]) {
        
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count),
                                        height: scrollView.frame.height)
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i),
                                     y: 0,
                                     width: view.frame.width,
                                     height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
}

// MARK: - UIScrollViewDelegate

extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let maxHorizontalOfSet = scrollView.contentSize.width - view.frame.width
        let percentHorizontalOffset = scrollView.contentOffset.x / maxHorizontalOfSet
        
        if percentHorizontalOffset <= 0.5 {
            let firstTransform = CGAffineTransform(scaleX: (0.5 - percentHorizontalOffset) / 0.5,
                                                    y: (0.5 - percentHorizontalOffset) / 0.5)
            let secondTransform = CGAffineTransform(scaleX: percentHorizontalOffset / 0.5,
                                                    y: percentHorizontalOffset / 0.5)
            slides[0].setPageLabelTransform(transform: firstTransform)
            slides[1].setPageLabelTransform(transform: secondTransform)
        } else {
            let secondTransform = CGAffineTransform(scaleX: (1 - percentHorizontalOffset) / 0.5,
                                                    y: (1 - percentHorizontalOffset) / 0.5)
            let thirdTransform = CGAffineTransform(scaleX: percentHorizontalOffset,
                                                    y: percentHorizontalOffset)
            slides[1].setPageLabelTransform(transform: secondTransform)
            slides[2].setPageLabelTransform(transform: thirdTransform)
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let targetOffsetX = targetContentOffset.pointee.x
        let currentPageIndex = Int(targetOffsetX / view.frame.width)

        pageControl.currentPage = currentPageIndex
        //currentButtons()
    }
}

// MARK: - Set Constraints

extension OnboardingViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            //scrollView.heightAnchor.constraint(equalTo: view.heightAnchor),
            
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            nextButton.heightAnchor.constraint(equalToConstant: 70),
            nextButton.widthAnchor.constraint(equalToConstant: 70),
            
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            pageControl.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

