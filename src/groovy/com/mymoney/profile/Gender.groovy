package com.mymoney.profile

/**
 * Created with IntelliJ IDEA.
 * User: kuldeep1109
 * Date: 6/30/14
 * Time: 4:24 PM
 * To change this template use File | Settings | File Templates.
 */
public enum Gender {

    MALE ('Male'),
    FEMALE ('Female')

    private String name

    private Gender(String name) {
        this.name = name
    }

    public String getName() {
        return this.name
    }
}