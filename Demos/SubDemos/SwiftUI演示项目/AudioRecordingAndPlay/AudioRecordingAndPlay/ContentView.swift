//
//  ContentView.swift
//  AudioRecordingAndPlay
//
//  Created by weijie.zhou on 2023/4/22.
//

import SwiftUI

struct ContentView: View {
    @State var urls: [URL] = []
    @StateObject var recorder = AudioRecorder()
    @StateObject var player = AudioPlayer()
    
    var body: some View {
        VStack {
            Button {
                if recorder.recording {
                    let url = recorder.stopRecording()
                    if let nurl = recorder.recordings.filter({ e in
                        e.fileURL.lastPathComponent == url.lastPathComponent
                    }).first?.fileURL {
                        urls.append(nurl)
                    }
                } else {
                    recorder.startRecording()
                }
            } label: {
                Text("录音")
                    .font(.system(size: 30))
            }

            ForEach(urls, id:\.self) { url in
                Text("\(url.absoluteString)")
                    .foregroundColor(.blue)
                    .font(.system(size: 18))
                    .onTapGesture {
                        if player.isPlaying {
                            player.stopPlayback()
                        } else {
                            player.startPlayback(audio: url)
                        }
                    }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
