//
//  Auth.swift
//  Hey_Groot
//
//  Created by 황수비 on 2023/08/20.
//

import Foundation


class Auth {
    static let token = Auth()
    var accessToken : String = "access"
    var refreshToken : String = "refresh"
    var user:User?
}
