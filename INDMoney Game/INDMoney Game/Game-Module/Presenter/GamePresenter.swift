//
//  GamePresenter.swift
//  INDMoney Game
//
//  Created by Vivek Singh Mehta on 21/09/22.
//  
//

import Foundation

class GamePresenter: ViewToPresenterGameProtocol {

    // MARK: Properties
    var view: PresenterToViewGameProtocol?
    var interactor: PresenterToInteractorGameProtocol?
    var router: PresenterToRouterGameProtocol?
    
    func rollTheDice() {
        interactor?.rollTheDice()
    }
    
    func setUpGame() {
        interactor?.setUpGame()
    }
}

extension GamePresenter: InteractorToPresenterGameProtocol {
    
    func takeUserTo1stCell() {
        view?.takeUserTo1stCell()
    }
    
    func userLandedOnCross(position: Int) {
        view?.userLandedOnCross(position: position)
    }
    
    func setUpGameWithInitialValues(cells: Int, userPosition: Int, crossPositions: [Int], newGame: Bool) {
        view?.setUpGameWithInitialValues(cells: cells, userPosition: userPosition, crossPositions: crossPositions, newGame: newGame)
    }
    
    func finishedTheGame(with number: Int) {
        view?.finishedTheGame(with: number)
    }
    
    func moveTheUser(newPosition: Int, rollNumber: Int) {
        view?.moveTheUser(newPosition: newPosition, rollNumber: rollNumber)
    }
    
}
