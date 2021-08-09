# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'tmpr' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'SDWebImage'
  pod 'Alamofire'
  pod 'RappleProgressHUD'
  pod 'RxSwift'
  pod 'RxCocoa'

  # RxTest and RxBlocking make the most sense in the context of unit/integration tests
  target 'tmprTests' do
    inherit! :search_paths
    pod 'RxBlocking'
    pod 'RxTest'
  end

  target 'tmprUITests' do
    # Pods for testing
  end

end
