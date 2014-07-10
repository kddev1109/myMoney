package com.mymoney.card

import com.mymoney.bankAccount.BankAccount

class DebitCard extends Card {

    static constraints = {
    }

    @Override
    public Double getCardBalance() {
        return ((BankAccount) super.account).accountBalance
    }

    @Override
    public CardCategory getCardCategory() {
        return CardCategory.DEBIT
    }
}
