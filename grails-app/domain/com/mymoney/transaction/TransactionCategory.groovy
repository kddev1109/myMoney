package com.mymoney.transaction

class TransactionCategory {

    String name
    String description

    TransactionCategory baseCategory

    static constraints = {
        name(nullable: false, blank: false, unique: true)
        description(nullable: false, blank: false)
        baseCategory(nullable: true)
    }
}
