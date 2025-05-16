# Uncomment the next line to define a global platform for your project
platform :ios, '16.0'

workspace 'GamersHub'

target 'GamersHub' do
  use_frameworks!
  pod 'Alamofire'

  # Pods for GamersHub

  target 'GamersHubTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'GamesFoundation' do
    inherit! :search_paths
    project './GamesFoundation/GamesFoundation'
    pod 'Alamofire'
    # Pods for testing
  end

target 'About' do
    inherit! :search_paths
    project './About/About'
  end

target 'Saved' do
    inherit! :search_paths
    project './Saved/Saved'
  end

target 'Home' do
    inherit! :search_paths
    project './Home/Home'
  end

target 'Detail' do
    inherit! :search_paths
    project './Detail/Detail'
  end

target 'Shared' do
    inherit! :search_paths
    project './Shared/Shared'
  end

  target 'GamersHubUITests' do
    # Pods for testing
  end

  target 'GamersHubUnitTests' do
    inherit! :search_paths
    # Pods for testing
  end

end