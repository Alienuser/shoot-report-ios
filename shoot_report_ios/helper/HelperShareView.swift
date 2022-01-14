import SwiftUI
import PhotosUI

struct HelperShareView: UIViewControllerRepresentable {
    
    @Binding var shareViewResult: [NSURL]
    @Binding var isPresented: Bool
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
      
        let controller = UIActivityViewController(activityItems: shareViewResult, applicationActivities: nil)
        
        return controller
        
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
}

