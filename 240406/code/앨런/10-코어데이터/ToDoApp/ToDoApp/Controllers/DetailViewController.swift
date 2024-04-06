//
//  DetailViewController.swift
//  ToDoApp
//
//  Created by Youngbin Choi on 4/6/24.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var purpleButton: UIButton!
    
    // 버튼 묶어서 편하게 사용하기
    lazy var buttons: [UIButton] = [redButton, greenButton, blueButton, purpleButton]
    
    @IBOutlet weak var mainTextView: UITextView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    
    let coreDataManger = CoreDataManager.shared
    
    var toDoData: ToDoData? {
        didSet {
            tempColorNum = toDoData?.color
        }
    }
    
    var tempColorNum: Int64? = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureUI()
    }
    
    func setup() {
        mainTextView.delegate = self
        
        backgroundView.clipsToBounds = true
        backgroundView.layer.cornerRadius = 10
        
        saveButton.clipsToBounds = true
        saveButton.layer.cornerRadius = 8
        clearButtonColors()
    }
    
    func configureUI() {
        // 기존 데이터가 있을 때
        if let toDoData = toDoData {
            title = "메모 수정하기"
            mainTextView.text = toDoData.memoText
            mainTextView.textColor = .black
            saveButton.setTitle("UPDATE", for: .normal)
            mainTextView.becomeFirstResponder()
            let color = MyColor(rawValue: toDoData.color)
            setupColorTheme(color: color)
        
        // 기존 데이터가 없을 때
        } else {
            title = "새로운 메모 생성하기"
            mainTextView.text = "텍스트를 입력하세요"
            mainTextView.textColor = .lightGray
            setupColorTheme()
        }
        setupColorButton(num: tempColorNum ?? 1)
    }
    
    // 버튼 둥글게 깍기 위한 정확한 시점
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // 모든 버튼에 설정 변경
        buttons.forEach { button in
            button.clipsToBounds = true
            button.layer.cornerRadius = button.bounds.height / 2
        }
    }
    @IBAction func colorButtonTapped(_ sender: UIButton) {
        tempColorNum = Int64(sender.tag)
        
        let color = MyColor(rawValue: Int64(sender.tag))
        setupColorTheme(color: color)
        
        clearButtonColors()
        setupColorButton(num: Int64(sender.tag))
    }
    
    
    // 텍스트뷰, 저장버튼 컬러 적용
    func setupColorTheme(color: MyColor? = .red) {
        backgroundView.backgroundColor = color?.backgoundColor
        saveButton.backgroundColor = color?.buttonColor
    }
    
    // 버튼 색상 새롭게 셋팅
    func clearButtonColors() {
        redButton.backgroundColor = MyColor.red.backgoundColor
        redButton.setTitleColor(MyColor.red.buttonColor, for: .normal)
        greenButton.backgroundColor = MyColor.green.backgoundColor
        greenButton.setTitleColor(MyColor.green.buttonColor, for: .normal)
        blueButton.backgroundColor = MyColor.blue.backgoundColor
        blueButton.setTitleColor(MyColor.blue.buttonColor, for: .normal)
        purpleButton.backgroundColor = MyColor.purple.backgoundColor
        purpleButton.setTitleColor(MyColor.purple.buttonColor, for: .normal)
    }
    
    // 눌려진 버튼 색상 설정
    func setupColorButton(num: Int64) {
        switch num {
        case 1:
            redButton.backgroundColor = MyColor.red.buttonColor
            redButton.setTitleColor(.white, for: .normal)
        case 2:
            greenButton.backgroundColor = MyColor.green.buttonColor
            greenButton.setTitleColor(.white, for: .normal)
        case 3:
            blueButton.backgroundColor = MyColor.blue.buttonColor
            blueButton.setTitleColor(.white, for: .normal)
        case 4:
            purpleButton.backgroundColor = MyColor.purple.buttonColor
            purpleButton.setTitleColor(.white, for: .normal)
        default:
            redButton.backgroundColor = MyColor.red.buttonColor
            redButton.setTitleColor(.white, for: .normal)
        }
    }
    
    @IBAction func saveButtonTapper(_ sender: Any) {
        
        // 업데이트
        if let toDoData = toDoData {
            toDoData.memoText = mainTextView.text
            toDoData.color = tempColorNum ?? 1
            coreDataManger.updateToDo(newToDoData: toDoData) {
                print("업데이트 완료")
                navigationController?.popViewController(animated: true)
            }
        // 새로 만들기
        } else {
            let memoText = mainTextView.text
            coreDataManger.saveToDoData(toToText: memoText, colorInt: tempColorNum ?? 1) {
                print("저장 완료")
                navigationController?.popViewController(animated: true)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

extension DetailViewController : UITextViewDelegate {
    // 입력을 시작할때
    // (텍스트뷰는 플레이스홀더가 따로 있지 않아서, 플레이스 홀더처럼 동작하도록 직접 구현)
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "텍스트를 입력하세요" {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    // 입력이 끝났을때
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "텍스트를 여기에 입력하세요."
            textView.textColor = .lightGray
        }
    }
}



