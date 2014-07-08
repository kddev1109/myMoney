package com.mymoney.alert

import com.mymoney.config.MyMoneyConstants

class AlertAction {

    private String actionText
    private String actionLink
    private AlertActionClass actionClass

    public AlertAction(String actionText, String actionLink, AlertActionClass actionClass) {
        this.actionText = actionText
        this.actionLink = actionLink
        this.actionClass = actionClass
    }

    public String getActionText() {
        return actionText
    }

    public String getActionLink() {
        return actionLink
    }

    public AlertActionClass getActionClass() {
        return actionClass
    }

    public static String parseActionTextFromActionString(String actionString) {
        return actionString.tokenize(MyMoneyConstants.ACTION_SEPARATOR)[0]
    }

    public static String parseActionLinkFromActionString(String actionString) {
        return actionString.tokenize(MyMoneyConstants.ACTION_SEPARATOR)[1]
    }

    public static AlertActionClass parseActionClassFromActionString(String actionString) {
        return AlertActionClass.values().find { it.name.equals(actionString.tokenize(MyMoneyConstants.ACTION_SEPARATOR)[2]) }
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder()

        sb.append(actionText).append(MyMoneyConstants.ACTION_SEPARATOR).append(actionLink).append(MyMoneyConstants.ACTION_SEPARATOR).append(actionClass.name)
    }
}
