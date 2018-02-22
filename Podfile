source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

# ignore all warnings from all pods
inhibit_all_warnings!

target 'shachouApp' do
    # HTTPクライアントライブラリ
    pod 'Alamofire', '~> 4.0'
    # 画像取得ライブラリ
    pod 'Kingfisher'
    # JSONパーサ
    pod 'SwiftyJSON'

    # AutoLayoutのライブラリ
    pod 'SnapKit'

    pod 'DKImagePickerController'

    # テキスト入力していくと大きくなるTextViewのライブラリ
    pod 'GrowingTextView'

    # UserDefaults
    pod 'SwiftyUserDefaults'

  end

  target 'shachouAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'shachouAppUITests' do
    inherit! :search_paths
    # Pods for testing
  end
