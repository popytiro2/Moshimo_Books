//
//  ContentView.swift
//  MoshimoBooks
//
//  Created by 深澤佑樹 on 2021/08/28.
//

import SwiftUI
import UIKit
import Foundation
import Combine
import CoreGraphics


struct ContentView: View {
    @State private var isActive = false
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.blue.edgesIgnoringSafeArea(.all)
                
                VStack {
                    VStack {
                        NavigationLink(
                            destination: InfoView(),
                            label: {
                                VStack {
                                    Text("売る")
                                        .font(.system(size: 60, weight: .bold, design: .default))
                                        .bold()
                                        .foregroundColor(.blue)
                                    Text("SELL")
                                        .font(.system(size: 30, weight: .bold, design: .default))
                                        .bold()
                                        .foregroundColor(.gray)
                                }
                                    .frame(width:200, height: 200)
                                    .background(Color.white)
                                    .cornerRadius(100)
                                    .offset(y: -40)
                            })
//                        NavigationLink(
//                            destination: InfoView(),
//                            label: {
//                                Text("売る")
//                                    .font(.system(size: 40, weight: .bold, design: .default))
//                                    .bold()
//                                    .frame(width:200, height: 200)
//                                    .background(Color.red)
//                                    .foregroundColor(.white)
//                                    .cornerRadius(100)
//                                    .offset(y: -40)
//                            })
                    }
                    
                    VStack {
                        NavigationLink(
                            destination: InfoView(),
                            label: {
                                VStack {
                                    Text("買う")
                                        .font(.system(size: 60, weight: .bold, design: .default))
                                        .bold()
                                        .foregroundColor(.blue)
                                    Text("BUY")
                                        .font(.system(size: 30, weight: .bold, design: .default))
                                        .bold()
                                        .foregroundColor(.gray)
                                }
                                    .frame(width:200, height: 200)
                                    .background(Color.white)
                                    .cornerRadius(100)
                                    .offset(y: -30)
                            })
//                        NavigationLink(
//                            destination: InfoView(),
//                            label: {
//                                Text("買う")
//                                    .font(.system(size: 40, weight: .bold, design: .default))
//                                    .bold()
//                                    .frame(width:200, height: 200)
//                                    .background(Color.blue)
//                                    .foregroundColor(.white)
//                                    .cornerRadius(100)
//                                    .offset(y: -20)
//                            })
                    }
                    Text("販売履歴")
                        .font(.system(size: 25, weight: .bold, design: .default))
                        .bold()
                        .frame(width:220, height: 40)
                        .background(Color.white)
                        .foregroundColor(.gray)
                        .cornerRadius(10)
                        .offset(y: +20)
                    Text("購入履歴")
                        .font(.system(size: 25, weight: .bold, design: .default))
                        .bold()
                        .frame(width:220, height: 40)
                        .background(Color.white)
                        .foregroundColor(.gray)
                        .cornerRadius(10)
                        .offset(y: +30)
                    Text("アカウント")
                        .font(.system(size: 25, weight: .bold, design: .default))
                        .bold()
                        .frame(width:220, height: 40)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .offset(y: +40)
                }
            }
            .navigationBarTitle("もしもBooks 📚")
        }
    }
    
    init() {
        setupNavigationBar()
    }
     
    func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
//        appearance.backgroundColor = UIColor(red: 0, green: 0.5, blue: 1, alpha: 1.0)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.systemBlue]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemBlue]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}


struct InfoView: View {

    @State private var isPresented = false
    @State private var isbn: String?
    @State private var foundBooks: Books?


    var body: some View {

//        NavigationView{
            Form{
                
                Section(header:Text("本の情報")){
                    Text("\(foundBooks?.items.first?.volumeInfo.title ?? "タイトル")")
                    Text("\(foundBooks?.items.first?.volumeInfo.subtitle ?? "サブタイトル")")
                    Text("\(foundBooks?.items.first?.volumeInfo.authors.first ?? "著者")")

                }
                
                Section(header:Text("追加情報")) {
                    Text("\(foundBooks?.items.first?.volumeInfo.publishedDate ?? "出版日")")
                    Text("\(foundBooks?.items.first?.volumeInfo.pageCount ?? 0) ページ")
                    Text("\(foundBooks?.items.first?.volumeInfo.language ?? "言語")")
                    Text("ISBN: \(isbn ?? "")")
                }

            }.navigationBarTitle("本の情報 📚")
            .navigationBarItems(trailing:
                                    Button(action: {
                                        self.isPresented.toggle()
                                    }) {
                                        Image(systemName: "barcode")
                                    }.sheet(isPresented: $isPresented) {
                                        BarCodeScanner(isbn: $isbn, foundBooks: $foundBooks)
                                    }
            )

//        }
        VStack {
            NavigationLink(
//                destination: StatementView(),
                destination: ChouseStatusView(),
                label: {
                    HStack {
                        Image(systemName: "pencil")
                        Text("本の状態選択へ進む")
                    }
                })
        }
    }
}


struct CircleTextView: View {
//    var color: Color
//    var number: Int
    var select: String
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 200, height: 200)
                .foregroundColor(.blue)
            Text("\(select)")
                .foregroundColor(.white)
                .font(.system(size: 70, weight: .bold))
        }
    }
}


struct StatementView: View {

    @State private var isPresented = false
    @State private var isbn: String?
    @State private var foundBooks: Books?
    @State private var checked = false
    @State private var useYellowBackground = false

    var body: some View {

        NavigationView{
            List{
                Section(header:Text("本の状態を選んでください")) {
                    Button(action: {
                        print("新品同様")
                    }, label: {
                        
                        VStack {
                            Text("新品同様")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                                .minimumScaleFactor(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                            
                            Text("ほとんど読まれた形跡がない完全な状態")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    })
//                    }
                    Button(action: {
                        print("非常に良い")
                    }, label: {
                        VStack {
                            Text("非常に良い")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                                .minimumScaleFactor(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                            
                            Text("書き込みや線引きがなく、背表紙に傷がない")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    })
                    Button(action: {
                        print("良い")
                    }, label: {
                        VStack {
                            Text("良い")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                                .minimumScaleFactor(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                            
                            Text("書き込みや線引き、背表紙に多少の傷がある")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    })
                    Button(action: {
                        print("可")
                    }, label: {
                        VStack {
                            Text("可")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                                .minimumScaleFactor(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                            
                            Text("傷や書き込みはあるが文字は読むことができる")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    })
                }
                
                Spacer()
                
                VStack {
                    NavigationLink(
                        destination: SendingView(),
                        label: {
                            Button(action: {
                                
                                print("値付け")
                            }, label: {

                                HStack {
                                    Image(systemName: "pencil")
                                    Text("値付け")
                                }
                            })
                    })
                }
                
            }
                
            }
//        }
    }
}


struct Statement2View: View {
    @State var selected : Int? = 0
    var body: some View {
        
//        VStack {
//        EditButton()
        
        NavigationView {
        List(selection: $selected) {
            VStack {
                Text("未選択")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    .minimumScaleFactor(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                
                Text("本の状態を選択してください")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }.tag(0)
            
            VStack {
                Text("新品同様")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    .minimumScaleFactor(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                
                Text("ほとんど読まれた形跡がない完全な状態")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }.tag(1)
            
            VStack {
                Text("非常に良い")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    .minimumScaleFactor(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                
                Text("書き込みや線引きがなく、背表紙に傷がない")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }.tag(2)
            
            VStack {
                Text("良い")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    .minimumScaleFactor(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                
                Text("書き込みや線引き、背表紙に多少の傷がある")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }.tag(3)
            
            VStack {
                Text("可")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    .minimumScaleFactor(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                
                Text("傷や書き込みはあるが文字は読むことができる")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }.tag(4)
        }
//        }
        .environment(\.editMode, .constant(.active))
        .navigationBarTitle("本の状態を選択")
//        }
        
        Spacer()
        NavigationLink(
            destination: SendingView(),
            label: {
                Button(action: {
                    
                    print("値付け")
                }, label: {

                    HStack {
                        Image(systemName: "pencil")
                        Text("値付け")
                    }
                })
        })
    }
    }
}

struct ChouseStatusView: View {

    @State private var isPresented = false
    @State private var isbn: String?
    @State private var foundBooks: Books?
    @State private var checked = false
    @State private var useYellowBackground = false
    @State var selected : Int? = 0

    var body: some View {

//        NavigationView{
            List(selection: $selected) {
                VStack {
                    Text("未選択")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                        .minimumScaleFactor(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                    
                    Text("本の状態を選択してください")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }.tag(0)
                
                VStack {
                    Text("新品同様")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                        .minimumScaleFactor(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                    
                    Text("ほとんど読まれた形跡がない完全な状態")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }.tag(1)
                
                VStack {
                    Text("非常に良い")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                        .minimumScaleFactor(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                    
                    Text("書き込みや線引きがなく、背表紙に傷がない")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }.tag(2)
                
                VStack {
                    Text("良い")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                        .minimumScaleFactor(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                    
                    Text("書き込みや線引き、背表紙に多少の傷がある")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }.tag(3)
                
                VStack {
                    Text("可")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                        .minimumScaleFactor(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                    
                    Text("傷や書き込みはあるが文字は読むことができる")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }.tag(4)
            }
    //        }
            .environment(\.editMode, .constant(.active))
            .navigationBarTitle("本の状態を選択")
                
            Spacer()
        
        Spacer()
        VStack {
            NavigationLink(
                destination: SendingView(),
                label: {
                    HStack {
                        Image(systemName: "pencil")
                        Text("値付け")
                    }
                })
        }
    }
}

struct ActivityIndicator: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: .large)
    }
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        uiView.startAnimating()
    }
}


struct SendingView: View {
    @State var showingIndicator = true
    
    var body: some View {
        ZStack {
//                    NavigationView {
            //            Image(systemName: "icloud.and.arrow.up")
                        NavigationLink(
                            destination: ResultView(),
                            label: {
                                Text("AIの値段の予測はお待ち中")
                                .font(.system(size: 30, weight: .bold, design: .default))
                                .bold()
                                .frame(width:360, height: 360)
                                .background(Color.white)
                                .foregroundColor(.blue)
                                .cornerRadius(180)
                                .offset(y: -200)
                            })
                            .navigationBarTitle("値付け中")
//                                    }
//            VStack {
//                Spacer()
//                Button {
//                    showingIndicator.toggle()
//                } label: {
//                    Text("Show or Hide Indicator")
//                        .foregroundColor(Color.white)
//                        .padding()
//                        .background(Color.gray)
//                }
//            }

            if showingIndicator {
                ActivityIndicator()
                    .offset(y:-100)
            }
            
        }
    }
}


//struct SendingView: View {
//    var body: some View {
////        NavigationView {
////            Image(systemName: "icloud.and.arrow.up")
//            NavigationLink(
//                destination: ResultView(),
//                label: {
//                    Text("AIの値段の予測はお待ち中")
//                    .font(.system(size: 25, weight: .bold, design: .default))
//                    .bold()
//                    .frame(width:360, height: 360)
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(180)
//                    .offset(y: -100)
//                })
////        }
//    }
//}


//struct SendingView: View {
//    var body: some View {
////        NavigationView {
////            Image(systemName: "icloud.and.arrow.up")
//            NavigationLink(
//                destination: ResultView(),
//                label: {
//                    Text("AIの値段の予測はお待ち中")
//                    .font(.system(size: 25, weight: .bold, design: .default))
//                    .bold()
//                    .frame(width:360, height: 360)
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(180)
//                    .offset(y: -100)
//                })
////        }
//    }
//}


struct ResultView: View {
    var body: some View {
//        NavigationView{
            ZStack{
                Color.white.edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("¥1,815円")
                        .font(.system(size: 50, weight: .bold, design: .default))
                        .bold()
                        .frame(width:350, height: 110)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .offset(y: -60)
                    VStack {
                        NavigationLink(
                            destination: CreatingQRCodeView(),
                            label: {
                                Text("確定")
                                    .font(.system(size: 25, weight: .bold, design: .default))
                                    .bold()
                                    .frame(width:180, height: 50)
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .offset(y: +10)
                            })
                    }
                    
                    VStack {
                        NavigationLink(
                            destination: ContentView(),
                            label: {
                                Text("キャンセル")
                                    .font(.system(size: 25, weight: .bold, design: .default))
                                    .bold()
                                    .frame(width:180, height: 50)
                                    .background(Color.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .offset(y: +30)
                            })
                    
                    }
                }
            }
            .navigationBarTitle("本の値段が決まりました")
//        }
    }
}


struct CreatingQRCodeView: View {
    
    var body: some View {
//        NavigationView {
            Image("QRCode")
                .resizable()
                .scaledToFit()
                .frame(width: 350.0, height: 350.0, alignment: .leading)
                .offset(y: -40)
            
        VStack {
            NavigationLink (
                    destination: QRContentView(),
                    label: {
                        Text("本の登録は完了しました")
                            .font(.system(size: 30, weight: .bold, design: .default))
                            .bold()
                        .frame(width:350, height: 70)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .offset(y: +30)
                    })
                
                
                    
                .navigationBarTitle("QRコード作成中です")
        }
//        }
    }
}


struct CheckBox: View {
    
    @Binding var checked: Bool
    private var onTapped: () -> Void
    
    init(checked: Binding<Bool>, onTapped: @escaping () -> Void) {
        self._checked = checked
        self.onTapped = onTapped
    }
    
    var body: some View {
        Button(action: {
            self.$checked.wrappedValue.toggle()
            self.onTapped()
        }) {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(.gray), lineWidth: 1)
                .frame(width: 20, height: 20)
                .overlay(showCheckImage())
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private func showCheckImage() -> AnyView {
        if self.$checked.wrappedValue {
            return AnyView(
                Image("icon_checkbox")
                    .resizable()
                    .renderingMode(.original)
            )
        } else {
            return AnyView(EmptyView())
        }
    }
}


// こっからQRCodeReader

struct QRContentView: View {
    
    @State private var urlInput: String = ""
    @State private var qrCode: QRCode?
    
    private let qrCodeGenerator = QRCodeGenerator()
    @ObservedObject private var imageSaver = ImageSaver()
    
    var body: some View {
//        NavigationView {
            GeometryReader { geometry in
                VStack {
                    HStack {
                        TextField("Enter url:", text: $urlInput)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .textContentType(.URL)
                            .keyboardType(.URL)
                        
                        Button("Generate") {
                            UIApplication.shared.windows.first {$0.isKeyWindow}?.endEditing(true)
                            qrCode = qrCodeGenerator.generateQRCode(forUrlString: urlInput)
                            urlInput = ""
                        }
                        .disabled(urlInput.isEmpty)
                        .padding(.leading)
                    }
                    
                    Spacer()
                    
//                    EmptyStatementView(width: geometry.size.width)
//                    EmptyStateView(width: geometry.size.width)
                    if qrCode == nil {
                        EmptyStatementView(width: geometry.size.width)
                    } else {
                        QRCodeView(qrCode: qrCode!, width: geometry.size.width)
                    }
                    
                    Spacer()
                }
                .padding()
                .navigationBarTitle("QR Code")
                .navigationBarItems(trailing: Button(action: {
                    assert(qrCode != nil, "Cannot save nil QR code image")
                    imageSaver.saveImage(qrCode!.uiImage)
                }) {
                    Image(systemName: "square.and.arrow.down")
                }
                .disabled(qrCode == nil))
                .alert(item: $imageSaver.saveResult) { saveResult in
                    return alert(forSaveSsatus: saveResult.saveStatus)
                }
//            }
        }
    }

    private func alert(forSaveSsatus saveStatus: ImageSaveStatus) -> Alert {
        switch saveStatus {
        case .success:
            return Alert(
                title: Text("Success!"),
                message: Text("THe QR code was saved to your photo library.")
            )
        case .error:
            return Alert(
                title: Text("Oops!"),
                message: Text("An error occurred while saving your QR code.")
            )
        case .libraryPermissionDenied:
            return Alert(
                title: Text("Oops!"),
                message: Text("This app needs permission to add photos to your library."),
                primaryButton: .default(Text("Ok")),
                secondaryButton: .default(Text("Open setting")) {
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
                    UIApplication.shared.open(settingsUrl)
                }
            )
        }
    }
}


struct QRCodeView: View {
    let qrCode: QRCode
    let width: CGFloat
    
    var body: some View {
        VStack {
            Label("QR code for \(qrCode.urlString):", systemImage: "qrcode.viewfinger")
                .lineLimit(3)
            Image(uiImage: qrCode.uiImage)
                .resizable()
                .frame(width: width * 2 / 3, height: width * 2 / 3)
        }
    }
}


struct EmptyStatementView: View {
    let width: CGFloat
    
    private var imageLength: CGFloat {
        width / 2.5
    }
    
    var body: some View {
        VStack {
            Image(systemName: "qrcode")
                .resizable()
                .frame(width: imageLength, height: imageLength)
            
            Text("Create your own QR code")
                .padding(.top)
        }
        .foregroundColor(Color(UIColor.systemGray))
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


