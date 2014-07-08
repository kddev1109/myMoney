package com.mymoney.alert

import com.mymoney.security.User

class Alert {

    String alertHeading
    String alertBody

    User alertRecipient

    String alertLink

    Boolean dismissed = false

    String actions

    static constraints = {
        alertHeading(nullable: false)
        alertBody(nullable: false)
        alertRecipient(nullable: false)
        alertLink(nullable: true)
        actions(nullable: true, maxSize: 1000)
        dismissed(nullable: true)
    }
}
