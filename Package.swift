// swift-tools-version:4.2

// © 2018 J. G. Pusey (see LICENSE.md)

import PackageDescription

let package = Package(name: "XestiPath",
                      products: [.library(name: "XestiPath",
                                          targets: ["XestiPath"])],
                      targets: [.target(name: "XestiPath")])
