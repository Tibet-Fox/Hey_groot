


struct ResponseMessage: Codable {
    var message:String
}

struct Plant_info:Codable{
    var id:Int?
    var cntntsNo:Int?
    var cntntsSj:String?
    var rtnFileUrl:String?
    var rtnThumbFileUrl:String?
    
}

class BookMarkPlant_Info:Codable{
    var id:Int?
    var plantinfo:Plant_info?
}

