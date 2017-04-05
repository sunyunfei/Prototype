

import UIKit

class NewsWebVC: BaseVC {

    var newModel:NewsModel?
    var webView:UIWebView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = newModel?.title
        webView = UIWebView.init(frame: CGRect(x:0,y:0,width:self.view.frame.size.width,height:self.view.frame.size.height))
        self.view.addSubview(webView!)
        
        //加载网页数据
        let url = NSURL(string:(newModel?.url)!)
        let request = NSURLRequest(url:url as! URL)
        webView?.loadRequest(request as URLRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
