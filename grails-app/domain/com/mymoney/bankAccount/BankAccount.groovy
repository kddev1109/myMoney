package com.mymoney.bankAccount

import com.mymoney.profile.IndividualProfile

class BankAccount {

    String accountNumber

    Date dateOpened

    BankAccountType accountType

    String accountCurrency

    Double accountBalance

    static hasMany = [
        accountHolders: IndividualProfile
    ]

    static constraints = {
        accountNumber(nullable: false, unique: true)
        dateOpened(nullable: false)
        accountType(nullable: false)
        accountBalance(nullable: false)
        accountCurrency(nullable: false)
        accountHolders(nullable: false, minSize: 1)
    }
}
