//
//  Path+Components.swift
//  XestiPath
//
//  Created by J. G. Pusey on 2018-11-24.
//
//  © 2018 J. G. Pusey (see LICENSE.md)
//

import Foundation

public extension Path {

    // MARK: Public Initializers

    convenience init(_ components: [String]) {
        self.init(NSString.path(withComponents: components))
    }

    // MARK: Public Instance Properties

    var abbreviatingWithTilde: Path {
        return Path((rawValue as NSString).abbreviatingWithTildeInPath)
    }

    var components: [String] {
        return (rawValue as NSString).pathComponents
    }

    var deletingExtension: Path {
        return Path((rawValue as NSString).deletingPathExtension)
    }

    var deletingLastComponent: Path {
        return Path((rawValue as NSString).deletingLastPathComponent)
    }

    var expandingTilde: Path {
        return Path((rawValue as NSString).expandingTildeInPath)
    }

    var `extension`: String {
        return (rawValue as NSString).pathExtension
    }

    var isAbsolute: Bool {
        return (rawValue as NSString).isAbsolutePath
    }

    var lastComponent: String {
        return (rawValue as NSString).lastPathComponent
    }

    var resolvingSymbolicLinks: Path {
        return Path((rawValue as NSString).resolvingSymlinksInPath)
    }

    var standardizing: Path {
        return Path((rawValue as NSString).standardizingPath)
    }

    // MARK: Public Instance Methods

    func appendingComponent(_ comp: String) -> Path {
        return Path((rawValue as NSString).appendingPathComponent(comp))
    }

    func appendingExtension(_ ext: String) -> Path {
        guard
            let result = (rawValue as NSString).appendingPathExtension(ext)
            else { return self }

        return Path(result)
    }
}
