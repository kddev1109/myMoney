package com.mymoney.card

public enum CardType {

    VISA ('Visa'),
    MASTERCARD ('Master Card'),
    DISCOVER ('Discover'),
    AMEX ('American Express')

    private String name

    private CardType(String name) {
        this.name = name
    }

    public String getName() {
        return name
    }
}