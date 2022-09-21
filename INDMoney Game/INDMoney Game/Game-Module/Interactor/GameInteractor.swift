//
//  GameInteractor.swift
//  INDMoney Game
//
//  Created by Vivek Singh Mehta on 21/09/22.
//  
//

import Foundation

class GameInteractor: PresenterToInteractorGameProtocol {
    
    var crossPositions: [Int]?
    
    var numberOfCells: Int?
    
    var userPosition: Int?
    
    // MARK: Properties
    var presenter: InteractorToPresenterGameProtocol?
    
    func setUpGame() {
        if checkForPreviousSavedGame() {
            loadPreviousGame()
        } else {
            setUpNewGame()
        }
    }
    
    func rollTheDice() {
        let random = Int.random(in: 1...6)
        if let position = userPosition, let cells = numberOfCells {
            userPosition = random + position
            if (userPosition ?? 1) >= cells {
                presenter?.finishedTheGame(with: random)
            } else {
                presenter?.moveTheUser(newPosition: userPosition ?? 1, rollNumber: random)
            }
            checkIfTheUserLandsOnCross(position: 10)
        }
    }
    
    func checkIfTheUserLandsOnCross(position: Int) {
        if let crossPositions = crossPositions {
            guard let index = crossPositions.firstIndex(where: { $0 == position }) else {
                saveUserPosition(position: position)
                return }
            if crossPositions[index] == crossPositions[0] {
                // go back the first cell
                print("here")
                saveUserPosition(position: 1)
                presenter?.takeUserTo1stCell()
            } else {
                // then go back 1 left of the previous cross

                
                // go to the cell and change the user position
                saveUserPosition(position: 1)
                presenter?.userLandedOnCross(position: 1)
            }
        }
    }
    
    func saveUserPosition(position: Int) {
        Defaults().set(position, for: .userPosition)
    }
    
    func generateCrossPositions() {
        crossPositions = []
        if var crossArray = crossPositions {
            while crossArray.count < 3 {
                guard let cells = numberOfCells else { return }
                let number = Int.random(in: 2..<cells)
                if !crossArray.contains(number) {
                    crossArray.append(number)
                }
            }
            crossPositions = crossArray
        }
    }
    
    func loadPreviousGame() {
        guard let cells = numberOfCells, let userPosition = userPosition, let crossPositions = crossPositions else { return }
        presenter?.setUpGameWithInitialValues(cells: cells, userPosition: userPosition, crossPositions: crossPositions, newGame: false)
    }
    
    // change the value of cells that you want in the game.
    func setUpNewGame() {
        numberOfCells = 20
        userPosition = 1
        generateCrossPositions()
        guard let cells = numberOfCells, let userPosition = userPosition, let crossPositions = crossPositions else { return }
        saveGame(cells: cells, userPosition: userPosition, crossPositions: crossPositions)
        presenter?.setUpGameWithInitialValues(cells: cells, userPosition: userPosition, crossPositions: crossPositions, newGame: true)
    }
    
    
    func saveGame(cells: Int, userPosition: Int, crossPositions: [Int]) {
        Defaults().set(crossPositions, for: .crossPositions)
        Defaults().set(userPosition, for: .userPosition)
        Defaults().set(cells, for: .numberOfCells)
    }
    
    func checkForPreviousSavedGame() -> Bool {
        guard let userPosition = Defaults().get(for: .userPosition),
            let crossPositions = Defaults().get(for: .crossPositions),
            let numberOfCells = Defaults().get(for: .numberOfCells) else { return false }
        self.crossPositions = crossPositions
        self.numberOfCells = numberOfCells
        self.userPosition = userPosition
        return true
    }
}
