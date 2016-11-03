platform :ios, '9.3'

target 'CLVisitExplorer' do
  use_frameworks!

  # Swift 3 conversions
  pod 'SafeRealmObject', git: 'git@github.com:phatblat/RBQSafeRealmObject.git', branch: 'swift-3'
    # path: '../pods/RBQSafeRealmObject'
  pod 'RBQSafeRealmObject', git: 'git@github.com:phatblat/RBQSafeRealmObject.git', branch: 'swift-3'
    # path: '../pods/RBQSafeRealmObject'
  pod 'RBQFetchedResultsController', git: 'git@github.com:phatblat/RBQFetchedResultsController.git', branch: 'swift-3'
    # path: '../pods/RBQFetchedResultsController'
  pod 'SwiftFetchedResultsController', git: 'git@github.com:phatblat/RBQFetchedResultsController.git', branch: 'swift-3'
    # path: '../pods/RBQFetchedResultsController'

  pod 'RealmMapView'

  pod 'Realm'       # , git: 'git@github.com:realm/realm-cocoa.git', branch: 'master', submodules: true
  pod 'RealmSwift'  # , git: 'git@github.com:realm/realm-cocoa.git', branch: 'master', submodules: true

  target 'CLVisitExplorerTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'CLVisitExplorerUITests' do
    inherit! :search_paths
    # Pods for testing
  end
end
