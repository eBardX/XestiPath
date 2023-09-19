// swift-tools-version:5.9

// © 2018–2023 J. G. Pusey (see LICENSE.md)

import PackageDescription

let swiftSettings: [SwiftSetting] = [.enableUpcomingFeature("BareSlashRegexLiterals"),
                                     .enableUpcomingFeature("ConciseMagicFile"),
                                     .enableUpcomingFeature("ExistentialAny"),
                                     .enableUpcomingFeature("ForwardTrailingClosures"),
                                     .enableUpcomingFeature("ImplicitOpenExistentials")]

let package = Package(name: "XestiPath",
                      platforms: [.iOS(.v14),
                                  .macOS(.v11)],
                      products: [.library(name: "XestiPath",
                                          targets: ["XestiPath"])],
                      targets: [.target(name: "XestiPath",
                                        swiftSettings: swiftSettings)],
                      swiftLanguageVersions: [.version("5")])
