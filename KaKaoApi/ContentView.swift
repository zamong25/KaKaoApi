import SwiftUI
 
struct QuoteData: Decodable {
    var translated_text: [[String]]
}
 
struct ContentView: View {
    @State var quotedata: QuoteData?
    
   
    var body: some View {
        Button("get"){self.getData()}
        Text(quotedata?.translated_text[0][0] ?? "아니")
    }
    
    func getData() {
       
        let token = "8995e2de40ee9b465734713e5a0d2ac5"
        guard let url = URL(string: "https://dapi.kakao.com/v2/translation/translate?src_lang=en&target_lang=kr&query=money") else {
            fatalError("Invalid URL")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("KakaoAK"+" "+"\(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else{ return }
                       do{
                           let decodedData =  try JSONDecoder().decode(QuoteData.self, from: data)
                           DispatchQueue.main.async {
                               self.quotedata = decodedData
                           }
                       }catch let error{
                           print(error)
                       }
        }.resume()
    }
}

