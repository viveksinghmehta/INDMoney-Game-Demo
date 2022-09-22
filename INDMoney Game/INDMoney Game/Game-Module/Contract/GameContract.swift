//
//  GameContract.swift
//  INDMoney Game
//
//  Created by Vivek Singh Mehta on 21/09/22.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewGameProtocol {
    /// start the game with default values or saved one.
    func setUpGameWithInitialValues(cells: Int, userPosition: Int, crossPositions: [Int], newGame: Bool)
    /// move the user by the number in the dice
    func moveTheUser(newPosition: Int, rollNumber: Int)
    /// finished the game with dice number
    func finishedTheGame(with number: Int)
    /// User landed on the first cross take him to 1st cell
    func takeUserTo1stCell()
    /// User landed on cross take him to new position
    func userLandedOnCross(position: Int)
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterGameProtocol {
    
    var view: PresenterToViewGameProtocol? { get set }
    var interactor: PresenterToInteractorGameProtocol? { get set }
    var router: PresenterToRouterGameProtocol? { get set }
    
    /// User rolled the dice
    func rollTheDice()
    
    /// Setup the game for user
    func setUpGame()
    
    ///start new game
    func startNewGame()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorGameProtocol {
    
    var presenter: InteractorToPresenterGameProtocol? { get set }
    /// total number of cells in the game
    var numberOfCells: Int? { get set }
    /// current user position in the game
    var userPosition: Int? { get set }
    /// The location of all the cross in the game
    var crossPositions: [Int]? { get set }
    
    /// User rolled the dice
    func rollTheDice()
    // Setup the game for user
    func setUpGame()
    //start new game
    func setUpNewGame()
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterGameProtocol {
    
    /// start the game with default values or saved one.
    func setUpGameWithInitialValues(cells: Int, userPosition: Int, crossPositions: [Int], newGame: Bool)
    
    /// move the user by the number in the dice
    func moveTheUser(newPosition: Int, rollNumber: Int)
    
    /// finished the game with dice number
    func finishedTheGame(with number: Int)
    
    /// User landed on the first cross take him to 1st cell
    func takeUserTo1stCell()
    
    /// User landed on cross take him to new position
    func userLandedOnCross(position: Int)
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterGameProtocol {
    
}
