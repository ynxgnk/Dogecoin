//
//  DogeTableViewCell.swift
//  Dogecoin
//
//  Created by Nazar Kopeyka on 22.04.2023.
//

import UIKit

struct DogeTableViewCellViewModel { /* 118 */
    let title: String /* 119 */
    let value: String /* 119 */
}

class DogeTableViewCell: UITableViewCell { /* 109 */
    static let identifier = "DogeTableViewCell" /* 110 */
    
    private let label: UILabel = { /* 120 */
       let label = UILabel() /* 121 */
        
        return label /* 122 */
    }()
    
    private let valueLabel: UILabel = { /* 123 */
       let label = UILabel() /* 124 */
        label.textAlignment = .right /* 126 */
        return label /* 125 */
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) { /* 111 */
        super.init(style: style, reuseIdentifier: reuseIdentifier) /* 112 */
        contentView.addSubview(label) /* 127 */
        contentView.addSubview(valueLabel) /* 128 */
    }
    
    required init?(coder: NSCoder) { /* 113 */
        fatalError() /* 114 */
    }
    
    override func layoutSubviews() { /* 115 */
        super.layoutSubviews() /* 116 */
        label.sizeToFit() /* 129 */
        valueLabel.sizeToFit() /* 130 */
        label.frame = CGRect(x: 15, y: 0, width: label.frame.size.width, height: contentView.frame.size.height) /* 131 */
        valueLabel.frame = CGRect(x: contentView.frame.size.width - 15 - valueLabel.frame.size.width,
                                  y: 0,
                                  width: valueLabel.frame.size.width,
                                  height: contentView.frame.size.height) /* 132 */
    }
    
    func configure(with viewModel: DogeTableViewCellViewModel) { /* 117 */
        label.text = viewModel.title /* 133 */
        valueLabel.text = viewModel.value /* 134 */
    }

}
