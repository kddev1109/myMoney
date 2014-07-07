package com.mymoney.profile

class IndividualProfile extends Profile {

    String firstName
    String lastName

    Gender gender

    Date dateOfBirth

    Address address

    String email
    String phone

    static transients = [
        'name'
    ]

    static constraints = {
        firstName nullable: false, blank: false
        lastName nullable: true
        gender nullable: false
        dateOfBirth nullable: true
        address nullable: true
        email nullable: false, unique: true
        phone nullable: true
    }

    public String getName() {
        return lastName ? "${firstName} ${lastName}" : firstName
    }
}
