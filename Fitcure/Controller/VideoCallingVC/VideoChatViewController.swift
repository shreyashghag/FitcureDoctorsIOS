import UIKit
import AgoraRtcKit

class VideoChatViewController: UIViewController {
    let appID = "58e55b92295e4c3db91f27c6668de7d1"
    var agoraKit: AgoraRtcEngineKit?
    let tempToken: String? = nil
    var userID: UInt = 0
    var userName: String? = nil
    var channelName = "default"
    var remoteUserIDs: [UInt] = []
    
    @IBOutlet weak var localVideo: UIView!
    @IBOutlet weak var remoteVideo: UIView!
    @IBOutlet weak var remoteVideoMutedIndicator: UIImageView!
    @IBOutlet weak var localVideoMutedIndicator: UIView!
    @IBOutlet weak var micButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    
    //weak var logVC: LogViewController?
    
    
    var muted = false {
        didSet {
            if muted {
                micButton.isSelected = true
            } else {
                micButton.isSelected = false
            }
        }
    }
    
    var isRemoteVideoRender: Bool = true {
        didSet {
            remoteVideoMutedIndicator.isHidden = isRemoteVideoRender
            remoteVideo.isHidden = !isRemoteVideoRender
        }
    }
    
    var isLocalVideoRender: Bool = false {
        didSet {
            localVideoMutedIndicator.isHidden = isLocalVideoRender
        }
    }
    
    var isStartCalling: Bool = true {
        didSet {
            if isStartCalling {
                micButton.isSelected = false
            }
            micButton.isHidden = !isStartCalling
            cameraButton.isHidden = !isStartCalling
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(onPatientCallDenied), name: .callCanceled, object: nil)
        setUpVideo()
        joinChannel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            NotificationCenter.default.removeObserver(self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let identifier = segue.identifier else {
//            return
//        }
        
//        if identifier == "EmbedLogViewController",
//            let vc = segue.destination as? LogViewController {
//            self.logVC = vc
//        }
    }
    
    func setUpVideo() {
        getAgoraEngine().enableVideo()
        
        let videoCanvas = AgoraRtcVideoCanvas()
        videoCanvas.uid = userID
        videoCanvas.view = localVideo
        videoCanvas.renderMode = .fit
        getAgoraEngine().setupLocalVideo(videoCanvas)
    }
    
    func joinChannel() {
        localVideo.isHidden = false
        
        if let name = userName {
            getAgoraEngine().joinChannel(byUserAccount: name, token: tempToken, channelId: channelName) { [weak self] (sid, uid, elapsed) in
                self?.userID = uid
                self!.isLocalVideoRender = true
                //self!.logVC?.log(type: .info, content: "did join channel")
            }
        } else {
            getAgoraEngine().joinChannel(byToken: tempToken, channelId: channelName, info: nil, uid: userID) { [weak self] (sid, uid, elapsed) in
                self?.userID = uid
                self!.isLocalVideoRender = true
                //self!.logVC?.log(type: .info, content: "did join channel")
            }
        }
        isStartCalling = true
    }
    
    @objc private func onPatientCallDenied() {
        self.leaveChannel()
        self.dismiss(animated: true, completion: nil)
    }
    
    private func getAgoraEngine() -> AgoraRtcEngineKit {
        if agoraKit == nil {
            agoraKit = AgoraRtcEngineKit.sharedEngine(withAppId: appID, delegate: self)
        }
        
        return agoraKit!
    }
    
    @IBAction func didClickHangUpButton(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected {
            leaveChannel()
            self.dismiss(animated: true, completion: nil)
        } else {
            joinChannel()
        }
    }
    func leaveChannel() {
        isRemoteVideoRender = false
        isLocalVideoRender = false
        isStartCalling = false
        getAgoraEngine().leaveChannel(nil)
        localVideo.isHidden = true
        remoteUserIDs.removeAll()
        //self.logVC?.log(type: .info, content: "did leave channel")
    }
    
    
    @IBAction func didClickMuteButton(_ sender: UIButton) {
        sender.isSelected.toggle()
        // mute local audio
        if muted {
            getAgoraEngine().muteLocalAudioStream(false)
        } else {
            getAgoraEngine().muteLocalAudioStream(true)
        }
        muted = !muted
    }
    
    @IBAction func didClickSwitchCameraButton(_ sender: UIButton) {
        sender.isSelected.toggle()
        agoraKit!.switchCamera()
    }
}

extension VideoChatViewController: AgoraRtcEngineDelegate {
    
    /// Callback to handle the event when the first frame of a remote video stream is decoded on the device.
    /// - Parameters:
    ///   - engine: RTC engine instance
    ///   - uid: user id
    ///   - size: the height and width of the video frame
    ///   - elapsed: Time elapsed (ms) from the local user calling JoinChannel method until the SDK triggers this callback.
    func rtcEngine(_ engine: AgoraRtcEngineKit, firstRemoteVideoDecodedOfUid uid:UInt, size:CGSize, elapsed:Int) {
        isRemoteVideoRender = true
        
        // Only one remote video view is available for this
        // tutorial. Here we check if there exists a surface
        // view tagged as this uid.
        let videoCanvas = AgoraRtcVideoCanvas()
        videoCanvas.uid = uid
        videoCanvas.view = remoteVideo
        videoCanvas.renderMode = .hidden
        agoraKit!.setupRemoteVideo(videoCanvas)
    }
    
    /// Occurs when a remote user (Communication)/host (Live Broadcast) leaves a channel.
    /// - Parameters:
    ///   - engine: RTC engine instance
    ///   - uid: ID of the user or host who leaves a channel or goes offline.
    ///   - reason: Reason why the user goes offline
    func rtcEngine(_ engine: AgoraRtcEngineKit, didOfflineOfUid uid:UInt, reason:AgoraUserOfflineReason) {
        isRemoteVideoRender = false
    }
    
    /// Occurs when a remote user’s video stream playback pauses/resumes.
    /// - Parameters:
    ///   - engine: RTC engine instance
    ///   - muted: YES for paused, NO for resumed.
    ///   - byUid: User ID of the remote user.
    func rtcEngine(_ engine: AgoraRtcEngineKit, didVideoMuted muted:Bool, byUid:UInt) {
        isRemoteVideoRender = !muted
    }
    
    /// Reports a warning during SDK runtime.
    /// - Parameters:
    ///   - engine: RTC engine instance
    ///   - warningCode: Warning code
    func rtcEngine(_ engine: AgoraRtcEngineKit, didOccurWarning warningCode: AgoraWarningCode) {
        //logVC?.log(type: .warning, content: "did occur warning, code: \(warningCode.rawValue)")
    }
    
    /// Reports an error during SDK runtime.
    /// - Parameters:
    ///   - engine: RTC engine instance
    ///   - errorCode: Error code
    func rtcEngine(_ engine: AgoraRtcEngineKit, didOccurError errorCode: AgoraErrorCode) {
        //logVC?.log(type: .error, content: "did occur error, code: \(errorCode.rawValue)")
    }
}

