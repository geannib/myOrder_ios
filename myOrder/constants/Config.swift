//
//  Config.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 11/6/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//

import Foundation

let GOOGLE_KEY = "AIzaSyCMoCZwlT2yYX3i2joIThogLwqtXgbqSfg"
let BASE_URL = "https://www.dozo.ro/";
let API_URL = BASE_URL + "clientapi/"

let API_GET_STORES = API_URL + "getStores"
let API_GET_STORE_CATEGORIES = API_URL + "getstorecategories"
let API_GET_PRODUCTS  = API_URL + "getproducts"
let API_SEND_SMS = API_URL + "sendsmscode"
let API_VALIDATE_SMS = API_URL + "validateSMSCode"
let API_SAVE_CART = API_URL + "savecart"

// Images
let API_GET_STORE_IMAGE = API_URL + "getstoreimage"
let API_GET_CATEGORY_IMAGE = API_URL + "getcategoryimage"
let API_GET_PRODUCT_IMAGE = API_URL + "getproductimage"

let kUDToken = "token"
let kUDCart = "myCart"
let kIsPhoneCodSet = "KIsPhoneSet"
let kIsLASet = "KIsLASet"
