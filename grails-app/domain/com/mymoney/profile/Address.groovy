package com.mymoney.profile

class Address {

    String line1
    String line2

    String city
    String state
    String zipCode

    Country country

    static belongsTo = [
        individual: IndividualProfile
    ]

    static constraints = {
        line1(nullable: false, blank: false)
        line2(nullable: true)
        city(nullable: false)
        state(nullable: false)
        zipCode(nullable: false)
        country(nullable: false)
        individual(nullable: true)
    }
}
