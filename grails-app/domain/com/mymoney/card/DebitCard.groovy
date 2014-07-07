package com.mymoney.card

import com.mymoney.account.Account

class DebitCard extends Card {

    static constraints = {
    }

    @Override
    public Double getCardBalance() {
        return ((Account) super.account).accountBalance
    }

    @Override
    public CardType getCardType() {
        return CardType.DEBIT
    }
}
