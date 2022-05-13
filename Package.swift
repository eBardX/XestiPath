// swift-tools-version:5.6

// © 2018–2022 J. G. Pusey (see LICENSE.md)

import PackageDescription

let package = Package(name: "XestiPath",
                      platforms: [.macOS(.v11)],
                      products: [.library(name: "XestiPath",
                                          targets: ["XestiPath"])],
                      targets: [.target(name: "XestiPath")],
                      swiftLanguageVersions: [.version("5")])
