package com.mymoney.config

import com.mymoney.profile.Theme

/**
 * Created with IntelliJ IDEA.
 * User: kuldeep1109
 * Date: 7/2/14
 * Time: 1:53 PM
 * To change this template use File | Settings | File Templates.
 */
public interface MyMoneyConstants {

    public final Theme THEME_DEFAULT = Theme.SAPPHIRE

    public final String FAMILY_MEMBER_REQUEST_HEADING = 'Family Member Request: '
    public final int FAMILY_MEMBER_REQUEST_TIMEOUT = 30

    public final String AUTHORITY_ROLE_INDIVIDUAL = 'ROLE_INDIVIDUAL'
    public final String AUTHORITY_ROLE_FAMILY = 'ROLE_FAMILY'

    public final String ACTION_SEPARATOR = '|'
    public final String ACTIONS_SEPARATOR = ';'
}