package mymoney

import grails.plugin.springsecurity.annotation.Secured

class HomeController {

    @Secured(['ROLE_INDIVIDUAL', 'ROLE_FAMILY'])
    def index() {
        render(view: '/home/homePage', model: [activeNav: 'Home', template: '/home/dashboard'])
    }
}
