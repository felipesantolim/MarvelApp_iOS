# Cielo challenge - Xcode 10 / Swift 4.0

Desenvolva um app que consuma a API da Marvel.

# Podfile - run pod install version 1.4.0
```<swift>
platform :ios, '11.0'
use_frameworks!
workspace 'MarvelApp_iOS.xcworkspace'

target 'MarvelApp_iOS' do

pod 'lottie-ios'
pod 'R.swift'
pod 'ReachabilitySwift'
pod 'Fabric'
pod 'Crashlytics'
pod 'Kingfisher'
pod 'SwiftyJSON', '~> 4.0'
pod 'Alamofire', '~> 4.7'
pod 'CryptoSwift'

target 'MarvelApp_iOSTests' do
inherit! :search_paths
end

target 'MarvelApp_iOSUITests' do
inherit! :search_paths
end

end

target 'MarvelAppApi' do
project 'MarvelAppApi/MarvelAppApi.xcodeproj'
pod 'SwiftyJSON', '~> 4.0'
pod 'Alamofire', '~> 4.7'
pod 'CryptoSwift'
end

target 'MarvelAppSupport' do
project 'MarvelAppSupport/MarvelAppSupport.xcodeproj'
end

```

# Arquitetura MVC - (LAYERS)

Utilizei MVC com as camadas Infrastructure, Manager, Business e Provider a fim de abstrair toda a parte do API deixando todas as camadas mais clean. Separei o projeto junto a dois frameworks no workspace sendo eles "MarvelAppApi" e "MarvelAppSupport".

<img src="https://github.com/felipesantolim/MarvelApp_iOS/blob/master/Images/Screen%20Shot%202018-09-21%20at%2001.24.01.png" width="320"/>

# Infrastructure:
"Strings", "Plist", "Storyboard" e "Resources"

# ViewController:
 Esta camada atua como uma intermediária entre as camadas View e Manager, ela é reponsável por notificar as Views sobre eventuais mudanças de modelos e vice-versa, ainda nesta camada faço algumas tratativas de eventos, tais como: IBActions e Delegates/DataSources.
 
 # View:
  Responsável por toda parte de apresentação, animação a regras de view. Para abstrair um pouco e deixar mais organizado mantenho todos os IBOutlets aqui ele eles são acessados direto pela controller:
  
```<swift>
    private var mainView: MAFeedView {
        return self.view as! MAFeedView
    }
```
  
  # Manager:
   Nesta camada controlo o fluxo de requisições entre a camada ViewController e Business. Ela é exclusivamente chamada pela camada ViewController como uma interface.
   
```<swift>
        fetchingMore = true
        _ = MAManager.shared.fetchAllCharacters(with: currentPg, { _chars in
            if let `_chars` = _chars, _chars.count > 0 {
                _ = _chars.map { item in
                    self.chars.append(item)
                }
                self.currentPg += 22
                self.fetchingMore = !self.fetchingMore
            }
            _ = DispatchQueue.main.async {
                self.mainView.collectionView.reloadData()
            }
        })
```
   
```<swift>
public class MAManager: MAManagerProtocol {
    
    public static let shared = MAManager()
    
    public func fetchAllCharacters(with pg: Int?, _ completion: @escaping MAManagerResultCallback) {
        MABusiness.shared.fetchAllCharacters(with: pg, completion)
    }
} 
```
   
   # Business:
    Esta é uma das mais importantes camadas do aplicativo, aqui é onde comtém estruturas internas responsáveis por todas as regras de negócio. Ela deve ser exclusivamente acessada pela camada Manager e invocar a camada Provider (quando necessário). Ainda nesta camada, é onde recebo os "dados primitivos" (ex:. Data?, Dictionary?) e criá-los em modelos através da realização do parse.
```<swift>
import SwiftyJSON

class MABusiness: MABusinessProtocol {
    
    public static let shared = MABusiness()
    
    func fetchAllCharacters(with pg: Int?, _ completion: @escaping MABusinessResultCallback) {
        
        _ = MAProvider.shared.fetchAllCharacters(with: pg) { _data in
            guard let `JSONValue` = _data else { return completion(nil) }
            
            let chars: [MACharactersModel] = JSONValue[MACharactersModel.KeyData][MACharactersModel.KeyResults]
                .arrayValue.map { value in
                
                let thumbnail = MACharThumbnailModel(
                    value[MACharactersModel.KeyThumbnail][MACharactersModel.KeyPath].stringValue,
                    _extension: value[MACharactersModel.KeyThumbnail][MACharactersModel.KeyExtension].stringValue)
                
                return MACharactersModel(value[MACharactersModel.KeyUid].intValue,
                                         value[MACharactersModel.KeyName].stringValue,
                                         thumbnail,
                                         value[MACharactersModel.KeyDescription].stringValue,
                                         value[MACharactersModel.KeyComics][MACharactersModel.KeyAvailable].intValue,
                                         value[MACharactersModel.KeySeries][MACharactersModel.KeyAvailable].intValue,
                                         value[MACharactersModel.KeyStories][MACharactersModel.KeyAvailable].intValue,
                                         value[MACharactersModel.KeyEvents][MACharactersModel.KeyAvailable].intValue)
            }
            completion(chars)
        }
    }
}
```
    
# Provider: 
     É responsável pela abstração das camadas da aplicação com acesso às fontes de dados e biblioteca de terceiros. Aqui deve sempre retornar tipos de "dados primitivos", e ser exclusivamente acessada pelo "Business".
```<swift>
import Alamofire
import SwiftyJSON
import CryptoSwift

class MAProvider: MAProviderProtocol {
    
    public static let shared = MAProvider()
    
    func fetchAllCharacters(with pg: Int?, _ completion: @escaping MAProviderResultCallback) {
        if let `pg` = pg {
            rx_callApi(with: MAServiceHTTP.shared.getUrl(), page: pg) { _JSON in completion(_JSON) }
        }
    }
}

extension MAProvider {
    
    fileprivate func rx_callApi(with url: URL, page: Int, completion: @escaping (_ data: JSON?) -> ()) {

        let keys = MAServiceHTTP.shared.getKeys()
        let ts = NSDate().timeIntervalSince1970.description
        let params: Parameters = [
            "apikey": keys.publicKey,
            "ts": ts,
            "hash": (ts + keys.privateKey + keys.publicKey).md5(),
            "orderBy": "name",
            "limit" : 21,
            "offset" : page,
        ]
        
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding(destination: .queryString),
                          headers: nil).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completion(json)
            case .failure(_):
                completion(nil)
            }
        }
    }
}
```
     
# Aplicação (app Versão= 1.0.0 Build= 0.0.2):
     
- Abaixo algumas imagens do app.
- OBS: Na pasta imagens que se encontra na raiz, possuem imagens e vídeos do projeto.
     
# Icon
<img src="https://github.com/felipesantolim/MarvelApp_iOS/blob/master/Images/icon.jpg" width="100"/>
     
# Slapshscreen
<img src="https://github.com/felipesantolim/MarvelApp_iOS/blob/master/Images/Splashscreen.PNG" width="320"/>
     
# Chars List (Collection View)
<img src="https://github.com/felipesantolim/MarvelApp_iOS/blob/master/Images/02.PNG" width="320"/>
<img src="https://github.com/felipesantolim/MarvelApp_iOS/blob/master/Images/05.PNG" width="320"/>
<img src="https://github.com/felipesantolim/MarvelApp_iOS/blob/master/Images/06.PNG" width="320"/>
     
# Deatils
<img src="https://github.com/felipesantolim/MarvelApp_iOS/blob/master/Images/03.PNG" width="320"/>
<img src="https://github.com/felipesantolim/MarvelApp_iOS/blob/master/Images/04.PNG" width="320"/>
<img src="https://github.com/felipesantolim/MarvelApp_iOS/blob/master/Images/07.PNG" width="320"/>
<img src="https://github.com/felipesantolim/MarvelApp_iOS/blob/master/Images/08.PNG" width="320"/>
     
# My Profile (RESUME):

I've been spending my time with a lot of contents that involve technologies because I breathe this kind of topic, I have more than six (7) years of experience in iOS development and I don't stop of growing my knowledge in this field. I'm passionate about Apple devices and so on.

I'm very proactive, dynamic and hardworking (of course).
     
- Linkedin:</br>
https://www.linkedin.com/in/felipesantolim
</br></br>
- Apps on App Store:</br>
https://itunes.apple.com/us/app/meme-maker-plus/id1380190429?mt=8 </br>
https://itunes.apple.com/us/app/pacote-fácil/id1382473900?mt=8 
https://itunes.apple.com/us/app/fipe/id1374656563?mt=8 </br>
</br></br>
- Cocoacontrols:</br>
https://www.cocoacontrols.com/controls/shfsignature
     
# O que eu faria com mais tempo?
     
- Fabric (Crashlytics)
- Implementaria extensions para UIColor.
- Faria o uso de "Fakery" para cirar mocks precisos quando rodarmos em um 
ambiente de teste, garantindo a integridade e funcionalidade da camada de apresentação.
- Adicionaria testes de UI.
- Adicionaria testes unitários.
