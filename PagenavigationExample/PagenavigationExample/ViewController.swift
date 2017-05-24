//
//  ViewController.swift
//  PagenavigationExample
//
//  Created by Pratyus P on 24/05/17.
//  Copyright © 2017 Pratyus P. All rights reserved.
//


import UIKit

class ViewController: UIViewController,UIPageViewControllerDataSource,UIScrollViewDelegate {
    
    var pageViewController = UIPageViewController()
    var movieDetails = [Model]()
    var badgeViewController = BadgeViewController()
    var scrollView = UIScrollView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovieDetailsData()
        createPageViewController()
        setupPageControl()
        getBadgeViewController()
        
    }
    
    fileprivate func createPageViewController() {
        self.pageViewController = storyboard?.instantiateViewController(withIdentifier: "PageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self
        
        let startViewController =  self.viewControllerAtIndex(0) as PageContentViewController
        let viewControllers = NSArray(objects: startViewController)
        
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .forward, animated: true, completion: nil)
        
        
        self.pageViewController.view.frame = CGRect(x: 0,y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - 130)
        addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMove(toParentViewController: self)
        
    }
    
    fileprivate func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.lightGray
        appearance.currentPageIndicatorTintColor = UIColor.purple
        appearance.backgroundColor = UIColor.clear
    }
    
    func viewControllerAtIndex(_ index: Int) -> PageContentViewController{
        if ((self.movieDetails.count == 0) || (index >= self.movieDetails.count)) {
            
            return PageContentViewController()
            
        }
        
        let vc: PageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as! PageContentViewController
        let  movieData = self.movieDetails[index]
        vc.imageUrl = movieData.url
        vc.pageIndex = index
        return vc
    }
    
    func getBadgeViewController() {
        self.badgeViewController = self.storyboard?.instantiateViewController(withIdentifier: "BadgeViewController") as! BadgeViewController
        
        for subview in self.badgeViewController.view.subviews {
            
            if subview.isKind(of: UIScrollView.self) {
                self.scrollView = subview as! UIScrollView
                self.scrollView.delegate = self
                self.scrollView.delaysContentTouches = true
            }
        }
    }
    
    func scrollToVisible(_ index: Int) {
        
        var x : Int = 0
        if index > 0 {
            let xposition = Int(self.scrollView.frame.width/5)
            x = Int(xposition*index)
        }
        self.scrollView.scrollRectToVisible(CGRect(x: CGFloat(x), y: self.scrollView.frame.origin.y, width: self.scrollView.frame.width, height: self.scrollView.frame.height), animated: true)
    }
    
    @IBAction func unwindToMealList(_ sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? PagenavigationExample.BadgeViewController, let index = sourceViewController.index{
            let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailsViewController
            detailViewController.movieDetails = self.movieDetails[index]
            let navigationController = UINavigationController(rootViewController: detailViewController)
            self.present(navigationController, animated: true, completion: nil)
        }
    }
    
    // MARK: - UIPageViewControllerDataSource
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! PageContentViewController
        var index = vc.pageIndex as Int
        if (index == 0 || index == NSNotFound)
            
        {
            return nil
        }
        
        index -= 1
        scrollToVisible(index)
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! PageContentViewController
        var index = vc.pageIndex as Int
        
        if (index == NSNotFound){
            return nil
        }
        
        index += 1
        if (index == self.movieDetails.count){
            return nil
        }
        scrollToVisible(index)
        return self.viewControllerAtIndex(index)
    }
    
    // MARK: - Page Indicator
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.movieDetails.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func loadMovieDetailsData(){
        
        let movie1 = Model(title: "The Peanuts" , url: "http://t2.gstatic.com/images?q=tbn:ANd9GcSWkn5TW5gwfHZoZb56l9r_cxRRUCWgQZaTC7z5EZJYq0ncpCNF", description: "Life always seems complicated for good ol' Charlie Brown (Noah Schnapp), the boy who always tries his best against seemingly impossible odds. When the Little Red-Haired Girl moves into his neighborhood, Charlie Brown develops a crush on her.", rating: "4/5", language: "English", characters: "Francesca Capaldi, Alexander Garfin", directors: "Steve Martino")
        let movie2 = Model(title: "Storks" , url: "http://t3.gstatic.com/images?q=tbn:ANd9GcSQq_t91J3Rtb5v1gbnqGPF6BSDeFvtFcVmxU50nuczt5KHWsP8", description: "Storks deliver babies -- or at least they used to. Now, they deliver packages for a global internet retail giant. Junior (Andy Samberg), the company's top delivery stork, lands in hot water when the Baby Factory produces an adorable but wholly unauthorized girl.", rating: "4/5", language: "English", characters: "Katie Crown, Andy Samberg", directors: "Nicholas Stoller, Doug Sweetland")
        let movie3 = Model(title: "Mirzya" , url: "http://t2.gstatic.com/images?q=tbn:ANd9GcR_7E_0O_SLWfGwkAlTJplogvf3Aw1Tggg22WwC_K3JuiymYY4l", description: "Star-crossed lovers (Harshvardhan Kapoor, Saiyami Kher) grapple with forces that try to keep them apart.", rating: "3/5", language: "Hindi", characters: "Harshvardhan Kapoor, Saiyami Kher", directors: "Rakeysh Omprakash Mehra")
        let movie4 = Model(title: "The Wild Life" , url: "http://t1.gstatic.com/images?q=tbn:ANd9GcSEoSDRGi-_w2SEhi3EQQJfHtJyIFY0punfGItzbYcmmz6ysjW2", description: "Times are good for Mak the parrot, Scrubby the goat, Carmello the chameleon and the rest of the wildlife that inhabit a tropical island. Their day-to-day routine gets shaken up when a mysterious creature washes up on shore.", rating: "4.5/5", language: "English", characters: "Matthias, Ilka Bessin", directors: "Ben Stassen, Vincent Kesteloot")
        self.movieDetails.append(movie1!)
        self.movieDetails.append(movie2!)
        self.movieDetails.append(movie3!)
        self.movieDetails.append(movie4!)
    }
}

