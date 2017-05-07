import XCEProjectGenerator

//===

let My =
(
    repoName: "TrafficLights",
    deploymentTarget: "9.0",
    companyIdentifier: "com.SafetyCulture"
//    developmentTeamId: "XYZ"
    
//    provProfDev: "TrafficLights-Dev",
//    provProfAdHoc: "TrafficLights-AdHoc"
)

let BundleId =
(
    app: "\(My.companyIdentifier).\(My.repoName)",
    tst: "\(My.companyIdentifier).\(My.repoName).Tst"
)

//===

let specFormat = Spec.Format.v1_3_0

let project = Project("Main") { p in
    
    p.configurations.all.override(
        
        "IPHONEOS_DEPLOYMENT_TARGET" <<< My.deploymentTarget, // Struct bug wokraround
        
//        "DEVELOPMENT_TEAM" <<< My.developmentTeamId,
        
        "SWIFT_VERSION" <<< "3.0",
        "VERSIONING_SYSTEM" <<< "apple-generic",
        
        "CURRENT_PROJECT_VERSION" <<< "1" // just a default non-empty value
        
    )
    
    p.configurations.debug.override(
        
        "SWIFT_OPTIMIZATION_LEVEL" <<< "-Onone"
    )
    
    p.configurations.release.override(
        
        "DEBUG_INFORMATION_FORMAT" <<< "dwarf-with-dsym",
        "SWIFT_OPTIMIZATION_LEVEL" <<< "-Owholemodule"
    )
    
    //---
    
    p.target("App", .iOS, .app) { t in
        
        t.include("Src", "Res")
        
        //---
        
        t.configurations.all.override(
            
            "PRODUCT_NAME" <<< My.repoName,
            
            // intentionally repeat again, Struct bug wokraround
            "IPHONEOS_DEPLOYMENT_TARGET" <<< My.deploymentTarget,
            
            "PRODUCT_BUNDLE_IDENTIFIER" <<< BundleId.app,
            "INFOPLIST_FILE" <<< "Info/App.plist",
            
            "ASSETCATALOG_COMPILER_APPICON_NAME" <<< t.name,
            
            //--- iOS related:
            
            "SDKROOT" <<< "iphoneos",
            "TARGETED_DEVICE_FAMILY" <<< DeviceFamily.iOS.phone
        )
        
        t.configurations.debug.override(
            
//            "CODE_SIGN_IDENTITY[sdk=iphoneos*]" <<< "iPhone Developer",
//            "PROVISIONING_PROFILE_SPECIFIER" <<< My.provProfDev,
            
            //---
            
            "MTL_ENABLE_DEBUG_INFO" <<< true
        )
        
        t.configurations.release.override(
            
//            "CODE_SIGN_IDENTITY[sdk=iphoneos*]" <<< "iPhone Distribution",
//            "PROVISIONING_PROFILE_SPECIFIER" <<< My.provProfAdHoc
        )
        
        //---
    
        t.unitTests { ut in
            
            ut.include("Tst")
            
            //---
            
            ut.configurations.all.override(
               
                // intentionally repeat again, Struct bug wokraround
                "IPHONEOS_DEPLOYMENT_TARGET" <<< My.deploymentTarget,
                
                "PRODUCT_BUNDLE_IDENTIFIER" <<< BundleId.tst,
                "INFOPLIST_FILE" <<< "Info/Tst.plist"
            )
            
            ut.configurations.debug.override(
                
                "MTL_ENABLE_DEBUG_INFO" <<< true
            )
        }
    }
}
