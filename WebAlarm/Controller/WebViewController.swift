import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    
    
    var webView: WKWebView!
    var urlString: String!
    //    let favUrl: String!
    
    //    lazy var addFavBtn: UIBarButtonItem = {
    //        let btn = UIBarButtonItem(image: UIImage(systemName: "hand.thumbsup"), style: .plain, target: self, action: #selector(addFavBtnPressed))
    //        return btn
    //    }()
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNav()
        
        let myURL = URL(string:urlString)
        let myRequest = URLRequest(url: myURL!)
        DispatchQueue.main.async {
            self.webView.load(myRequest)
        }
        
    }
    func setNav() {
        self.navigationController?.hidesBarsOnSwipe = true
    }
}
    
//    @objc func addFavBtnPressed() {
//        if let url = webView.url {
////            favUrl.favUrl.append(url.absoluteString)
//            print(favUrl.favUrl)
//        }
//    }


//let script = """
//    var metaTags = document.getElementsByTagName('meta');
//    var thumbnailUrl = null;
//    for (var i = 0; i < metaTags.length; i++) {
//        if (metaTags[i].getAttribute('property') == 'og:image' || metaTags[i].getAttribute('name') == 'og:image') {
//            thumbnailUrl = metaTags[i].getAttribute('content');
//            break;
//        }
//    }
//    if (!thumbnailUrl) {
//        var ogImage = document.querySelector('link[rel="image_src"]');
//        if (ogImage != null) {
//            thumbnailUrl = ogImage.getAttribute('href');
//        }
//    }
//    thumbnailUrl;
//"""
//
//webView.evaluateJavaScript(script) { result, error in
//    guard let thumbnailUrl = result as? String else {
//        return
//    }
    // thumbnailUrl을 사용하여 이미지를 다운로드하거나 처리합니다.
//}

class SiteInfoManager {
    func getThumbnail(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        
        // load the URL request in the web view
        let request = URLRequest(url: url)
        webView.load(request)
        
        // script to extract thumbnail image URL from HTML page
        let script = """
             var thumbnailUrl = null;

                // Try to find thumbnail using the Open Graph protocol.
                var metaTags = document.getElementsByTagName('meta');
                for (var i = 0; i < metaTags.length; i++) {
                    if (metaTags[i].getAttribute('property') == 'og:image' || metaTags[i].getAttribute('name') == 'og:image') {
                        thumbnailUrl = metaTags[i].getAttribute('content');
                        break;
                    }
                }

                // If no thumbnail was found, try finding one using the 'image_src' link tag.
                if (thumbnailUrl == null) {
                    var linkTags = document.getElementsByTagName('link');
                    for (var i = 0; i < linkTags.length; i++) {
                        if (linkTags[i].getAttribute('rel') == 'image_src') {
                            thumbnailUrl = linkTags[i].getAttribute('href');
                            break;
                        }
                    }
                }

                // If no thumbnail was found, try finding one in the page header.
                if (thumbnailUrl == null) {
                    var header = document.getElementsByTagName('header')[0];
                    if (header != null) {
                        var headerImages = header.getElementsByTagName('img');
                        if (headerImages.length > 0) {
                            thumbnailUrl = headerImages[0].getAttribute('src');
                        }
                    }
                }

                thumbnailUrl;
        """
        
        // evaluate the script to get the thumbnail image URL
        webView.evaluateJavaScript(script) { result, error in
            print(result)
            guard let thumbnailUrlString = result as? String, let thumbnailUrl = URL(string: thumbnailUrlString) else {
                completion(nil)
                return
            }
            print(thumbnailUrlString)
            // load the thumbnail image data and create UIImage
            URLSession.shared.dataTask(with: thumbnailUrl) { data, response, error in
                guard let data = data, error == nil, let thumbnailImage = UIImage(data: data) else {
                    completion(nil)
                    return
                }
                
                completion(thumbnailImage)
            }.resume()
        }
    }
    
}
