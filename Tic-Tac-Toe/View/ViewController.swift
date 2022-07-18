//
//  ViewController.swift
//  Tic-Tac-Toe
//
//  Created by Burak AKCAN on 18.07.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var startButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    @IBAction func clickedButtn(_ sender:UIButton){
        guard !txtField.text!.trimmingCharacters(in: .whitespaces).isEmpty else{
            
                let alert = UIAlertController(title: "Error", message: "Please fill player name field", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
             present(alert, animated: true)
            
            return
            
        }
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "GameVC") as! GameViewController
        
        
        controller.playerNameText = txtField.text
        //open screen animate
        controller.modalTransitionStyle = .flipHorizontal
        //To make Full screen
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
    }
   
    
    func setUpUI(){
        startButton.layer.cornerRadius = 10
        cardView.layer.cornerRadius = 10
        cardView.layer.shadowOpacity = 0.7
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowRadius = 10
        cardView.layer.shadowOffset = .zero
        
        txtField.clearButtonMode = .always
        txtField.clearButtonMode = .whileEditing
        
        
    }
    // Txtfield içinden herhangi bir yere basınca çıksın diye yazarız bu fonk.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        txtField.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? GameViewController{
            controller.playerNameText = txtField.text
        }
    }
    
    //Segue gerçekleşmeden önce bazı şyleri kontrol etmek istiyorsak bu metodu kullanırız
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "goGame"{
            if txtField.text!.trimmingCharacters(in: .whitespaces).isEmpty{
                let alert = UIAlertController(title: "Error", message: "Please fill player name field", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
                present(alert, animated: true)
                return false
            }
        }
        return true
    }


}

