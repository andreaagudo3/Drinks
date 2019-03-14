//
//  ImageManager.swift
//  Drinks
//
//  Created by Andrea Agudo on 13/03/2019.
//  Copyright © 2019 aagudo. All rights reserved.
//

import Nuke

struct ImageManager {

    // On older versions this name was defined internally by Nuke,
    // now that we must define it, if we don't want the people to clear the entire image caching
    // when they update the app, we must set the same data cache name that it used to be when internally managed.
    static internal let dataCacheName = "com.github.kean.Nuke.DataCache"

    static let loadingOptions: ImageLoadingOptions = {
        var loadingOptions = ImageLoadingOptions.shared
        loadingOptions.pipeline = ImageManager.pipeline
        return loadingOptions
    }()

    static let pipeline = ImagePipeline {
        $0.imageCache = ImageCache.shared
        $0.dataLoader = DataLoader(configuration: {
            // Disable disk caching built into URLSession
            let conf = DataLoader.defaultConfiguration
            conf.urlCache = nil
            return conf
        }())

        $0.dataLoadingQueue.maxConcurrentOperationCount = 6
        $0.imageDecodingQueue.maxConcurrentOperationCount = 1
        $0.imageProcessingQueue.maxConcurrentOperationCount = 2

        $0.isDeduplicationEnabled = false
        $0.isProgressiveDecodingEnabled = false
    }

    @discardableResult
    static func loadImage(with url: URL, options: ImageLoadingOptions = ImageManager.loadingOptions, into view: ImageDisplayingView, progress: ImageTask.ProgressHandler? = nil, completion: ImageTask.Completion? = nil) -> ImageTask? {
        ImagePipeline.Configuration.isAnimatedImageDataEnabled = true
        var options = options
        options.pipeline = pipeline
        return Nuke.loadImage(with: url, options: options, into: view, progress: progress, completion: completion)
    }

    static func downloadImage(from url: URL) {
        var request = ImageRequest(url: url)
        request.processor = nil
        request.memoryCacheOptions.isWriteAllowed = true

        func prefetchImage(for request: ImageRequest) {
            pipeline.loadImage(with: request) { (response, _) in
                if response == nil {
                    // Retry after 10 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(10)) {
                        prefetchImage(for: request)
                    }
                }
            }
        }
    }

    static func refreshCurrentImage(withCachedData data: Data, url: URL, completion: (() -> Void)? = nil) {
        ImageCache.shared.removeResponse(
            for: ImageRequest(
                url: url
            )
        )
        completion?()
    }
}
