// swift-tools-version:5.2

// © 2018–2020 J. G. Pusey (see LICENSE.md)

import PackageDescription

let package = Package(name: "XestiPath",
                      platforms: [.macOS(.v10_15)],
                      products: [.library(name: "XestiPath",
                                          targets: ["XestiPath"])],
                      targets: [.target(name: "XestiPath")],
                      swiftLanguageVersions: [.version("5")])
