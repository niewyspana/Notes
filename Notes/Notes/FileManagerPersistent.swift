//
//  FileManagerPersistent.swift
//  Notes
//
//  Created by Viki on 20/01/2024.
//

import Foundation
import UIKit

final class FileManagerPersistent {
    
    static func save(_ image: UIImage, with name: String) -> URL? {
        let data = image.jpegData(compressionQuality: 1)
        let url = getDocumentDirectory().appendingPathComponent(name)
        
        do {
            try data?.write(to: url)
            print("Image was saved")
            return url
        } catch {
            print("Saving image error: \(error)")
            return nil
        }
    }
    
    static func read(from url: URL) -> UIImage? {
        UIImage(contentsOfFile: url.path)
    }
    
    static func delete(from url: URL) {
        do {
            try FileManager.default.removeItem(at: url)
            print("Image was deleted")
        } catch {
            print("Deleting image error: \(error)")
        }
    }
    
    private static func getDocumentDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
