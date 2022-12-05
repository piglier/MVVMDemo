//
//  ViewController.swift
//  MVVMDemo
//
//  Created by PIG on 2022/12/2.
//

import RxSwift
import RxCocoa
import UIKit

class ViewController: UIViewController {
    private var viewModule = ViewModel();
    private var bag = DisposeBag();
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: self.view.frame, style: .insetGrouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(UserTableViewCell.self, forCellReuseIdentifier: "UserTableViewCell")
        return tv
    }()
    
    func bindTableView() {
        tableView.rx.setDelegate(self).disposed(by: bag)
//        viewModule.user.bind(to: tableView.rx.items(cellIdentifier: "UserTableViewCell", cellType: UserTableViewCell.self))
        
        viewModule.user.bind(to: tableView.rx.items(cellIdentifier: "UserTableViewCell", cellType: UserTableViewCell.self)) {(row, item, cell) in
            cell.textLabel?.text = item.title
            cell.detailTextLabel?.text = "\(item.id)"
        }.disposed(by: bag)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        viewModule.fetchUser()
        bindTableView()
    }
}

extension ViewController: UITableViewDelegate {}

class AppError {
    enum ServerError: Error {
        case GetUserError
    }
}

class ViewModel {
    var user = BehaviorSubject(value: [User]())
    
//    func fetchUser() async throws {
//        let url = URL(string: "https://jsonplaceholder.typicode.com/posts");
//        let (data, response) = try await URLSession.shared.data(from: url!)
//        guard let httpReponse = response as? HTTPURLResponse, httpReponse.statusCode == 200 else {
//            throw AppError.ServerError.GetUserError
//        }
//        do {
//            let users = try JSONDecoder().decode([User].self, from: data)
//            self.user.on(.next(users))
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
    
    func fetchUser() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts");
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let data = data {
                do {
                    let users = try JSONDecoder().decode([User].self, from: data);
                    self.user.on(.next(users))
                } catch {
                    print(error.localizedDescription)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}

typealias Users = [User]

struct User: Codable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}
