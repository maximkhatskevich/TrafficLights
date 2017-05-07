repoName = 'TrafficLights'
projectName = 'Main' # aka "staging"
# projectName_rc = 'RC'
# projectName_appStore = 'AppStore'

#===

platform :ios, '9.0'

workspace repoName

use_frameworks!

#===

def sharedPods

    pod 'XCEUniFlow', '~> 3.2'

    pod 'MKHState', :git => 'https://github.com/maximkhatskevich/MKHState.git'
    pod 'MKHViewEvents', :git => 'https://github.com/maximkhatskevich/MKHViewEvents.git'

    #===
    
    pod 'R.swift'
    pod 'SteviaLayout', '~> 3.0'
    pod 'SwiftyTimer', '~> 2.0'
    
end

#===

target 'App' do

	project projectName

	#===

	sharedPods

    #===

    pod 'Reveal-SDK', :configurations => ['Debug']

end

target 'Tests' do

    project projectName

    #===

    sharedPods
    
    #===
    
    pod 'XCETesting', '~> 1.1'

end
