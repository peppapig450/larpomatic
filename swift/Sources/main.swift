import Foundation
import AVFoundation

@available(macOS 14.0, iOS 15.0, *)
func fetchMetadata(from url: URL) async {
    let asset = AVAsset(url: url)
    do {
        for format in try await asset.load(.availableMetadataFormats) {
            let metadataItems = try await asset.loadMetadata(for: format)
            for item in metadataItems {
                if let key = item.commonKey?.rawValue {
                    let value = item.value as? String ?? "N/A"
                    print("Key: \(key), Value: \(value)")
                }
            }
        }
    } catch {
        print("Error loading metadata: \(error)")
    }
}

@available(macOS 14.0, iOS 15.0, *)
@main
struct Main {
    static func main() async {
        let arguments = CommandLine.arguments
        guard arguments.count == 2 else {
            print("Usage: \(arguments[0]) <path to video file>")
            return
        }

        let filePath = arguments[1]
        guard FileManager.default.fileExists(atPath: filePath) else {
            print("File not found at: \(filePath)")
            return
        }

        let videoURL = URL(filePath: filePath)
        await fetchMetadata(from: videoURL)
    }
}
