//
//  SliderViewController.swift
//  SwipeLetters
//
//  Created by Glenn Posadas on 1/21/21.
//

import UIKit

class SliderViewController: BaseViewController {

    // MARK: - Properties
    
    @IBOutlet weak var contentView: UIView!

    private var pageViewController: UIPageViewController?
    
    // MARK: - Overrides
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPageController()
    }

    private func setupPageController() {
        pageViewController = UIPageViewController(
            transitionStyle: .pageCurl,
            navigationOrientation: .horizontal,
            options: nil
        )
        
        let contentController = mainSB.instantiateViewController(identifier: "ContentViewController")
            as! ContentViewController
        contentController.text = DataManager.data.first
        
        let viewControllers = [contentController]
        pageViewController!.setViewControllers(
            viewControllers,
            direction: .forward,
            animated: false,
            completion: nil
        )
        
        pageViewController?.dataSource = self
        
        addChild(pageViewController!)
        contentView.addSubview(pageViewController!.view)

        pageViewController!.view.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
            pageViewController!.view.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 0
            ),
            pageViewController!.view.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: 0
            ),
            pageViewController!.view.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 0
            ),
            pageViewController!.view.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: 0
            )
        ])
        
        pageViewController!.didMove(toParent: self)
    }
}

// MARK: - UIPageViewControllerDataSource

extension SliderViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = indexOfViewController(viewController as! ContentViewController)
        if (index == 0) || (index == NSNotFound) { return nil }
        index -= 1
        let vc = viewControllerAtIndex(index)
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = indexOfViewController(viewController as! ContentViewController)
        if index == NSNotFound { return nil }
        index += 1
        if index == DataManager.data.count { return nil }
        let vc = viewControllerAtIndex(index)
        return vc
    }
}

extension SliderViewController {
    private func viewControllerAtIndex(_ index: Int) -> ContentViewController? {
        guard DataManager.data.count > index else { return nil }
        let firstWordController = mainSB.instantiateViewController(identifier: "ContentViewController")
            as! ContentViewController
        firstWordController.text = DataManager.data[index]
        return firstWordController
    }

    private func indexOfViewController(_ viewController: ContentViewController) -> Int {
        return DataManager.data.firstIndex(where: { return $0 == viewController.text }) ?? NSNotFound
    }
}
