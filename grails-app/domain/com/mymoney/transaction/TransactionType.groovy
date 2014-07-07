package com.mymoney.transaction

class TransactionType {

    String name
    String description

    TransactionType baseType

    static constraints = {
        name(nullable: false, blank: false, unique: true)
        description(nullable: false, blank: false)
        baseType(nullable: true)
    }
}
