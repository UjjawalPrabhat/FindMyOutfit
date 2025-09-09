# FindMyOutfit - iOS Shopping eCommerce App

A modern iOS shopping application built with Swift and UIKit that provides a seamless e-commerce experience for browsing and purchasing fashion items.

## � Screenshots

<div align="center">
  <img src="Shopping-eCommerce/assets/Screenshot 2025-09-10 020023.png" width="250" alt="App Screenshot 1">
  <img src="Shopping-eCommerce/assets/Screenshot 2025-09-10 020235.png" width="250" alt="App Screenshot 2">
  <img src="Shopping-eCommerce/assets/Screenshot 2025-09-10 020256.png" width="250" alt="App Screenshot 3">
</div>

## �📱 Features

- **User Authentication**: Login, registration, and password recovery
- **Product Browsing**: Browse products by categories (Electronics, Jewelry, Men's/Women's clothing)
- **Product Details**: Detailed product information with images, ratings, and descriptions
- **Shopping Cart**: Add/remove items, quantity management
- **Categories**: Filter products by different categories
- **User Profile**: Manage user account and preferences

## 🏗️ Architecture

The app follows the **MVC (Model-View-Controller)** architecture pattern:

### Models
- `ProductModel`: Product data structure (id, title, price, image, rating, category, description)
- `CategoryModel`: Category data structure
- `UserModel`: User authentication and profile data

### Views
- Storyboard-based UI with custom XIB files
- Custom collection view cells for products and categories
- Custom table view cells for cart and categorized items
- Custom UI components (CustomUIStepper)

### Controllers
- Scene-based view controllers for different app sections:
  - **Home**: Main product browsing interface
  - **Login/Auth**: User authentication flows
  - **Cart**: Shopping cart management
  - **Profile**: User profile and settings
  - **Product Detail**: Individual product information
  - **Categorized**: Category-specific product listings

## 📁 Project Structure

```
Shopping-eCommerce/
├── Controller/                 # View Controllers
│   ├── tabBarViewController.swift
│   ├── ViewController.swift
│   └── Scenes/
│       ├── Cart/              # Shopping cart functionality
│       ├── Categorized/       # Category-based browsing
│       ├── Home/              # Main app interface
│       ├── Login/             # Authentication flows
│       ├── ProductDetail/     # Product information
│       └── Profile/           # User profile
├── Core/                      # App configuration and assets
│   ├── AppDelegate.swift
│   ├── SceneDelegate.swift
│   ├── Info.plist
│   └── Assets.xcassets/       # Image assets and app icons
├── Helper/                    # Utility classes
│   ├── Constants.swift        # App constants and URLs
│   └── DuplicateFuncs.swift   # Shared utility functions
├── Model/                     # Data models
│   ├── Category/              # Category-related models
│   ├── Product/               # Product-related models
│   └── User/                  # User-related models
└── View/                      # UI components
    ├── Base.lproj/            # Storyboards
    └── Custom Views/          # Custom UI components
```

## 🛠️ Technologies Used

- **Language**: Swift
- **UI Framework**: UIKit
- **Networking**: Alamofire
- **Image Loading**: SDWebImage
- **Architecture**: MVC
- **Interface**: Storyboards + XIB files
- **Data Source**: Fake Store API (https://fakestoreapi.com)

## 🔗 API Integration

The app integrates with the Fake Store API:
- **Base URL**: `https://fakestoreapi.com/products`
- **Categories**: `https://fakestoreapi.com/products/categories`
- **Category Products**: `https://fakestoreapi.com/products/category`

## 📋 Requirements

- iOS 13.0+
- Xcode 11.0+
- Swift 5.0+

## 🚀 Getting Started

1. Clone the repository
2. Open `Shopping-eCommerce.xcodeproj` in Xcode
3. Install dependencies (Alamofire, SDWebImage)
4. Build and run the project

## 📸 App Categories

The app supports four main product categories:
- 👔 Men's Clothing
- 👗 Women's Clothing
- 💎 Jewelry
- 📱 Electronics

## 🎨 UI Components

- Custom collection view layouts for products and categories
- Responsive table views for cart and product listings
- Custom stepper control for quantity selection
- Image assets for categories and branding

## 📦 Dependencies

- **Alamofire**: Network requests and API communication
- **SDWebImage**: Efficient image loading and caching

## 👨‍💻 Development

This project is structured for easy maintenance and feature expansion. The modular architecture allows for:
- Easy addition of new product categories
- Scalable user authentication system
- Flexible UI component reuse
- Clean separation of concerns

---

*Built with ❤️ using Swift and UIKit*
