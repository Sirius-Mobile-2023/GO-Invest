import UIKit

public enum Theme {
    // MARK: - Fonts
    public enum Fonts {
        public static let buttonFont = UIFont.systemFont(ofSize: 19, weight: .semibold)
        public static let titleFont = UIFont.systemFont(ofSize: 19, weight: .bold)
        public static let subtitleFont = UIFont.systemFont(ofSize: 17, weight: .light)
    }
}

public extension Theme {
    // MARK: - Colors
    static let backgroundColor = UIColor(named: "BackgroundColor")
    static let yellowColor = UIColor(named: "YellowColor")
    static let buttonColor = UIColor(named: "BlackColor")
    static let mainTextColor = UIColor(named: "BlackColor")
    static let buttonTextColor = UIColor(named: "WhiteColor")
    // MARK: - Elements style
    static let imageCornerRadius: CGFloat = 20
    static let buttonCornerRadius: CGFloat = 10
    static let skeletonCornerRadius: Float = 20
    // MARK: - Images
    static let quotesTabBarImage = UIImage(systemName: "arrow.up.arrow.down")
    static let profileTabBarImageUnchecked = UIImage(systemName: "person")
    static let profileTabBarImageChecked = UIImage(systemName: "person.fill")
    static let backNavBarImage = UIImage(systemName: "chevron.left.circle")
    // MARK: - Layout
    static let smallSpacing: CGFloat = 10
    static let bigSpacing: CGFloat = 20
    static let sideOffset: CGFloat = 20
    static let topOffset: CGFloat = 10
    static let buttonHeight: CGFloat = 55
}
