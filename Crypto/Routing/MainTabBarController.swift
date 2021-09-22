import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        
        tabBar.barTintColor = .tertiarySystemBackground
    }
    
    func setupTabBar() {
        let homeVC = createNavController(vc: HomeViewController(), selected: UIImage(systemName: "house")!, unselected: UIImage(systemName: "house.fill")!)
        
        let walletVC = createNavController(vc: WalletViewController(), selected: UIImage(systemName: "wallet.pass")!, unselected: UIImage(systemName: "wallet.pass.fill")!)
        
        let favouriteVC = createNavController(vc: FavouriteViewController(), selected: UIImage(systemName: "star")!, unselected: UIImage(systemName: "star.fill")!)
        
        let friendsVC = createNavController(vc: FriendsViewController(), selected: UIImage(systemName: "person.badge.plus")!, unselected: UIImage(systemName: "person.fill.badge.plus")!)
        
        let settingsVC = createNavController(vc: SettingsViewController(), selected: UIImage(systemName: "gearshape.2")!, unselected: UIImage(systemName:"gearshape.2.fill")!)
        
        
        homeVC.title = "Home"
        walletVC.title = "Wallet"
        favouriteVC.title = "Favorites"
        friendsVC.title = "Friends"
        settingsVC.title = "Settings"
        
        viewControllers = [homeVC, walletVC, favouriteVC, friendsVC, settingsVC]
    }
    
}

extension UITabBarController {
    
    func createNavController(vc: UIViewController, selected: UIImage, unselected: UIImage) -> UINavigationController {
        let viewController = vc
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselected
        navController.tabBarItem.selectedImage = selected
        return navController
    }
}
