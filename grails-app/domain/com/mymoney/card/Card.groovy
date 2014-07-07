package com.mymoney.card

import com.mymoney.account.Account

abstract class Card {

    String cardExpiration
    String cardSecurityCode

    static transients = [
        'cardNumber', 'cardBalance', 'cardType'
    ]

    static belongsTo = [
        account: Account
    ]

    static constraints = {
        cardExpiration(nullable: false)
        cardSecurityCode(nullable: false)
        account(nullable: false, unique: true)
    }

    public abstract Double getCardBalance();
    public abstract CardType getCardType();

    public String getCardNumber() {
        return ((Account) this.account).accountNumber
    }
}
