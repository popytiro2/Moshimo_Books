//
//  ContentView.swift
//  MoshimoBooks
//
//  Created by 深澤佑樹 on 2021/08/28.
//

import SwiftUI


struct ContentView: View {
    @State private var isActive = false
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.white.edgesIgnoringSafeArea(.all)
                
                VStack {
                    VStack {
                        NavigationLink(
                            destination: InfoView(),
                            label: {
                                Text("売る")
                                    .font(.system(size: 40, weight: .bold, design: .default))
                                    .bold()
                                    .frame(width:200, height: 200)
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(100)
                                    .offset(y: -40)
                            })
                    }
                    
                    VStack {
                        NavigationLink(
                            destination: InfoView(),
                            label: {
                                Text("買う")
                                    .font(.system(size: 40, weight: .bold, design: .default))
                                    .bold()
                                    .frame(width:200, height: 200)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(100)
                                    .offset(y: -20)
                            })
                    
                    }
                    Text("販売履歴")
                        .font(.system(size: 25, weight: .bold, design: .default))
                        .bold()
                        .frame(width:220, height: 40)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .offset(y: +20)
                    Text("購入履歴")
                        .font(.system(size: 25, weight: .bold, design: .default))
                        .bold()
                        .frame(width:220, height: 40)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .offset(y: +30)
                    Text("アカウント")
                        .font(.system(size: 25, weight: .bold, design: .default))
                        .bold()
                        .frame(width:220, height: 40)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .offset(y: +40)
                }
            }
            .navigationBarTitle("もしもBooks 📚")
        }
    }
}

//struct ContentView: View {
//    var body: some View {
//        NavigationView{
//            Form {
//                VStack(alignment: .center) {
//                    NavigationLink(
//                        destination: InfoView(),
//    //                    destination: Text("destination"),
//                        label: {
//                            Button(action: {
//                                print("登録しました")
//                            }, label: {
////                                HStack {
////                                    Image(systemName: "pencil")
//                                    Text("売る")
//                                        .foregroundColor(.red)
//                                        .font(.title)
//                                        .frame(width: 300, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                                        .overlay(
//                                            RoundedRectangle(cornerRadius: 40)
//                                                .stroke(Color.red, lineWidth: 2)
//                                        )
////                                }
//                            })
////                            Text("売る")
////                                .bold()
////                                .frame(width:200, height: 200)
////                                .background(Color.blue)
////                                .foregroundColor(.white)
////                                .cornerRadius(100)
//    //                            .offset(y: -300)
//                        })
//                    }
//
//                NavigationLink(
//                    destination: InfoView(),
////                    destination: Text("destination"),
//                    label: {
//                        Button(action: {
//                            print("登録しました")
//                        }, label: {
//                            HStack {
////                                Image(systemName: "pencil")
//                                Text("買う")
//                                    .foregroundColor(.blue)
////                                    .font(.title)
////                                    .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
////                                    .overlay(
////                                        RoundedRectangle(cornerRadius: 100)
////                                            .stroke(Color.blue, lineWidth: 2)
////                                    )
//                            }
//                        })
//                        .foregroundColor(.blue)
//                        .font(.title)
//                        .frame(width: 300, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 40)
//                                .stroke(Color.blue, lineWidth: 2)
//                        )
////                        Text("買う")
////                            .bold()
////                            .frame(width:200, height: 200)
////                            .background(Color.blue)
////                            .foregroundColor(.white)
////                            .cornerRadius(100)
//                    })
//            }
////            .foregroundColor(.blue)
////            .background(Color.blue)
////            CircleTextView(select: "買う")
////                .offset(y: -60)
//            .navigationBarTitle("もしもBooks 📚")
//
//        }
//
//    }
//}


struct InfoView: View {

    @State private var isPresented = false
    @State private var isbn: String?
    @State private var foundBooks: Books?


    var body: some View {

//        NavigationView{
            Form{
//                Section(header:Text("SELECT MODE")) {
//                    Button(action: {
//                        print("売る")
//                    }, label: {
//                        HStack {
//                            Image(systemName: "pencil")
//                            Text("売る")
//                        }
//
//                    })
//                    Button(action: {
//                        print("買う")
//                    }, label: {
//                        HStack {
//                            Image(systemName: "pencil")
//                            Text("買う")
//                        }
//                    })
//
//                }
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

//            // BUtton instance with closer
//            Button("登録", action:{
//                print("登録しました")
//            })
//
//            // BUtton instance with trailing closer
//            Button("登録") {
//                print("登録しました")
//            }

            // BUtton instance with label view
            NavigationLink(
//                destination: StatementView(),
                destination: Statement3View(),
                label: {
                    HStack {
                        Image(systemName: "pencil")
                        Text("本の状態選択へ進む")
                    }
                })
//            Button(action: {
//
//                print("登録しました")
//            }, label: {
//
//                HStack {
//                    Image(systemName: "pencil")
//                    Text("登録")
//                }
//            })
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
//                Section(header:Text("本の情報")){
//                    Text("\(foundBooks?.items.first?.volumeInfo.title ?? "Title")")
////                    Text("\(foundBooks?.items.first?.volumeInfo.subtitle ?? "Subtitle")")
//                    Text("\(foundBooks?.items.first?.volumeInfo.authors.first ?? "Authors")")
//
//                }
//
//                Spacer()

                Section(header:Text("本の状態を選んでください")) {
//                    ZStack {
//                    if useYellowBackground {
//                        Color(.white)
//                    } else {
//                        Color(.white)
//                    }
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
//                    VStack {
//                        Text("新品同様")
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
//                            .minimumScaleFactor(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
//
//                        Text("ほとんど読まれた形跡がない完全な状態")
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .font(.subheadline)
//                            .foregroundColor(.secondary)
//                    }
//                    VStack {
//                        Text("非常に良い")
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
//                            .minimumScaleFactor(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
//
//                        Text("書き込みや線引きがなく、背表紙に傷がない")
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .font(.subheadline)
//                            .foregroundColor(.secondary)
//                    }
//                    VStack {
//                        Text("良い")
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .lineLimit(2)
//                            .minimumScaleFactor(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
//
//                        Text("書き込みや線引き、背病性に多少の傷がある")
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .font(.subheadline)
//                            .foregroundColor(.secondary)
//                    }
//                    VStack {
//                        Text("可")
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
//                            .minimumScaleFactor(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
//
//                        Text("傷や書き込みはあるが文字は読むことができる")
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .font(.subheadline)
//                            .foregroundColor(.secondary)
//                    }
                    
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
            
            
//            // BUtton instance with closer
//            Button("登録", action:{
//                print("登録しました")
//            })
//
//            // BUtton instance with trailing closer
//            Button("登録") {
//                print("登録しました")
//            }

            // BUtton instance with label view
//            Button(action: {
//
//                print("値付け")
//            }, label: {
//
//                HStack {
//                    Image(systemName: "pencil")
//                    Text("値付け")
//                }
//            })
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

struct Statement3View: View {

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
            
//            NavigationLink(
//                destination: /*@START_MENU_TOKEN@*/Text("Destination")/*@END_MENU_TOKEN@*/,
//                label: {
//                    /*@START_MENU_TOKEN@*/Text("Navigate")/*@END_MENU_TOKEN@*/
//                })
//        }
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


struct SendingView: View {
    var body: some View {
//        NavigationView {
//            Image(systemName: "icloud.and.arrow.up")
            NavigationLink(
                destination: ResultView(),
                label: {
                    Text("AIの値段の予測はお待ち中")
                    .font(.system(size: 25, weight: .bold, design: .default))
                    .bold()
                    .frame(width:360, height: 360)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(180)
                    .offset(y: -100)
                })
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
//            Image(systemName: "icloud.and.arrow.up")
//            NavigationLink(
//                destination: ResultView(),
//                label: {
//                    Text("QRコードを作成中です")
//                        .font(.system(size: 25, weight: .bold, design: .default))
//                        .bold()
//                        .frame(width:260, height: 260)
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(130)
//                        .offset(y: -100)
//                })
                .navigationBarTitle("QRコード作成中です")
//        }
    }
}


struct ResultView: View {
    var body: some View {
//        NavigationView{
            ZStack{
                Color.white.edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("1815円")
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


