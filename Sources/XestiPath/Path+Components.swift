// © 2018–2022 J. G. Pusey (see LICENSE.md)

import Foundation

public extension Path {

    // MARK: Public Initializers

    convenience init(_ components: [String]) {
        self.init(NSString.path(withComponents: components))
    }

    // MARK: Public Instance Properties

    var abbreviatingWithTilde: Path {
        Path((rawValue as NSString).abbreviatingWithTildeInPath)
    }

    var components: [String] {
        (rawValue as NSString).pathComponents
    }

    var deletingExtension: Path {
        Path((rawValue as NSString).deletingPathExtension)
    }

    var deletingLastComponent: Path {
        Path((rawValue as NSString).deletingLastPathComponent)
    }

    var expandingTilde: Path {
        Path((rawValue as NSString).expandingTildeInPath)
    }

    var `extension`: String {
        (rawValue as NSString).pathExtension
    }

    var isAbsolute: Bool {
        (rawValue as NSString).isAbsolutePath
    }

    var lastComponent: String {
        (rawValue as NSString).lastPathComponent
    }

    var resolvingSymbolicLinks: Path {
        Path((rawValue as NSString).resolvingSymlinksInPath)
    }

    var standardizing: Path {
        Path((rawValue as NSString).standardizingPath)
    }

    // MARK: Public Instance Methods

    func appendingComponent(_ comp: String) -> Path {
        Path((rawValue as NSString).appendingPathComponent(comp))
    }

    func appendingExtension(_ ext: String) -> Path {
        guard let result = (rawValue as NSString).appendingPathExtension(ext)
        else { return self }

        return Path(result)
    }
}
