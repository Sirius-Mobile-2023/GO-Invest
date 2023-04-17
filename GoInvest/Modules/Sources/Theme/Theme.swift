import UIKit

public enum Theme {

    public enum Fonts {
        public static let button = UIFont.systemFont(ofSize: 19, weight: .semibold)
        public static let title = UIFont.systemFont(ofSize: 19, weight: .bold)
        public static let subtitle = UIFont.systemFont(ofSize: 17, weight: .light)
    }

    public enum Colors {
        public static let background = UIColor(named: "BackgroundColor")
        public static let yellow = UIColor(named: "YellowColor")
        public static let button = UIColor(named: "BlackColor")
        public static let mainText = UIColor(named: "BlackColor")
        public static let buttonText = UIColor(named: "WhiteColor")
    }

    public enum Images {
        public static let quotesTabBar = UIImage(systemName: "arrow.up.arrow.down")
        public static let profileTabBarUnchecked = UIImage(systemName: "person")
        public static let profileTabBarChecked = UIImage(systemName: "person.fill")
        public static let backNavBar = UIImage(systemName: "chevron.left.circle")
    }
    public enum StyleElements {
        public static let imageCornerRadius: CGFloat = 20
        public static let buttonCornerRadius: CGFloat = 10
    }

    public enum Layout {
        public static let smallSpacing: CGFloat = 10
        public static let bigSpacing: CGFloat = 20
        public static let sideOffset: CGFloat = 20
        public static let topOffset: CGFloat = 10
        public static let buttonHeight: CGFloat = 55
    }
}
