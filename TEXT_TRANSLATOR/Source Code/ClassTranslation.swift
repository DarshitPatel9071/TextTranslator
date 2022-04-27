//
//  ClassTranslation.swift
//  Text_Translation
//
//  Created by iMac on 25/04/22.
//

import Foundation
import UIKit
import MLKitTranslate

public class Translation : NSObject
{
    //MARK:- Variable's
    public static let shared:Translation = Translation()
    public var message:String = "Please Wait"
    private var tempTranslator:Translator!
    
    //MARK:- Function's
    
    // check model is downloded or not for both lan
    private func checkAndDownloadModel(sourceLan:TranslateLanguage,targetLan:TranslateLanguage,completion:@escaping ((Error?) -> Void))
    {
        isModelDownloaded(language: sourceLan, completion: { (error) in
            if error == nil{
                self.isModelDownloaded(language: targetLan) { (newErr) in
                    completion(newErr)
                }
            }else{
                completion(error)
            }
        })
    }
    
    // downlode model if not downloaded
    private func isModelDownloaded(language: TranslateLanguage,completion:@escaping ((Error?) -> Void))
    {
        let localModels = ModelManager.modelManager().downloadedTranslateModels
        if localModels.contains(TranslateRemoteModel.translateRemoteModel(language: language)){
            print("Log :- \(language.rawValue) Model Is Downloaded")
            completion(nil)
        }
        else{
            print("Log :- \(language.rawValue) Model Is Not Downloaded")
            downloadModel(language: language) { (err) in
                completion(err)
            }
        }
    }
    
    // download model
    private func downloadModel(language: TranslateLanguage,completion:@escaping ((Error?) -> Void)){
        
        let conditions = ModelDownloadConditions(allowsCellularAccess: true,allowsBackgroundDownloading: true)
        
//        Translator.
        
        let options = TranslatorOptions(sourceLanguage: .english, targetLanguage: language)
        tempTranslator = Translator.translator(options: options)
        
        tempTranslator.downloadModelIfNeeded(with: conditions) { (err) in
            print("Log :- \(err == nil ? "\(language.rawValue) model downloaded success"  : "Error Found During \(language.rawValue) Model downloading :- \(err!.localizedDescription)")")
            completion(err)
        }
    }
    
    //translate text
    public func translateText(text:String,sourceLan:TranslateLanguage = .english,targetLan:TranslateLanguage = .hindi,completion:@escaping ((String) -> Void)){
        UIApplication.shared.getTopMostVC()?.loader(message: message)
        checkAndDownloadModel(sourceLan: sourceLan, targetLan: targetLan) { [self] (err) in
            if err != nil{
                completion(err!.localizedDescription)
            }else{
                let options = TranslatorOptions(sourceLanguage: sourceLan, targetLanguage: targetLan)
                tempTranslator = Translator.translator(options: options)
                
                tempTranslator.translate(text, completion: { (str, err) in
                    UIApplication.shared.getTopMostVC()?.loader(isStart: false,message: message)
                    completion(err == nil ? str! : err!.localizedDescription)
                })
            }
        }
    }
}
