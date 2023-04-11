//
//  PhotoCollectionViewCell.swift
//  ImageExample_MVP
//
//  Created by SHIN YOON AH on 2023/04/11.
//

import UIKit

final class PhotoCollectionViewCell: UICollectionViewCell {

    static let identifier = "PhotoCollectionViewCell"

    // MARK: - ui component

    @IBOutlet weak var photoImageView: UIImageView!


    // MARK: - func

    func configureCell(imageURL: String) {
        self.photoImageView.loadImageUrl(imageURL)
    }
}

private extension UIImageView {
    func loadImageUrl(_ url: String) {
        DispatchQueue.global(qos: .background).async {
            guard let url = URL(string: url) else { return }
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else { return }
                let image = UIImage(data: data)!
                DispatchQueue.main.async {
                    self.image = image
                }
            }.resume()
        }
    }
}
