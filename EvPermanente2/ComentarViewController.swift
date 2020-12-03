//
//  ComentarViewController.swift
//  EvPermanente2
//
//  Created by Axel Salvatierra on 12/2/20.
//

import UIKit

class ComentarViewController: UIViewController {
    
    @IBAction func clickBtnBack(_ sender: Any){
        
        self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var txtComentario: UITextField!
    @IBOutlet weak var tblCommentView: UITableView!
    //let modelComment = CommentDataModel.shareInstance
    //var modelSocialFeed = SocialFeedModel()
    //var arrComments = [CommentModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /*override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       arrComments = modelComment.arrComments.filter{ $0.socialFeedID == modelSocialFeed.id }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
     txtComentario.becomeFirstResponder()
    }
    
    @IBAction func btnSendTapped(_ sender: UIButton) {
        let modelData = CommentModel(socialFeedID: modelSocialFeed.id, commentID: "\(modelComment.arrComments.count + 1)", title: txtComentario.text!)
        modelComment.arrComments.append(modelData)
        arrComments.append(modelData)
        tblCommentView.reloadData()
        txtComentario.resignFirstResponder()
    }
}

extension ComentarViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrComments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = arrComments[indexPath.row].title
        return cell
    }
}


struct SocialFeedModel {
    var id = ""
    var title = ""
    var media = [MediaModel]()
}

struct MediaModel{
    var mediaType: MediaType?
    var thumbnail = UIImage()
    var url = ""
}

enum MediaType{
    case photo, video
}

struct CommentModel{
    var socialFeedID = ""
    var commentID = ""
    var title = ""
}

class CommentDataModel{
    static let shareInstance = CommentDataModel()
    var arrComments = [CommentModel]()
}*/

}
