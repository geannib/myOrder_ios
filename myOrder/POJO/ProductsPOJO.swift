//
//  ProductsPOJO.swift
//  myOrder
//
//  Created by Geanni Barbulescu on 12/8/20.
//  Copyright © 2020 Geanni Barbulescu. All rights reserved.
//

import Foundation


@SerializedName("store_product.Id")
@Expose
public Integer id;
@SerializedName("store_product.CodeEAN")
@Expose
public long CodeEAN;
@SerializedName("store_product.TVA")
@Expose
public long TVA;
@SerializedName("store_product.PackageUnits")
@Expose
public long PackageUnits;
@SerializedName("store_product.MaxSellingQuantity")
@Expose
public long MaxSellingQuantity;
@SerializedName("store_product.Name")
@Expose
public String name;
@SerializedName("store_product.Description")
@Expose
public Object description;
@SerializedName("store_product.Price")
@Expose
public double price;
@SerializedName("store_product.Image")
@Expose
public Object image;

@SerializedName("store_product.Idstoreproductsubcategory")
@Expose
public long idstoreproductsubcategory;
@SerializedName("store_category.Label")
@Expose
public String categoryLabel;


@SerializedName("store_product.PackageMode")
@Expose
public long packageMode;

@SerializedName("store_category.Id")
@Expose
public long categoryId;

@SerializedName("store.Id")
@Expose
public long storeId;

@SerializedName(" store.Name")
@Expose
public long storeName;
