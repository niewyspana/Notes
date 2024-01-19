//
//  NoteViewController.swift
//  Notes
//
//  Created by Viki on 14/01/2024.
//

import SnapKit
import UIKit

final class NoteViewController: UIViewController {
    
    // MARK: GUI variables
    
    private let attachmentView: UIImageView = {
        let view = UIImageView()
        
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    private let textView: UITextView = {
        let view = UITextView()
        
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.lightGray.cgColor
        
        return view
    }()
    
    
    // MARk: - Properties
    var viewModel: NoteViewModelProtocol?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    // MARK: - Methods
    
    
    private func configure() {
        textView.text = viewModel?.text
        //   guard let imageData = note.image, let image = UIImage(data:
        // imageData) else { return }
        //  attachmentView.image = image
    }
    
    // MARK: - Private methods
    
    @objc
    private func saveAction() {
        viewModel?.save(with: textView.text)
        navigationController?.popViewController(animated: true)
        updateBarButtonItems()
    }
    
    @objc
    private func deleteAction() {
        viewModel?.delete()
        navigationController?.popViewController(animated: true)
        updateBarButtonItems()
    }
    
    private func setupUI() {
        view.addSubview(attachmentView)
        view.addSubview(textView)
        view.backgroundColor = .white
        
        textView.delegate = self
        
        let recogniser = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(recogniser)
        
        textView.layer.borderWidth = textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 1 : 0
        
        setupConstraints()
        setImageHeight()
        setupBars()
        updateBarButtonItems()
    }
    
    private func setupConstraints() {
        attachmentView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(attachmentView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(-10)
        }
    }
    
    private func setImageHeight() {
        let height = attachmentView.image != nil ? 200 : 0
        
        attachmentView.snp.makeConstraints { make in
            make.height.equalTo(height)
        }
    }
    
    @objc
    private func hideKeyboard() {
        textView.resignFirstResponder()
    }
    
    private func setupBars() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAction))
        
        let addImageButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addImageAction))
        let categoryButton = UIBarButtonItem(title: "Category", style: .plain, target: self, action: #selector(selectCategoryAction))
        
        setToolbarItems([addImageButton, categoryButton], animated: true)
    }
    
    @objc
    private func addImageAction() {
        print("Add Image Button Pressed")
    }
    
    @objc
    private func selectCategoryAction() {
        print("Select Category Button Pressed")
    }
    
    private func updateBarButtonItems() {
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAction))
        navigationItem.rightBarButtonItem = saveButton
        saveButton.isEnabled = viewModel?.hasChanges ?? false
        
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteAction))
        
        if viewModel?.isNewNote == true {
            navigationItem.leftBarButtonItem = nil
        } else {
            navigationItem.leftBarButtonItem = deleteButton
        }
    }
}

extension NoteViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        updateBarButtonItems()
    }
}
