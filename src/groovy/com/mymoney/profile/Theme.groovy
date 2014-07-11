package com.mymoney.profile

public enum Theme {

    WINE ('wine', 'Wine'),
    RAINFOREST ('rainforest', 'Rain Forest'),
    SAPPHIRE ('sapphire', 'Sapphire'),
    COTTON_CANDY ('cotton-candy', 'Cotton Candy'),
    IVORY ('ivory', 'Ivory'),
    MONOCHROME ('monochrome', 'Monochrome')

    private String name
    private String title

    private Theme (String name, String title) {
        this.name = name
        this.title = title
    }

    public String getName() {
        return this.name
    }

    public String getTitle() {
        return this.title
    }
}