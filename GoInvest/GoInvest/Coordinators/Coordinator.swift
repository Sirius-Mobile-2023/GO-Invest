//
//  Coordinator.swift
//  GoInvest
//
//  Created by Анастасия Бегинина on 11.04.2023.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    func start()
}
