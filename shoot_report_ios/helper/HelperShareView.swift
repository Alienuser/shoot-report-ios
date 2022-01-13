import SwiftUI
import PhotosUI

struct HelperShareView: UIViewControllerRepresentable {
    
    @Binding var shareViewResult: [NSURL]
    @Binding var isPresented: Bool
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        
        /*let fileManager = FileManager.default
        let sharePath = try! fileManager.url(for: .documentDirectory, in: .allDomainsMask, appropriateFor: nil, create: false)
        let shareURL = sharePath.appendingPathComponent("CSVRec.csv")
        let NSShareURL = NSURL.fileURL(withPath: shareURL.absoluteString)
        print("shareURL:")
        print(NSShareURL)*/
        
        
        let controller = UIActivityViewController(activityItems: shareViewResult, applicationActivities: nil)
        
        //self.shareViewResult = []
        //self.shareViewResult.append(shareViewResult as NSURL)
        
        //self.isPresented = false
        
        return controller
        
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
}

