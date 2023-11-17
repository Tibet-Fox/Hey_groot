//
//  MyRegisterPlant.swift
//  Hey_Groot
//
//  Created by 서명주 on 11/16/23.
//

import Foundation

class MyRegisterPlant:Codable{
    var id:Int?
    var name:String?
    var pot_color:String?
    var user_id:Int?
    var character_id:Character_ID?
    var plant_id:Plant_ID?
}

class Character_ID:Codable{
    var angry_emo:String?
    var basic_emo:String?
    var happy_emo:String?
    var id:Int?
    var name:String?
    var sad_emo:String?
}

class Plant_ID:Codable{
    var cntntsNo:Int?
    var cntntsSj:String?
    var growthAra:Int?
    var growthHg:Int?
    var grwhTp:String?
    var grwtve:Int?
    var hd:String?
    var id:Int?
    var ignSeason:String?
    var ignSeasonCode:String?
    var lighttdemanddo:String?
    var managedemanddo:Int?
    var maxHd:Int?
    var maxLt:Int?
    var maxPstPlc:String?
    var maxTp:Int?
    var maxWinterTp:String?
    var minHd:Int?
    var minLt:Int?
    var minPstPlc:Int?
    var minTp:Int?
    var minWinterTp:Int?
    var rtnFileUrl:String?
    var rtnThumbFileUrl:String?
    var toxcty:Int?
    var watercycleAutum:String?
    var watercycleSprng:Int?
    var watercycleSummer:Int?
    var watercycleWinter:Int?
    var winterLwetTp:String?
}
