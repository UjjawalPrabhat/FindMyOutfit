//
//  HomeViewController.swift
//  FindMyOutfit
//
//  
//

import UIKit
import Alamofire
import SDWebImage

class HomeViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    static var productList: [ProductModel] = []
    static var categoryList: [CategoryModel] = []
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionSetup()
        tabBarSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchCategories()
        fetchProducts()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        HomeViewController.categoryList = []
    }
    
    //MARK: - Functions
    func fetchProducts() {
        HomeViewController.productList = []
        AF.request(K.Network.baseURL).response { response in
            switch response.result {
            case .success(_):
                do {
                    let productData = try JSONDecoder().decode([ProductData].self, from: response.data!)
                    for data in productData {
                        HomeViewController.productList.append(ProductModel(id: data.id, title: data.title, price: Float(data.price), image: data.image, rate: Float(data.rating.rate), category: data.category, description: data.description, count: data.rating.count))
                        DispatchQueue.main.async {
                            self.productCollectionView.reloadData()
                        }
                    }
                } catch let error {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchCategories() {
        AF.request(K.Network.categoriesURL).response { response in
            switch response.result {
            case .success(let data):
                do {
                    let categories = try JSONDecoder().decode([String].self, from: data!)
                    for category in categories {
                        HomeViewController.categoryList.append(CategoryModel(category: category))
                    }
                    DispatchQueue.main.async {
                        self.categoryCollectionView.reloadData()
                    }
                } catch let error {
                    print(error)
                }
            case .failure(let error):
                print("error on fetchCategories func: \(error.localizedDescription)")
            }
        }
    }
    
    func tabBarSetup() {
        self.tabBarController?.navigationItem.hidesBackButton = true
        tabBarController!.tabBar.items?[1].badgeValue = "0"
    }
    
    //MARK: - CollectionCells Setup
    func collectionSetup() {
        categoryCollectionView.register(UINib(nibName: K.CollectionViews.topCollectionViewNibNameAndIdentifier, bundle: nil), forCellWithReuseIdentifier: K.CollectionViews.topCollectionViewNibNameAndIdentifier)
        
        categoryCollectionView.collectionViewLayout = TopCollectionViewColumnFlowLayout(columnCount: 2, minColumnSpacing: 5, minRowSpacing: 5)
        
        productCollectionView.register(UINib(nibName: K.CollectionViews.bottomCollectionViewNibNameAndIdentifier, bundle: nil), forCellWithReuseIdentifier: K.CollectionViews.bottomCollectionViewNibNameAndIdentifier)
        
        productCollectionView.collectionViewLayout = BottomCollectionViewColumnFlowLayout(columnCount: 2, minColumnSpacing: 5, minRowSpacing: 5)
    }
    
    //MARK: - Functions
    func changeVCcategoryToTableView(category: String) {
        switch category {
            
        case "electronics":
            let categoryName = "electronics"
            CategorizedViewController.selectedCategory = categoryName
            
        case "jewelery":
            let categoryName = "jewelery"
            CategorizedViewController.selectedCategory = categoryName
            
        case "men's clothing":
            let categoryName = "men's%20clothing"
            CategorizedViewController.selectedCategory = categoryName
            
        case "women's clothing":
            let categoryName = "women's%20clothing"
            CategorizedViewController.selectedCategory = categoryName
            
        default:
            DuplicateFuncs.alertMessage(title: "Category Error", message: "", viewController: self)
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: K.Segues.categoryTableView)
        show(viewController, sender: self)
    }
    
    func changeVCHomeToProductDetail(id: Int) {
        ProductDetailViewController.selectedProductID = id
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: K.Segues.productDetailViewController)
        show(viewController, sender: self)
    }
}

//MARK: - Extensions
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
            
        case categoryCollectionView:
            return HomeViewController.categoryList.count
            
        case productCollectionView:
            return HomeViewController.productList.count
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
            
        case categoryCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.CollectionViews.topCollectionViewNibNameAndIdentifier, for: indexPath) as! CategoriesCollectionViewCell
            let category = HomeViewController.categoryList[indexPath.row].category
            cell.categoryLabel.text = category?.capitalized
            
            switch category {
            case "electronics":
                cell.categoryImageView.image = UIImage(named: "electronics.png")
            case "jewelery":
                cell.categoryImageView.image = UIImage(named: "jewelery.png")
            case "men's clothing":
                cell.categoryImageView.image = UIImage(named: "man.png")
            case "women's clothing":
                cell.categoryImageView.image = UIImage(named: "woman.png")
            default:
                cell.categoryImageView.image = UIImage(systemName: "questionmark.square.dashed")
            }
            return cell
            
        case productCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.CollectionViews.bottomCollectionViewNibNameAndIdentifier, for: indexPath) as! ProductsCollectionViewCell
            let product = HomeViewController.productList[indexPath.row]
            cell.productImageView.sd_setImage(with: URL(string: product.image!), placeholderImage: UIImage(systemName: "photo.on.rectangle.angled"))
            cell.productNameLabel.text = product.title
            cell.productRateLabel.text = "★ \(product.rate!) "
            cell.productPriceLabe.text = "$\(product.price!)"
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
            
        case categoryCollectionView:
            if let category = HomeViewController.categoryList[indexPath.row].category {
                changeVCcategoryToTableView(category: category)
            }
            
        case productCollectionView:
            if let productId = HomeViewController.productList[indexPath.row].id {
                changeVCHomeToProductDetail(id: productId)
            }
            
        default:
            print("error at didSelectItemAt")
            break
        }
    }
}
