package com.mymoney.profile

class Country {

    String shortName
    String name

    static constraints = {
        shortName(nullable: false, unique: true)
        name(nullable: false, unique: true)
    }
}
