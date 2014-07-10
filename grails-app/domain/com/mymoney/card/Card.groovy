package com.mymoney.card

import com.mymoney.bankAccount.BankAccount
import com.mymoney.profile.Address

abstract class Card {

    String cardNumber
    String cardExpiration
    String cardSecurityCode

    CardType cardType

    Address billingAddress

    static transients = [
        'cardBalance', 'cardCategory'
    ]

    static belongsTo = [
        account: BankAccount
    ]

    static constraints = {
        cardNumber(nullable: false, unique: true)
        cardExpiration(nullable: false)
        cardSecurityCode(nullable: false)
        cardType(nullable: false)
        billingAddress(nullable: false)
        account(nullable: false, unique: true)
    }

    public abstract Double getCardBalance();
    public abstract CardCategory getCardCategory();
}
