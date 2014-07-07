package com.mymoney.profile

import com.mymoney.security.User

class Profile {

    Date createdDate
    Date lastUpdatedDate

    static belongsTo = [
        user: User
    ]

    static constraints = {
        createdDate nullable: false
        lastUpdatedDate nullable: false
        user nullable: false
    }
}
