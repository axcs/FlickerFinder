//
//  SearchController.swift
//  FlickerFinder
//
//  Created by BBVAMobile on 27/01/2021.
//  Copyright © 2021 Alexandre Carvalho. All rights reserved.
//
//

import UIKit
import AlamofireImage

class SearchController: UIViewController {
    
    //MARK: - IBOutlet Section
    @IBOutlet weak var collectionResult: UICollectionView!
    @IBOutlet weak var labelLoading: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var stackLoading: UIStackView!
    
    //MARK: - var Section
    fileprivate var photosList: [Photo] = []        // var containing photo array
    fileprivate var pageCount = 0                   // var for save page
    fileprivate var isLoading:Bool = false         // var for loading state in load more
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        stackLoading.isHidden = true
    }
    
    
    //MARK: - Func Section
    func callStarterService() {
        RequestsManager.getPhotos(search: searchBar.text ?? "", startIndex: pageCount) { result in
            if result != nil {
                self.photosList = result?.photos.photo ?? []
                self.pageCount += 1
                self.labelLoading.text = ""
                self.collectionResult.reloadData()
            }
        }
    }
    
    func loadMorePhotos(){
        RequestsManager.getPhotos(search: searchBar.text ?? "", startIndex: pageCount) { result in
            if result != nil {
                var photo2: [Photo] = []
                photo2 = self.photosList + (result?.photos.photo)!
                self.photosList = photo2
                self.pageCount += 1
                self.collectionResult.reloadData()
                self.isLoading = false
                self.stackLoading.isHidden = true
            }
        }
    }
}

//MARK: - SearchBar Delegate
extension SearchController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        searchBar.resignFirstResponder()
        //Reset old data first befor new search Results
        resetValuesForNewSearch()
        guard let text = searchBar.text?.removeSpace,
            text.count != 0  else {
                labelLoading.text = "Please type keyword to search result."
                return
        }
        //Requesting here new keyword
        callStarterService()
        labelLoading.text = "Searching Images..."
    }
    
    //MARK: - Clearing here old data search results with current running tasks
    func resetValuesForNewSearch(){
        pageCount = 0
        photosList.removeAll()
        collectionResult.reloadData()
    }
}

//MARK: - Collection View DataSource
extension SearchController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return photosList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        guard photosList.count != 0 else {
            return cell
        }
        
        let model = photosList[indexPath.row]
        guard let mediaUrl = model.getImagePath() else { return cell }
        cell.imageResult.af.setImage(withURL: mediaUrl)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "imageFullViewController") as! ImageFullViewController
        newViewController.imageId = photosList[indexPath.row].id
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
    
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension SearchController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = collectionView.bounds.width;
        let itemWidth = collectionWidth / 2 - 1;
        return CGSize(width: itemWidth, height: itemWidth);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

//MARK: - Scrollview Delegate
extension SearchController: UIScrollViewDelegate {
    //MARK :- Getting user scroll down event here
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collectionResult{
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= (scrollView.contentSize.height)){
                if isLoading == false {
                    stackLoading.isHidden = false
                    isLoading = true
                    //Start locading new data
                    loadMorePhotos()
                }
            }
        }
    }
}

