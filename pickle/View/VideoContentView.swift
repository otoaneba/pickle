//
//  VideoContentView.swift
//  pickle
//
//  Created by Naoto Abe on 11/24/23.
//

import Aespa
import SwiftUI

struct VideoContentView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State var isRecording = false
    @State var isFront = false
    @State var recordingIsDone = false
    
    @State var showSetting = false
    @State var showGallery = false
    
    @State var captureMode: AssetType = .video
    @State private var notes = ""
    
    @FocusState var isInputActive: Bool
    @State var keyboardHeight: CGFloat = 0
    
    @ObservedObject private var viewModel = VideoContentViewModel()
        
    var body: some View {
        NavigationStack {
            ZStack {
                viewModel.preview
                    .frame(minWidth: 0,
                           maxWidth: .infinity,
                           minHeight: 0,
                           maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    ZStack(alignment: .center) {
                        // Mode change
                        Picker("Capture Modes", selection: $captureMode) {
                            Text("Video").tag(AssetType.video)
                            Text("Photo").tag(AssetType.photo)
                        }
                        .pickerStyle(.segmented)
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(8)
                        .frame(width: 200)
                        
                        HStack {
                            Spacer()
                            
                            Button(action: { showSetting = true }) {
                                Image(systemName: "gear")
                                    .resizable()
                                    .foregroundColor(.white)
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                
                            }
                            .padding(20)
                            .contentShape(Rectangle())
                        }
                    }
                    
                    Spacer()
                    ZStack {
                        HStack {
                            // Album thumbnail + button
                            Button(action: { showGallery = true }) {
                                let coverImage = (viewModel.videoAlbumCover)
                                ?? Image("")
                                roundRectangleShape(with: coverImage, size: 80)
                            }
                            .shadow(radius: 5)
                            .contentShape(Rectangle())
                            
                            Spacer()
                            
                            // Position change + button
                            Button(action: {
                                viewModel.aespaSession.position(to: isFront ? .back : .front)
                                isFront.toggle()
                            }) {
                                Image(systemName: "arrow.triangle.2.circlepath.camera.fill")
                                    .resizable()
                                    .foregroundColor(.white)
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .padding(20)
                                    .padding(.trailing, 20)
                            }
                            .shadow(radius: 5)
                            .contentShape(Rectangle())
                        }
                        
                        // Shutter + button
                        recordingButtonShape(width: 60).onTapGesture {
                            switch captureMode {
                            case .video:
                                if isRecording {
                                    viewModel.stopRecordingSession()
                                    isRecording = false
                                    recordingIsDone = true
                                    
                                } else {
                                    viewModel.aespaSession.startRecording()
                                    isRecording = true
                                }
                            case .photo:
                                viewModel.aespaSession.capturePhoto()
                            }
                        }
                        
                    }
                }
            }
        }.navigationDestination(isPresented: $recordingIsDone) {
//            let entry = EntryItem(id: UUID(), title: "Trip to Japan", date: .now, status: "status", duration: .seconds(59), location: "Kyoyo, Japan", comment: "The instance’s content represents a read-only or read-write value, and its label identifies or describes the purpose of that value. The resulting element has a layout that’s consistent with other framework controls and automatically adapts to its container, like a form or toolbar. Some styles of labeled content also apply styling or behaviors to the value content, like making Text views selectable.", entryType: "video", imageUrl: URL(string: "file:///var/mobile/Containers/Data/Application/57971C6D-889D-4CB7-ADFD-90E3BB6420CA/Documents/test.jpg")!)
            if let entry = viewModel.entrytest {
                EntrySummaryView(entry: entry)
            }
        }
//        .sheet(isPresented: $viewModel.pathExists, content: {
//            SummaryView()
//        })
    }
}

extension VideoContentView {
    @ViewBuilder
    func roundRectangleShape(with image: Image, size: CGFloat) -> some View {
        image
            .resizable()
            .scaledToFill()
            .frame(width: size, height: size, alignment: .center)
            .clipped()
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.white, lineWidth: 1)
            )
            .padding(20)
    }
    
    @ViewBuilder
    func recordingButtonShape(width: CGFloat) -> some View {
        ZStack {
            Circle()
                .strokeBorder(isRecording ? .red : .white, lineWidth: 3)
                .frame(width: width)
            
            Circle()
                .fill(isRecording ? .red : .white)
                .frame(width: width * 0.8)
        }
        .frame(height: width)
    }
    
    @ViewBuilder func SummaryView() -> some View {
        NavigationView {
            VStack(alignment: .leading) {
                ZStack{
                    ZStack(alignment: .bottomLeading) {
                        let coverImage = (viewModel.videoAlbumCover)
                        ?? Image("")
                        roundRectangleShape(with: coverImage, size: 80)
                    }
                }.padding(.bottom)
                LabeledContent("Date", value: "\(Date().formatted(date: .numeric, time: .omitted))")
                //                LabeledContent("Location", value: "\(entry.location)")
                Label("Notes", systemImage: "list.clipboard.fill")
                    .padding(.top)
                var temp = print("\(isInputActive)")
                Form {
                    TextEditor(text: $notes)
                        .focused($isInputActive)
                        .toolbar {
                                Button("Done") {
                                    isInputActive = false
                                    var temp2 =  print("isInputActive \(isInputActive)")
                                }
                            
                        }
                        .frame(height: 300)
                        .cornerRadius(5) /// make the background rounded
                        .overlay( /// apply a rounded border
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(colorScheme == .dark ? .white : .gray, lineWidth: 1)
                        )
                    Button(action: {viewModel.saveEntry()}, label: {
                        Text("SAVE")
                    }).foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                Spacer()
            }
        }
            .padding(.horizontal)
    }
}

enum AssetType {
    case video
    case photo
}

struct VideoContentView_Previews: PreviewProvider {
    static var previews: some View {
        VideoContentView()
    }
}
