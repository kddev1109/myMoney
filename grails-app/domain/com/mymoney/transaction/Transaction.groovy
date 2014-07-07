package com.mymoney.transaction

import com.mymoney.account.Account

class Transaction {

    UUID transactionID

    Date transactionDate

    Double transactionAmount

    TransactionCategory transactionCategory
    TransactionType transactionType
    TransactionDirection transactionDirection
    TransactionStatus transactionStatus

    Account transactionAccount

    static constraints = {
        transactionID(nullable: false, blank: false, unique: true)
        transactionDate(nullable: false)
        transactionAmount(nullable: false)
        transactionCategory(nullable: false)
        transactionType(nullable: false)
        transactionDirection(nullable: false)
        transactionStatus(nullable: false)
        transactionAccount(nullable: false)
    }
}
