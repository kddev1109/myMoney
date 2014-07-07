package com.mymoney.account

import com.mymoney.profile.IndividualProfile

class Account {

    String accountNumber

    Date dateOpened

    AccountType accountType

    Double accountBalance

    static hasMany = [
        accountHolders: IndividualProfile
    ]

    static constraints = {
        accountNumber(nullable: false, unique: true)
        dateOpened(nullable: false)
        accountType(nullable: false)
        accountBalance(nullable: false)
    }
}
