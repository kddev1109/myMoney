package com.mymoney.profile

import com.mymoney.config.MyMoneyConstants
import com.mymoney.security.User

class Profile {

    Date createdDate
    Date lastUpdatedDate

    Theme theme = MyMoneyConstants.THEME_DEFAULT

    static belongsTo = [
        user: User
    ]

    static constraints = {
        createdDate nullable: false
        lastUpdatedDate nullable: false
        user nullable: false
        theme nullable: false
    }
}
