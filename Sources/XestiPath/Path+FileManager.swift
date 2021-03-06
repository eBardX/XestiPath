// © 2018 J. G. Pusey (see LICENSE.md)

import Foundation

public extension Path {

    // MARK: Public Type Properties

    static var currentDirectory: Path {
        get { return .init(Path.fileManager.currentDirectoryPath) }
        set { Path.fileManager.changeCurrentDirectoryPath(newValue.rawValue) }
    }

    // MARK: Public Instance Properties

    var componentsToDisplay: [String]? {
        return Path.fileManager.componentsToDisplay(forPath: rawValue)
    }

    var displayName: String {
        return Path.fileManager.displayName(atPath: rawValue)
    }

    var exists: Bool {
        return Path.fileManager.fileExists(atPath: rawValue)
    }

    var isDeletable: Bool {
        return Path.fileManager.isDeletableFile(atPath: rawValue)
    }

    var isExecutable: Bool {
        return Path.fileManager.isExecutableFile(atPath: rawValue)
    }

    var isReadable: Bool {
        return Path.fileManager.isReadableFile(atPath: rawValue)
    }

    var isWritable: Bool {
        return Path.fileManager.isWritableFile(atPath: rawValue)
    }

    // MARK: Public Instance Methods

    func attributes() throws -> Attributes {
        return .init(try Path.fileManager.attributesOfItem(atPath: rawValue))
    }

    func copy(to destination: Path) throws {
        try Path.fileManager.copyItem(at: fileURL,
                                      to: destination.fileURL)
    }

    func createDirectory(withIntermediateDirectories createIntermediates: Bool = true,
                         attributes: Attributes? = nil) throws {
        try Path.fileManager.createDirectory(at: fileURL,
                                             withIntermediateDirectories: createIntermediates,
                                             attributes: attributes?.dictionaryRepresentation)
    }

    func createFile(contents: Data? = nil,
                    attributes: Attributes? = nil) -> Bool {
        return Path.fileManager.createFile(atPath: rawValue,
                                           contents: contents,
                                           attributes: attributes?.dictionaryRepresentation)
    }

    func createSymbolicLink(to destination: Path) throws {
        try Path.fileManager.createSymbolicLink(at: fileURL,
                                                withDestinationURL: destination.fileURL)
    }

    func destinationOfSymbolicLink() throws -> Path {
        let dstPath = Path(try Path.fileManager.destinationOfSymbolicLink(atPath: rawValue))

        if dstPath.isAbsolute {
            return dstPath
        } else {
            return appendingComponent("..") + dstPath
        }
    }

    func link(to destination: Path) throws {
        try Path.fileManager.linkItem(at: fileURL,
                                      to: destination.fileURL)
    }

    func move(to destination: Path) throws {
        try Path.fileManager.moveItem(at: fileURL,
                                      to: destination.fileURL)
    }

    func remove() throws {
        try Path.fileManager.removeItem(at: fileURL)
    }

    func setAttributes(_ attributes: Attributes) throws {
        try Path.fileManager.setAttributes(attributes.dictionaryRepresentation,
                                           ofItemAtPath: rawValue)
    }

    // MARK: Private Type Properties

    private static var fileManager: FileManager = .default
}
