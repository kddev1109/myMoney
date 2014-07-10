package com.mymoney.card

public enum CardCategory {

    CREDIT('Credit Card'),
    DEBIT('Debit Card'),
    CHECK('Check Card'),
    GIFT('Gift Card')

    private String name

    private CardCategory(String name) {
        this.name = name
    }

    public String getName() {
        return this.name
    }
}