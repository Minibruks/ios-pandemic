//
//  Timer.swift
//  vk-job
//
//  Created by Павел on 09.05.2023.
//

import Foundation

class Timer {

    let timeInterval: TimeInterval
    let queue = DispatchQueue(label: Bundle.main.bundleIdentifier! + ".timerQueue", attributes: .concurrent)
    
    let cancelHandler = DispatchWorkItem {
        print("cancel handler")
    }
    
    init(timeInterval: TimeInterval) {
        self.timeInterval = timeInterval
    }
    
    private lazy var timer: DispatchSourceTimer = {
        let t = DispatchSource.makeTimerSource(queue: queue)
        t.schedule(deadline: .now() + self.timeInterval)
        t.setEventHandler(handler: { [weak self] in
//            Thread.sleep(forTimeInterval: 2)
            self?.eventHandler?()
        })
        return t
    }()

    var eventHandler: (() -> Void)?

    private enum State {
        case suspended
        case resumed
    }

    private var state: State = .suspended

    deinit {
        timer.setEventHandler {}
        timer.cancel()
        resume()
        eventHandler = nil
    }

    func resume() {
        if state == .resumed {
            return
        }
        state = .resumed
        timer.resume()
    }

    func suspend() {
        if state == .suspended {
            return
        }
        state = .suspended
        timer.suspend()
    }
}
