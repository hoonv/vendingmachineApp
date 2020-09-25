//
//  MessageView.swift
//  VendingMachineApp
//
//  Created by 채훈기 on 2020/09/21.
//  Copyright © 2020 채훈기. All rights reserved.
//

import UIKit

class MessageView: UIView {

    private var myTableView: UITableView!
    private let bgColor = UIColor.systemGray5
    private let cornerRadius: CGFloat = 20
    private var messages: [Message] = [] // 분리 해야함
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        setupSelfView()
        setupHeader()
        setupTextField()
        setupTableView()
    }

    override func layoutSubviews() {
        myTableView.separatorStyle = .none
    }
    
    private func setupSelfView() {
        backgroundColor = bgColor
        layer.cornerRadius = cornerRadius
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = cornerRadius / 2
    }
    
    private func setupTableView() {
        myTableView = UITableView(frame: CGRect(x: 0, y: 50, width: frame.width, height: 480))
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.rowHeight = UITableView.automaticDimension
        myTableView.estimatedRowHeight = 44.0
        
        let revNibName = UINib(nibName: "YellowTableViewCell", bundle: nil)
        let sendNibName = UINib(nibName: "BlueTableViewCell", bundle: nil)
        myTableView.register(revNibName, forCellReuseIdentifier: "YellowTableViewCell")
        myTableView.register(sendNibName, forCellReuseIdentifier: "BlueTableViewCell")
        addSubview(myTableView)
    }
        
    private func setupTextField() {
        let width = frame.width
        let height = frame.height
        let chatTextField = UITextField(frame: CGRect(x: 20, y: height - 45, width: width - 40, height: 30))
        chatTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: chatTextField.frame.height))
        
        chatTextField.leftViewMode = .always
        chatTextField.backgroundColor = .white
        chatTextField.layer.cornerRadius = 15
        chatTextField.placeholder = "Message"

        chatTextField.delegate = self
        
        addSubview(chatTextField)
    }
    
    private func setupHeader() {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: 50))

        header.layer.cornerRadius = cornerRadius
        header.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        header.clipsToBounds = true
        header.backgroundColor = bgColor

        addSubview(header)
    }
    
    private func scrollLastOfTableView() {
      // First figure out how many sections there are
      let lastSectionIndex = self.myTableView.numberOfSections - 1
      // Then grab the number of rows in the last section
      let lastRowInLastSection = self.myTableView.numberOfRows(inSection: lastSectionIndex) - 1
      let indexPath = IndexPath(row: lastRowInLastSection, section: lastSectionIndex)
      self.myTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
}

extension MessageView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        messages.append(Message(sender: .user, text: textField.text ?? ""))
        messages.append(Message(sender: .system, text: textField.text ?? ""))
        textField.text = ""
        textField.endEditing(true)
        //로직 분리 필요
        myTableView.reloadData()
        scrollLastOfTableView()
        return true
    }
}

extension MessageView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if messages[indexPath.row].isUser() {
            let cell = tableView.dequeueReusableCell(withIdentifier: "YellowTableViewCell") as? YellowTableViewCell ?? YellowTableViewCell()
            cell.message.text = messages[indexPath.row].text
            return cell

        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BlueTableViewCell") as? BlueTableViewCell ?? BlueTableViewCell()
            cell.message.text = messages[indexPath.row].text
            return cell
        }
    }
}
