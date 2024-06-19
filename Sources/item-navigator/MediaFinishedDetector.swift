import Foundation
import AVFoundation

public class MediaFinishedDetector: ObservableObject {
  private var mediaFinished: () -> Void = {}

  public init() {
    NotificationCenter.default.addObserver(
        self,
        selector: #selector(onAVPlayerItemDidPlayToEndTime),
        name: .AVPlayerItemDidPlayToEndTime,
        object: nil
    )
  }

public func onMediaFinished(_ mediaFinished: @escaping () -> Void) {
    self.mediaFinished = mediaFinished
  }

  @objc func onAVPlayerItemDidPlayToEndTime() {
    mediaFinished()
  }
}
