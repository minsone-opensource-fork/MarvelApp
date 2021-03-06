import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(name: "Marvel",
                      targets: [
                          Target(name: "App",
                                 platform: .iOS,
                                 product: .app,
                                 bundleId: "com.julian.marvel",
                                 deploymentTarget: .defaultDeployment,
                                 infoPlist: "Config/App.plist",
                                 sources: ["Sources/**"],
                                 resources: ["Resources/**"],
                                 actions: [.swiftformat, .swiftlint],
                                 dependencies: [.injection, .displayKit, .marvelAPI]),
                          Target(name: "Tests",
                                 platform: .iOS,
                                 product: .unitTests,
                                 bundleId: "com.julian.marvel-tests",
                                 deploymentTarget: .defaultDeployment,
                                 infoPlist: .default,
                                 sources: ["Tests/**"],
                                 resources: ["Tests/Resources/**"],
                                 dependencies: [.target(name: "App"), .nimble, .httpStubs])
                      ])
