//
//  ViewController.swift
//  TableViewCell Height Animation Demo
//
//  Created by zhouweijie on 2019/4/29.
//  Copyright © 2019 zhouweijie. All rights reserved.
//

import UIKit

class CellModel: NSObject {
    enum CellState {
        case Default
        case Panning
        case Dismissing
    }
    
    var state: CellState = .Default
}

class ViewController: UIViewController {

    var models = [CellModel]()
    
    @IBOutlet weak var tableView: UITableView!
    
    var moveUpDelay = 1.5
    
    var subcribeImageToCircleDelay = 0.1
    
    var animationTime = 0.4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 0
        tableView.register(UINib(nibName: "AnimatingCell", bundle: nil), forCellReuseIdentifier: "AnimatingCell")
        
        for _ in 0..<10 {
            models.append(CellModel())
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimatingCell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = models[indexPath.row]
        switch model.state {
        case .Default:
            return 100
        case .Panning:
            return 50
        case .Dismissing:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! AnimatingCell
        UIView.animate(withDuration: 0.2, animations: {
            cell.subscribe.layer.cornerRadius = 9
            var subF = cell.subscribe.frame
            subF.size = CGSize(width: 18, height: 18)
            cell.subscribe.frame = subF
        }) { (complete) in
            if complete {
                self.moveToLeftAnimation(cell: cell, indexPath: indexPath)
            }
        }
        
    }
    
    func moveToLeftAnimation(cell: AnimatingCell, indexPath: IndexPath) {
        var successF = cell.success.frame
        successF.origin.x = 43
        cell.success.frame = successF
        
        DispatchQueue.main.asyncAfter(deadline: .now() + self.subcribeImageToCircleDelay, execute: {//使用这行代码，使beginUpdates+endUpdates延时生效
            UIView.animate(withDuration: self.animationTime, delay: 0, options: [], animations: {
                
                var subF = cell.subscribe.frame
                subF.origin.x = 15
                subF.origin.y -= 25
                cell.subscribe.frame = subF
                
                var columF = cell.colum.frame
                columF.origin.y -= 25
                cell.colum.frame = columF
                cell.colum.alpha = 0
                
                var descriF = cell.descriptionLabel.frame
                descriF.origin.y -= 25
                cell.descriptionLabel.frame = descriF
                cell.descriptionLabel.alpha = 0
                
                var avatarF = cell.avatar.frame
                avatarF.origin.y -= 25
                cell.avatar.frame = avatarF
                cell.avatar.alpha = 0
                
                var successF = cell.success.frame
                successF.origin.y -= 25
                cell.success.frame = successF
                cell.success.alpha = 1
                
                var separatorF = cell.separator.frame
                separatorF.origin.y -= 50
                cell.separator.frame = separatorF
                //更新cell高度
                let model = self.models[indexPath.row]
                model.state = .Panning
                self.tableView.beginUpdates()
                cell.shouldNotLayout = true
                self.tableView.endUpdates()
                cell.shouldNotLayout = false
                
            }, completion: { (complete) in
                if complete {
                    var subF = cell.subscribe.frame
                    subF.origin.x = 15
                    cell.subscribe.frame = subF
                    
                    self.moveUpToDisappear(cell: cell, index: indexPath)
                }
            })
        })
    }
    
    func moveUpToDisappear(cell: AnimatingCell, index: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + self.moveUpDelay, execute: {//使用这行代码，使延时生效
            UIView.animate(withDuration: self.animationTime, delay: 0, options: [], animations: {
                var successF = cell.success.frame
                successF.origin.y -= 50
                cell.success.frame = successF
                cell.success.alpha = 0
                
                var subF = cell.subscribe.frame
                subF.origin.y -= 50
                cell.subscribe.frame = subF
                cell.subscribe.alpha = 0
                
                var separatorF = cell.separator.frame
                separatorF.origin.y -= 50
                cell.separator.frame = separatorF
                //更新cell高度
                self.tableView.performBatchUpdates({
                    let model = self.models[index.row]
                    model.state = .Dismissing
                    cell.shouldNotLayout = true
                }, completion: { (complete) in
                    cell.shouldNotLayout = false
                })
                
            }, completion: { (complete) in
                if complete {
                    self.tableView.performBatchUpdates({
                        self.models.remove(at: index.row)
                        self.tableView.deleteRows(at: [index], with: UITableView.RowAnimation.none)
                    }, completion: { (complete) in
                        
                    })
                }
            })
        })
    }
}

