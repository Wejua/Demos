//
//  CollectionBatchDeleteView.swift
//  YYVideo
//
//  Created by zhouweijie on 2019/9/28.
//  Copyright © 2019 com.yiyuan. All rights reserved.
//

import UIKit

protocol BatchDeleteEntity {
    func setSelectState(isSelected: Bool)
    func getSelectState() -> Bool
}

///底部带有“全选”按钮和“删除”按钮,上边是tableView，继承这个view就能获得批量删除功能
class CollectionBatchDeleteView<M: MyCollectionBaseModel, C: YYBaseTableViewCell<M>>: UIView, UITableViewDelegate, TableViewBatchDeleteBottomBarDelegate {
    //MARK: - lazy properties
    private(set) lazy var tableV: YYTableView<M, C> = {
        let requester = YYShangPinRequester(currentPage: 1)
        let tableV = YYTableView<M, C>(frame: .zero, style: .plain, requester: requester)
        tableV.delegate = self
        tableV.allowsMultipleSelectionDuringEditing = true
        tableV.didDequeueCellBlock = {[weak self] model, cell, indexPath, tableView in
            if model.isSelected {
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: UITableView.ScrollPosition.none)
            } else {
                tableView.deselectRow(at: indexPath, animated: false)
            }
        }
        return tableV
    }()
    
    ///编辑按钮
    private(set) lazy var editButton: YYTitleBarButton = {
        let button = YYTitleBarButton()
        button.setTitleColor(UIColor(hex: "#666666"), for: .normal)
        button.titleLabel?.font = UIFont(name: "PingFangHK-Medium", size: 16)
        button.setTitle("编辑", for: .normal)
        button.setTitle("取消", for: .selected)
        button.addTarget(self, action: #selector(didClickEidtButton(button:)), for: .touchUpInside)
        return button
    }()
    
    ///底部全选和删除按钮
    private(set) lazy var bottomBatchBar: TableViewBatchDeleteBottomBar = {
        let view = TableViewBatchDeleteBottomBar()
        view.isHidden = true
        view.delegate = self
        return view
    }()

    //MARK: -private functions
    @objc private func didClickEidtButton(button: UIButton) {
        button.isSelected = !button.isSelected
        let constant = button.isSelected ? bottomBarHeight : 0
        self.bottomBatchBar.heightConstraint?.constant = constant
        if constant == 0 {
            bottomBatchBar.isHidden = true
        } else {
            bottomBatchBar.isHidden = false
        }
        tableV.setEditing(button.isSelected, animated: true)
        if button.isSelected == false {
            //已经选中的实体恢复未选中状态，刷新tableView
            tableV.model?.rows?.forEach({ (entity) in
                entity.setSelectState(isSelected: false)
            })
            tableV.reloadData()
            //全选按钮和删除按钮恢复为初始状态
            bottomBatchBar.batchSelectB.isSelected = false
            bottomBatchBar.deleteB.isSelected = false
        }
    }
    
    //MARK: - life functions
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(tableV)
        self.addSubview(bottomBatchBar)
        
        tableV.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableV.topAnchor.constraint(equalTo: self.topAnchor),
            tableV.leftAnchor.constraint(equalTo: self.leftAnchor),
            tableV.bottomAnchor.constraint(equalTo: self.bottomBatchBar.topAnchor),
            tableV.rightAnchor.constraint(equalTo: self.rightAnchor),
            ])
        bottomBatchBar.translatesAutoresizingMaskIntoConstraints = false
        bottomBatchBar.heightConstraint = bottomBatchBar.heightAnchor.constraint(equalToConstant: 0)
        NSLayoutConstraint.activate([
            bottomBatchBar.leftAnchor.constraint(equalTo: tableV.leftAnchor, constant: 0),
            bottomBatchBar.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            bottomBatchBar.rightAnchor.constraint(equalTo: tableV.rightAnchor, constant: 0),
            bottomBatchBar.heightConstraint!,
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - public functions
    
    //MARK: - other properties
    let bottomBarHeight: CGFloat = YYScreenH >= 812 ? 84 : 50
    
    var didDeleteModel: ((M) -> Void)?
  
    //MARK: - Delegates
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableV.model?.rows?[indexPath.row].isSelected = true
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableV.model?.rows?[indexPath.row].isSelected = false
    }
    
    func TableViewBatchDeleteBottomBarDidClickDeleteButton(button: UIButton) {
        guard var tempList = tableV.model?.rows else {return}
        button.isSelected = !button.isSelected
        //全选按钮恢复未选状态
        bottomBatchBar.batchSelectB.isSelected = false
        //删除所有已经选中的实体，更新tableView
        tempList.removeAll { (go) -> Bool in
            if go.getSelectState() == true {
                didDeleteModel?(go)
                return true
            } else {
                return false
            }
        }
        tableV.model?.rows = tempList
        tableV.reloadData()
    }
    
    func TableViewBatchDeleteBottomBarDidClickBatchSelectButton(button: UIButton) {
        guard let tempList = tableV.model?.rows else {return}
        button.isSelected = !button.isSelected
        //选中状态在实体里标记
        for goods in tempList {
            goods.setSelectState(isSelected: button.isSelected)
        }
        //刷新tabview，更新cell状态
        tableV.reloadData()
    }
}
