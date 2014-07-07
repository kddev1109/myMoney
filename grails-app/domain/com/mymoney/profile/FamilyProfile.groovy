package com.mymoney.profile

class FamilyProfile extends Profile {

    String familyName

    static hasMany = [
        familyMembers: IndividualProfile
    ]

    static constraints = {
        familyName nullable: false, blank: false
        familyMembers nullable: true
    }
}
