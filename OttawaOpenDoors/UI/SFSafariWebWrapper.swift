//
//  SFSafariWebWrapper.swift
//  OttawaOpenDoors
//
//  Created by Serdar Ulutas on 2023-12-11.
//

import Foundation
import SwiftUI
import SafariServices

struct SFSafariViewWrapper: UIViewControllerRepresentable {
    
  let url: URL
    func makeUIViewController(context: UIViewControllerRepresentableContext<Self>) -> SFSafariViewController {
    return SFSafariViewController(url: url)
  }
  
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SFSafariViewWrapper>) {
    return
  }
    
}
