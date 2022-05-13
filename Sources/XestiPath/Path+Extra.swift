// © 2018–2022 J. G. Pusey (see LICENSE.md)

import Foundation

public extension Path {

    // MARK: Public Type Properties

    static var temporaryDirectory: Path {
        Path(NSTemporaryDirectory())
    }

    static var uniqueTemporaryDirectory: Path {
        temporaryDirectory.appendingComponent(ProcessInfo.processInfo.globallyUniqueString)
    }

    // MARK: Public Type Methods

    static func match(pattern: String) -> [Path] {
        var gt = glob_t()

        defer { globfree(&gt) }

        let flags = GLOB_BRACE | GLOB_MARK | GLOB_TILDE

        guard Darwin.glob(pattern, flags, nil, &gt) == 0
        else { return [] }

        return (0..<Int(gt.gl_matchc)).compactMap {
            guard let rawPath = gt.gl_pathv[$0],
                  let path = String(validatingUTF8: rawPath)
            else { return nil }

            return Path(path)
        }
    }

    // MARK: Public Instance Properties

    var absolute: Path {
        if isAbsolute {
            return standardizing
        }

        let expandedPath = expandingTilde

        if expandedPath.isAbsolute {
            return expandedPath.standardizing
        }

        return (Path.currentDirectory + self).standardizing
    }

    var kind: Kind {
        (try? attributes().kind) ?? .unknown
    }

    // MARK: Public Instance Methods

    func match(pattern: String) -> [Path] {
        Path.match(pattern: (self + Path(pattern)).rawValue)
    }

    func readData(options: Data.ReadingOptions = []) throws -> Data {
        try Data(contentsOf: fileURL,
                 options: options)
    }

    func writeData(_ data: Data,
                   options: Data.WritingOptions = []) throws {
        try data.write(to: fileURL,
                       options: options)
    }
}
