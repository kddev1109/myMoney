modules = {
    application {
        resource url: 'js/application.js'
    }

    app {
        dependsOn 'angular'
        resource url: 'js/ng-app/app.js'
    }

    angular {
        resource url: 'js/angular.min.js'
    }

//    overrides {
//        'easygrid-jqgrid-theme' {
//            resource id: 'theme',
//                     url: [dir: "css", file: 'main.css'],
//                     attrs: [media: 'screen, projection']
//        }
//    }
}