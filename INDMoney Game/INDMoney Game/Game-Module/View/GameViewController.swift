//
//  GameViewController.swift
//  INDMoney Game
//
//  Created by Vivek Singh Mehta on 21/09/22.
//  
//

import UIKit

final class GameViewController: UIViewController {

    // MARK: - Properties
    var presenter: ViewToPresenterGameProtocol?
    
    //MARK: - Views
    private lazy var gameCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset =  UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft
        collectionView.register(GameCollectionViewCell.self, forCellWithReuseIdentifier: GameCollectionViewCell.reuseIdentifier)
        return collectionView
    }()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Board Game"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var buttonTitle: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Roll"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private lazy var diceImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "game_die")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var rollButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(rollTheDice(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var rollDiceView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        return view
    }()
    
    //MARK: - Properties
    private var numberOfCells: Int = 20
    private var userPosition: Int = 1
    private var crossPositions: [Int] = []
    
    //MARK: - Constraints
    private var rollDiceViewWidthConstraint: NSLayoutConstraint!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        addDelegates()
        presenter?.setUpGame()
    }
    
    fileprivate func setUpViews() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(buttonTitle)
        NSLayoutConstraint.activate([
            buttonTitle.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -10),
            buttonTitle.leadingAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(diceImageView)
        NSLayoutConstraint.activate([
            diceImageView.centerYAnchor.constraint(equalTo: buttonTitle.centerYAnchor),
            diceImageView.trailingAnchor.constraint(equalTo: buttonTitle.leadingAnchor, constant: -8),
            diceImageView.heightAnchor.constraint(equalToConstant: 30),
            diceImageView.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        view.addSubview(rollButton)
        NSLayoutConstraint.activate([
            rollButton.leadingAnchor.constraint(equalTo: diceImageView.leadingAnchor, constant: -20),
            rollButton.trailingAnchor.constraint(equalTo: buttonTitle.trailingAnchor, constant: 20),
            rollButton.heightAnchor.constraint(equalToConstant: 50),
            rollButton.centerYAnchor.constraint(equalTo: buttonTitle.centerYAnchor)
        ])
        
        view.insertSubview(rollDiceView, belowSubview: buttonTitle)
        rollDiceViewWidthConstraint = rollDiceView.widthAnchor.constraint(equalTo: rollButton.widthAnchor)
        NSLayoutConstraint.activate([
            rollDiceView.bottomAnchor.constraint(equalTo: rollButton.bottomAnchor),
            rollDiceView.heightAnchor.constraint(equalTo: rollButton.heightAnchor),
            rollDiceView.centerXAnchor.constraint(equalTo: rollButton.centerXAnchor),
            rollDiceViewWidthConstraint
        ])
        
        view.addSubview(gameCollectionView)
        NSLayoutConstraint.activate([
            gameCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            gameCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gameCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gameCollectionView.bottomAnchor.constraint(equalTo: rollButton.topAnchor, constant: -10)
        ])
        
        //To invert the collection view
        gameCollectionView.transform = CGAffineTransform.init(rotationAngle: (-(CGFloat)(Double.pi)))
    }
    
    fileprivate func addDelegates() {
        gameCollectionView.delegate = self
        gameCollectionView.dataSource = self
        gameCollectionView.reloadData()
    }
    
   @objc fileprivate func rollTheDice(_ sender: UIButton) {
       presenter?.rollTheDice()
    }
    
    fileprivate func animateTheButton(with number: Int) {
        UIView.animate(withDuration: 1.0, delay: 0, options: [.autoreverse, .repeat, .curveEaseInOut]) {
            self.buttonTitle.text = "You got \(number)"
            self.rollButton.isEnabled = false
        } completion: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.revertBackAnimation()
            }
        }
    }
    
    fileprivate func revertBackAnimation() {
        UIView.animate(withDuration: 1.0, delay: 0, options: [.curveEaseInOut]) {
            self.rollButton.isEnabled = true
            self.buttonTitle.text = "Roll"
        }
    }
    
    fileprivate func showNewGameAlert(_ action: UIAlertAction) {
        self.showAlertWithYesHandler(type: .actionSheet, title: "You finished the game.", message: "Do you want to start a new game ?") { [weak self] action in
            guard let weakself = self else { return }
            weakself.presenter?.startNewGame()
        }
    }
    
}

extension GameViewController: PresenterToViewGameProtocol {
    
    func takeUserTo1stCell() {
        userPosition = 1
        gameCollectionView.reloadData()
        self.showAlertWithOk(Title: "😱 Ohh No !!!", message: "You landed on 1st cross you have start from 1st position")
        gameCollectionView.scrollToItem(at: IndexPath(row: userPosition, section: 0), at: .bottom, animated: true)
    }
    
    func userLandedOnCross(position: Int) {
        userPosition = position
        gameCollectionView.reloadData()
        self.showAlertWithOk(Title: "😨 Ohh No !!!", message: "You landed on a cross")
        gameCollectionView.scrollToItem(at: IndexPath(row: userPosition, section: 0), at: .top, animated: true)
    }
    
    
    func moveTheUser(newPosition: Int, rollNumber: Int) {
        userPosition = newPosition
        animateTheButton(with: rollNumber)
        gameCollectionView.reloadData()
        gameCollectionView.scrollToItem(at: IndexPath(row: userPosition, section: 0), at: .bottom, animated: true)
    }
    
    func finishedTheGame(with number: Int) {
        // TODO: - show the rolled dice number to the user
        userPosition = numberOfCells
        animateTheButton(with: number)
        gameCollectionView.reloadData()
        gameCollectionView.scrollToItem(at: IndexPath(row: userPosition - 1, section: 0), at: .top, animated: true)
        self.showAlertWithOneHandler(title: " 🥳 Congratulations !!!", message: "You Completed the game", handler: showNewGameAlert(_:))
    }
    
    func setUpGameWithInitialValues(cells: Int, userPosition: Int, crossPositions: [Int], newGame: Bool) {
        self.numberOfCells = cells
        self.userPosition = userPosition
        self.crossPositions = crossPositions
        gameCollectionView.reloadData()
        if userPosition == 20 {
            gameCollectionView.scrollToItem(at: IndexPath(row: userPosition - 1, section: 0), at: .top, animated: true)
        } else {
            gameCollectionView.scrollToItem(at: IndexPath(row: userPosition - 1, section: 0), at: .bottom, animated: true)
        }
    }
    
    
}

extension GameViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: - number of cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCells
    }
    
    
    //MARK: - cell at perticular index
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCollectionViewCell.reuseIdentifier, for: indexPath) as? GameCollectionViewCell else { return UICollectionViewCell() }
        cell.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        cell.setNumberlabel(number: indexPath.row + 1)
        let cellNumber = indexPath.row + 1
        if crossPositions.contains(cellNumber) {
            cell.addCross()
        } else {
            cell.removeCross()
        }
        if cellNumber == userPosition {
            cell.addSmily()
        } else {
            cell.removeSmily()
        }
        return cell
    }
    
    //MARK: - height of the cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (view.bounds.width / 3) - 10
        let height: CGFloat = width
        return CGSize(width: width, height: height)
    }
    
}
