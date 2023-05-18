//
//  ViewController.swift
//  Dogecoin
//
//  Created by Nazar Kopeyka on 22.04.2023.
//

import UIKit

//UI
//MVVM
//API Call
//Pull Refresh

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource { /* 20 add 2 protocols */
    
    private let tableView: UITableView = { /* 10 */
        let table = UITableView(frame: .zero, style: .grouped) /* 11 */
        table.register(DogeTableViewCell.self, /* 135 change UITableViewCell */
                       forCellReuseIdentifier: DogeTableViewCell.identifier) /* 12 */ /* 136 change "cell" */
        return table /* 13 */
    }()
    
    private var viewModels = [DogeTableViewCellViewModel]() /* 141 */
    
    static let formatter: NumberFormatter = { /* 101 */
       let formatter = NumberFormatter() /* 102 */
        formatter.locale = .current /* 103 */
        formatter.numberStyle = .currency /* 104 */
        return formatter /* 105 */
    }()
    
    static let dateFormatter: ISO8601DateFormatter = { /* 152 */
        let formatter = ISO8601DateFormatter() /* 160 */
        formatter.formatOptions = .withFractionalSeconds /* 163 */
        formatter.timeZone = .current /* 161 */
        return formatter /* 162 */
    }()
    
    static let prettyDateFormatter: DateFormatter = { /* 155 */
       let formatter = DateFormatter() /* 156 */
        formatter.locale = .current /* 164 */
        formatter.timeZone = .current /* 165 */
        formatter.dateStyle = .medium /* 157 */
        return formatter /* 158 */
    }()
    
    private var data: DogeCoinData? /* 86 */
    
    override func viewDidLoad() {
        title = "DogeCoin" /* 14 */
        super.viewDidLoad() /* 18 */
//        setUpTable() /* 30 */
        fetchData() /* 78 */
    }
    
    override func viewDidLayoutSubviews() { /* 19 */
        super.viewDidLayoutSubviews() /* 21 */
        tableView.frame = view.bounds /* 22 */
    }
    
    private func fetchData() { /* 71 */
        APICaller.shared.getDogeCoinData { [weak self] result in /* 72 */ /* 85 add weak self */
            switch result { /* 73 */
            case .success(let data): /* 74 */
                self?.data = data /* 87 */
                DispatchQueue.main.async { /* 88 */
                    self?.setUpViewModels() /* 90 */
                }
//                print("Success \(data)") /* 75 */
            case .failure(let error): /* 76 */
                print(error) /* 77 */
            }
        }
    }
    
    private func setUpViewModels() { /* 89 */
        guard let model = data else { /* 144 */
            return /* 145 */
        }
//        createTableHeader() /* 90 */
        
        guard let date = Self.dateFormatter.date(from: model.date_added) else { /* 153 */
            return /* 154 */
        }
        
        //Create VMs
        viewModels = [ /* 146 */
            DogeTableViewCellViewModel(
                title: "Name",
                value: model.name
            ), /* 147 */
            
            DogeTableViewCellViewModel(
                title: "Symbol",
                value: model.symbol
            ), /* 148 */
            
            DogeTableViewCellViewModel(
                title: "Identifier",
                value: String(model.id)
            ), /* 149 */
            
            DogeTableViewCellViewModel(
                title: "Date Added",
                value: Self.prettyDateFormatter.string(from: date) /* 159 change mode.date_added */
            ), /* 150 */
            
            DogeTableViewCellViewModel(
                title: "Total Supply",
                value: String(model.total_supply)
            ), /* 151 */
        ]
        
        setUpTable() /* 100 */
    }
    
    private func setUpTable() { /* 29 */
        view.addSubview(tableView) /* 15 */
        tableView.delegate = self /* 16 */
        tableView.dataSource = self /* 17 */
        createTableHeader() /* 32 */
    }
    
    private func createTableHeader() { /* 31 */
//        print("creating header") /* 99 */
        guard let price = data?.quote["USD"]?.price else { /* 91 */
         return /* 92 */
        }
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width/1.5)) /* 33 */
        header.clipsToBounds = true /* 34 */
        
        //Image
        let imageView = UIImageView(image: UIImage(named: "dogecoin")) /* 35 */
        imageView.contentMode = .scaleAspectFit /* 37 */
        let size: CGFloat = view.frame.size.width/4 /* 38 */
        imageView.frame = CGRect(x: (view.frame.size.width-size)/2, y: 10, width: size, height: size) /* 39 */
        header.addSubview(imageView) /* 40 */
        
        //Price label
        let number = NSNumber(value: price) /* 106 */
        let string = Self.formatter.string(from: number) /* 107  Self because its static */
        
        
        let label = UILabel() /* 93 */
        label.text = string /* 94 */ /* 108 change "\(price)" */
        label.textAlignment = .center /* 95 */
        label.font = .systemFont(ofSize: 42, weight: .medium) /* 96 */
        label.frame = CGRect(x: 10, y: 20+size, width: view.frame.size.width-20, height: 200) /* 97 */
        header.addSubview(label) /* 98 */
        
        tableView.tableHeaderView = header /* 36 */
    }
    
    //Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { /* 23 */
        return viewModels.count /* 24 */ /* 143 change 10 */
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { /* 25 */
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: DogeTableViewCell.identifier, /* 138 change "cell" */
            for: indexPath
        ) as? DogeTableViewCell else { /* 26 */ /* 137 add guard */ /* 139 add as? */
            fatalError() /* 140 */
        }
        cell.configure(with: viewModels[indexPath.row]) /* 142 */
//        cell.textLabel?.text = "Dogecoin" /* 27 */
        return cell /* 28 */
    }


}

