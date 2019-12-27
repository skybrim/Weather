# Uncomment the next line to define a global platform for your project
platform :ios, '12.2'

source 'https://github.com/CocoaPods/Specs.git'

target 'Util' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Util

  target 'UtilTests' do
    # Pods for testing
  end

end

target 'Weather' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Weather
  pod 'Alamofire', '~> 5.0.0-rc.3'
  pod 'RxBlocking', '~> 5'
  pod 'RxTest', '~> 5'
  
  target 'WeatherTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'RxBlocking', '~> 5'
    pod 'RxTest', '~> 5'
  end

  target 'WeatherUITests' do
    # Pods for testing
  end

end
