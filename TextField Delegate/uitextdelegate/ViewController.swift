//
//  ViewController.swift
//  uitextdelegate
//
//  Created by Danielle Nozaki Ogawa on 04/04/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var cpfTextField: UITextField!
    @IBOutlet weak var telefoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nomeTextField.delegate = self
        cpfTextField.delegate = self
        telefoneTextField.delegate = self
        emailTextField.delegate = self
        nomeTextField.clearButtonMode = .always
        cpfTextField.clearButtonMode = .always
        telefoneTextField.clearButtonMode = .always
        emailTextField.clearButtonMode = .always
        nomeTextField.becomeFirstResponder()
    }
    
    func contemValor(text: String?) -> Bool {
        if let valor = text, !valor.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    func verificaTelefone(_ tel: String?) -> Bool {
        if contemValor(text: tel){
            let telRegex = "[0-9]{11,}"
            let validaTel = NSPredicate(format: "SELF MATCHES %@", telRegex)
            return validaTel.evaluate(with: tel)
        } else {
            return false
        }
    }
    
    func verificaNome(_ nome: String?) -> Bool {
        if contemValor(text: nome) {
            return true
        } else {
            return false
        }
    }

    func verificaCPF(_ cpf: String?) -> Bool {
        if contemValor(text: cpf){
            //regras que definir regras, regex = analisa textos {range de tamanho}
            let cpfRegex = "[0-9]{11,}"
            //analisar, predicato = forma do swift analisar o texto
            let validaCPF = NSPredicate(format: "SELF MATCHES %@", cpfRegex)
            return validaCPF.evaluate(with: cpf)//validar o texto
        } else {
            return false
        }
    }
    
    
    func verificaEmail(_ email: String?) -> Bool {
        if contemValor(text: email) && (email ?? "").contains("@") {
            return true
        } else {
            return false
        }
    }
    
    func exibirErroNome(){
        if verificaNome(nomeTextField.text) == false {
            nomeTextField.layer.borderWidth = 1
            nomeTextField.layer.borderColor = UIColor.red.cgColor
        } else {
            nomeTextField.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    func exebirErroCpf() {
        if verificaCPF(cpfTextField.text) == false {
            cpfTextField.layer.borderWidth = 1
            cpfTextField.layer.borderColor = UIColor.red.cgColor
        } else {
            cpfTextField.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    func exebirErroTelefone() {
        if verificaTelefone(telefoneTextField.text) == false {
            telefoneTextField.layer.borderWidth = 1
            telefoneTextField.layer.borderColor = UIColor.red.cgColor
        } else {
            telefoneTextField.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    func exibirErroEmail() {
        if verificaEmail(emailTextField.text) == false {
            emailTextField.layer.borderWidth = 1
            emailTextField.layer.borderColor = UIColor.red.cgColor
        } else {
            emailTextField.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    func verificaDadosAlerta(){
        exibirErroNome()
        exebirErroCpf()
        exebirErroTelefone()
        exibirErroEmail()
    }
    
    @IBAction func cadastrarButton(_ sender: UIButton) {
        verificaDadosAlerta()
    }
}

extension ViewController: UITextFieldDelegate {
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 2 {
            return verificaNome(nomeTextField.text)
        }
        if textField.tag == 3{
            return verificaCPF(cpfTextField.text)
        }
        if textField.tag == 4 {
//            verificaEmail(emailTextField.text)
            return verificaTelefone(telefoneTextField.text) 
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 1 {
            exibirErroNome()
        }
        if textField.tag == 2 {
            exebirErroCpf()
        }
        if textField.tag == 3 {
            exebirErroTelefone()
        }
        if textField.tag == 4 {
            exibirErroEmail()
        }
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if nomeTextField.text != nil {
            return true
        }
        if cpfTextField.text != nil {
            return true
        }
        if cpfTextField.text != nil {
            return true
        }
        if emailTextField.text != nil {
            return true
        }
        return true
    }
}

