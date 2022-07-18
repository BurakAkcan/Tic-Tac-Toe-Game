//
//  GameViewController.swift
//  Tic-Tac-Toe
//
//  Created by Burak AKCAN on 18.07.2022.
//

import UIKit

class GameViewController: UIViewController {
    
    //MARK: - View Properties
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerScoreLabel: UILabel!
    @IBOutlet weak var computerScoreLabel: UILabel!
    
    @IBOutlet weak var box1: UIImageView!
    @IBOutlet weak var box2: UIImageView!
    @IBOutlet weak var box3: UIImageView!
    @IBOutlet weak var box4: UIImageView!
    @IBOutlet weak var box5: UIImageView!
    @IBOutlet weak var box6: UIImageView!
    @IBOutlet weak var box7: UIImageView!
    @IBOutlet weak var box8: UIImageView!
    @IBOutlet weak var box9: UIImageView!
    
 
    
    //MARK: - Properties
    
    var playerNameText:String!
    var lastValue = "o"
    var playerChoices:[Box] = []
    var computerChoices:[Box] = []
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerName.text = playerNameText
       setUpBorder()
        setTapBox()
    }
    @IBAction func cancelClicked(_ sender: UIButton) {
        let backController = storyboard?.instantiateViewController(withIdentifier: "homeVC") as! ViewController
        backController.modalPresentationStyle = .fullScreen
        present(backController, animated: true)
    }
    
    func computerPlay(){
        var availableSpace = [UIImageView]()
        var availableBoxes = [Box]()
        for name in Box.allCases{
            let box = getBox(from: name.rawValue)
            if box.image == nil {
                availableSpace.append(box)
                availableBoxes.append(name)
            }
        }
        
        guard availableBoxes.count > 0 else{return}
        let randomIndex = Int.random(in: 0..<availableSpace.count)
        makeChoice(availableSpace[randomIndex])
        computerChoices.append(availableBoxes[randomIndex])
        checkIfWon()
    }
    
    //Box name to get box
    //Enum caseIterable protocolu eklersek enum içerisine liste şeklinde erişebiliriz
    enum Box:String,CaseIterable{
        case one,two,three,four,five,six,seven,eight,nine
    }
    
    //Box add gesture
    func createTap(on imageView:UIImageView,type box:Box){
        let tap = UITapGestureRecognizer(target: self, action: #selector(boxClick(_:)))
        tap.name = box.rawValue
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
    }
    @objc func boxClick(_ sender:UITapGestureRecognizer){
        let selectedBox = getBox(from: sender.name!)
        makeChoice(selectedBox)
        playerChoices.append(Box(rawValue: sender.name!)!)
        checkIfWon()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.computerPlay()
        }
    }
    
    func makeChoice(_ selectedBox:UIImageView){
        guard selectedBox.image == nil else{return }
        if lastValue == "x" {
            selectedBox.image = #imageLiteral(resourceName: "ic_circle")
            lastValue = "o"
        }else{
            lastValue = "x"
            selectedBox.image = #imageLiteral(resourceName: "ic_correct.png")
        }
        
        //Check if this winning
    }
    
    func checkIfWon(){
        var correct = [[Box]]()
        let firstRow:[Box] = [.one,.two,.three]
        let secondRow:[Box] = [.four,.five,.six]
        let thirdRow:[Box] = [.seven,.eight,.nine]
        
        let firstCol:[Box] = [.one,.four,.seven]
        let secondCol:[Box] = [.two,.five,.eight]
        let thirdCol:[Box] = [.three,.six,.nine]
        
        let crossFirst:[Box] = [.one,.five,.nine]
        let crossSecond:[Box] = [.three,.five,.seven]
        
        correct.append(firstRow)
        correct.append(secondRow)
        correct.append(thirdRow)
        correct.append(firstCol)
        correct.append(secondCol)
        correct.append(thirdCol)
        correct.append(crossFirst)
        correct.append(crossSecond)
        
        for valid in correct{
            let userMatch = playerChoices.filter { valid.contains($0)}.count
            let computerMatch = computerChoices.filter { valid.contains($0)}.count
            if userMatch == valid.count{
                playerScoreLabel.text = String(Int(playerScoreLabel.text!)! + 1)
                resetGame()
                break
            }else if computerMatch == valid.count{
                computerScoreLabel.text = String(Int(computerScoreLabel.text!)! + 1)
                resetGame()
                break
            }else if computerChoices.count + playerChoices.count == 9 {
                resetGame()
                break
            }
        }
    }
    func resetGame(){
        for name in Box.allCases{
            let box = getBox(from: name.rawValue)
            box.image = nil
                
        }
        lastValue = "o"
        playerChoices = []
        computerChoices = []
        
    }
    
    func getBox(from name:String)->UIImageView{
        let box = Box(rawValue: name) ?? .one
        switch box {
        case .one:
            return box1
        case .two:
            return box2
        case .three:
            return box3
        case .four:
            return box4
        case .five:
            return box5
        case .six:
            return box6
        case .seven:
            return box7
        case .eight:
            return box8
        case .nine:
            return box9
   }
    }
}
extension GameViewController{
    func setUpBorder(){
        box1.layer.borderWidth = 1
        box1.layer.borderColor = UIColor.systemGray.cgColor
        box2.layer.borderWidth = 1
        box2.layer.borderColor = UIColor.systemGray.cgColor
        box3.layer.borderWidth = 1
        box3.layer.borderColor = UIColor.systemGray.cgColor
        box4.layer.borderWidth = 1
        box4.layer.borderColor = UIColor.systemGray.cgColor
        box5.layer.borderWidth = 1
        box5.layer.borderColor = UIColor.systemGray.cgColor
        box6.layer.borderWidth = 1
        box6.layer.borderColor = UIColor.systemGray.cgColor
        box7.layer.borderWidth = 1
        box7.layer.borderColor = UIColor.systemGray.cgColor
        box8.layer.borderWidth = 1
        box8.layer.borderColor = UIColor.systemGray.cgColor
        box9.layer.borderWidth = 1
        box9.layer.borderColor = UIColor.systemGray.cgColor
        
    }
    
    func setTapBox(){
        createTap(on: box1, type: Box.one)
        createTap(on: box2, type: .two)
        createTap(on: box3, type: Box.three)
        createTap(on: box4, type: Box.four)
        createTap(on: box5, type: Box.five)
        createTap(on: box6, type: Box.six)
        createTap(on: box7, type: Box.seven)
        createTap(on: box8, type: Box.eight)
        createTap(on: box9, type: Box.nine)
        
       
    }
}
