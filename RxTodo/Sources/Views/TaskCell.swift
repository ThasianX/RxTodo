//
//  TaskCell.swift
//  RxTodo
//
//  Created by Suyeol Jeon on 7/1/16.
//  Copyright © 2016 Suyeol Jeon. All rights reserved.
//

import UIKit

import ReactorKit

final class TaskCell: BaseTableViewCell, View {
    typealias Reactor = TaskCellReactor
    
    // MARK: Constants
    
    struct Constant {
        static let titleLabelNumberOfLines = 0
    }
    
    struct Metric {
        static let cellPadding = 4.f
    }
    
    struct Font {
        static let titleLabel = UIFont.systemFont(ofSize: 14)
        static let descriptionLabel = UIFont.systemFont(ofSize: 10)
    }
    
    struct Color {
        static let titleLabelText = UIColor.black
        static let descriptionLabelText = UIColor.lightGray
    }
    
    
    // MARK: UI
    
    let titleLabel = UILabel().then {
        $0.font = Font.titleLabel
        $0.textColor = Color.titleLabelText
        $0.numberOfLines = Constant.titleLabelNumberOfLines
    }
    
    let descriptionLabel = UILabel().then {
        $0.font = Font.descriptionLabel
        $0.textColor = Color.descriptionLabelText
        $0.numberOfLines = Constant.titleLabelNumberOfLines
    }
    
    
    // MARK: Initializing
    
    // 1 - After this cell is created, its superclass does whatever it needs to then delegates back down to the overriden initialize() method of this class
    override func initialize() {
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.descriptionLabel)
    }
    
    
    // MARK: Binding
    
    // 3 - Called when the tableview is loading its datasource. The datasource holds an array of TaskCellReactors, which are then passed to their respective TaskCells, and used to set/change the titleLabel or checked state of the cell
    func bind(reactor: Reactor) {
        self.titleLabel.text = reactor.currentState.title
        self.descriptionLabel.text = reactor.currentState.description
        self.accessoryType = reactor.currentState.isDone ? .checkmark : .none
    }
    
    
    // MARK: Layout
    
    // 2 - Called right after the titleLabel is added to the contentView. Programmatically sets constraints to to the titleLabel of the cell
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let marginGuide = self.contentView.layoutMarginsGuide
        
        //        self.titleLabel.top = Metric.cellPadding
        //        self.titleLabel.left = Metric.cellPadding
        //        self.titleLabel.width = self.contentView.width - Metric.cellPadding * 2
        //        self.titleLabel.sizeToFit()
        
        //Setting constraints for title label first since it's at the top
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.titleLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        
        self.titleLabel.topAnchor.constraint(lessThanOrEqualTo: marginGuide.topAnchor).isActive = true
        
        self.titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        
        //Setting constraints for the description label next
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metric.cellPadding).isActive = true
        
        self.descriptionLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        
        self.descriptionLabel.trailingAnchor.constraint(equalTo:
            marginGuide.trailingAnchor).isActive = true
        
        self.descriptionLabel.bottomAnchor.constraint(greaterThanOrEqualTo: marginGuide.bottomAnchor, constant: 4).isActive = true
        
    }
    
    
    // MARK: Cell Height
//
//    class func height(fits width: CGFloat, reactor: Reactor) -> CGFloat {
//        let height =  reactor.currentState.title.height(
//            fits: width - Metric.cellPadding * 2,
//            font: Font.titleLabel,
//            maximumNumberOfLines: Constant.titleLabelNumberOfLines
//        )
//
//        return height + Metric.cellPadding * 2
//    }
    
}
