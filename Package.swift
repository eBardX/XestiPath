// swift-tools-version:5.8

// © 2018–2023 J. G. Pusey (see LICENSE.md)

import PackageDescription

let package = Package(name: "XestiPath",
                      platforms: [.iOS(.v14),
                                  .macOS(.v11)],
                      products: [.library(name: "XestiPath",
                                          targets: ["XestiPath"])],
                      targets: [.target(name: "XestiPath")],
                      swiftLanguageVersions: [.version("5")])
