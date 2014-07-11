(function () {
    var app = angular.module("myMoney", []);

    app.config(function ($httpProvider) {
        $httpProvider.defaults.useXDomain = true;
        delete $httpProvider.defaults.headers.common['X-Requested-With'];
        delete $httpProvider.defaults.headers.common['Content-Type'];
    });

    app.controller("MainController", ['$http', function ($http) {
        var mainCtrl = this;

        this.activeNav = 'Home';

        this.theme = {
            name: 'sapphire',
            title: 'Sapphire'
        };

        this.themeBeforePreview = {};

        this.initController = function (activeNav, initThemeUrl) {
            this.activeNav = activeNav;
            $http.post(initThemeUrl).success(function (data) {
                mainCtrl.theme = data;
            });
        }

        this.logout = function (url, redirectUrl) {
            $http.post(url).success(function (data) {
                window.location.href = redirectUrl
            });
        }

        this.setActiveNav = function (activeNav) {
            this.activeNav = activeNav;
        }

        this.isActiveNav = function (nav) {
            return (this.activeNav === nav);
        }

        this.previewSelectedTheme = function (themeName, themeTitle) {
            this.themeBeforePreview.name = this.theme.name;
            this.themeBeforePreview.title = this.theme.title;
            this.theme.name = themeName;
            this.theme.title = themeTitle;
        }

        this.resetTheme = function() {
            this.theme.name = this.themeBeforePreview.name;
            this.theme.title = this.themeBeforePreview.title;
        }

        this.savePreviewedTheme = function (url) {
            $http.post(url, { theme: this.theme.name }).success(function(data) {

            });
        }
    }]);

    app.controller("LoginController", function () {
        this.j_username = null;
        this.j_password = null;
    });

    app.controller("RegistrationController", ['$http', function ($http) {
        var registrationCtrl = this;

        this.pageLoad = true;

        this.phoneCountry = 'US';

        this.familyMemberRequestDetails = {};

        this.initFamilyMemberRequest = function (requestDetails) {
            this.familyMemberRequestDetails = JSON.parse(requestDetails);
        }

        this.familyHasMembers = function () {
            return (this.familyMemberRequestDetails.familyMembers.length > 0);
        }

        this.familyMemberRequestDecision = function (url) {
            $http.post(url).success(function (data) {
                window.location.href = data.redirectUrl;
            });
        }

        this.isFormInvalid = {
            usernameCheck: false,
            emailCheck: false,
            passwordMatchCheck: false
        };

        this.profileDetails = {
            country: 'US'
        };

        this.individualsLookedUp = {
            individuals: []
        };

        this.familyMemberRequests = [];

        this.familyMemberRequestInFocus = "";

        this.hideUsernameUnavailable = true;
        this.showUsernameAvailable = false;

        this.profileDetails.profileType = 'Individual';
        this.profileDetails.familyMemberLookup = null;

        this.setProfileType = function (profileType) {
            this.profileDetails.profileType = profileType;
        }

        this.isIndividualProfileType = function () {
            return (this.profileDetails.profileType === 'Individual');
        };

        this.isFamilyProfileType = function () {
            return (this.profileDetails.profileType === 'Family');
        };

        this.setGender = function (gender) {
            this.profileDetails.gender = gender;
        };

        this.isMale = function () {
            return (this.profileDetails.gender === 'Male');
        };

        this.isFemale = function () {
            return (this.profileDetails.gender === 'Female');
        };

        this.doNotDisplayCheckUsernameAvailability = function () {
            return (angular.isUndefined(this.profileDetails.username) || (this.profileDetails.username.length == 0));
        }

        this.checkUsernameAvailability = function (url) {
            $http.post(url, { 'username': this.profileDetails.username }).success(function (data) {
                if (data.isAvailable == true || data.isAvailable === 'true') {
                    registrationCtrl.setUsernameAvailable();
                }
                else {
                    registrationCtrl.setUsernameUnavailable();
                }
            });
        }

        this.setUsernameAvailable = function () {
            this.showUsernameAvailable = true;
            this.hideUsernameUnavailable = true;
            this.isFormInvalid.usernameCheck = false;
        }

        this.setUsernameUnavailable = function () {
            this.showUsernameAvailable = false;
            this.hideUsernameUnavailable = false;
            this.isFormInvalid.usernameCheck = true;
        }

        this.checkEmailAvailability = function (url) {
            if (!angular.isUndefined(this.profileDetails.email)) {
                $http.post(url, { 'email': this.profileDetails.email }).success(function (data) {
                    if (data.isAvailable == true || data.isAvailable === 'true') {
                        registrationCtrl.setEmailAvailable();
                    }
                    else {
                        registrationCtrl.setEmailUnavailable();
                    }
                });
            }
            else {
                registrationCtrl.setEmailAvailable();
            }
        }

        this.setEmailAvailable = function () {
            this.isFormInvalid.emailCheck = false;
        }

        this.setEmailUnavailable = function () {
            this.isFormInvalid.emailCheck = true;
        }

        this.doNotDisplayUsernameUnavailable = function () {
            return (this.hideUsernameUnavailable == true);
        }

        this.displayUsernameAvailable = function () {
            return (this.showUsernameAvailable == true);
        }

        this.arePasswordsBlank = function () {
            return ((angular.isUndefined(this.profileDetails.password) || this.profileDetails.password === null || this.profileDetails.password === "") &&
                    (angular.isUndefined(this.profileDetails.confirmPassword) || this.profileDetails.confirmPassword === null || this.profileDetails.confirmPassword === ""))
        }

        this.checkPasswords = function () {
            this.isFormInvalid.passwordMatchCheck = (this.profileDetails.password !== this.profileDetails.confirmPassword);
        }

        this.lookupFamilyMember = function (url) {
            this.pageLoad = false;
            this.individualsLookedUp = {
                individuals: []
            };

            if (this.familyMemberLookup !== null && this.familyMemberLookup !== "" && !angular.isUndefined(this.familyMemberLookup)) {
                $http.post(url, { 'searchString': this.familyMemberLookup }).success(function (data) {
                    registrationCtrl.individualsLookedUp = data;
                });
            }
        }

        this.resetPageLoad = function () {
            this.pageLoad = true;
        }

        this.hasIndividuals = function () {
            return (registrationCtrl.individualsLookedUp.individuals.length > 0);
        }

        this.addFamilyMember = function (individual) {
            if (this.familyMemberRequests.indexOf(individual) == -1) {
                this.familyMemberRequests.push(individual);
            }
        }

        this.removeFamilyMember = function (individual) {
            var index = this.familyMemberRequests.indexOf(individual);

            if (index > -1) {
                this.familyMemberRequests.splice(index, 1);
                this.familyMemberRequestInFocus = "";
            }
        }

        this.setFamilyMemberRequestInFocus = function (familyMemberRequest) {
            this.familyMemberRequestInFocus = familyMemberRequest;
        }

        this.resetFamilyMemberRequestInFocus = function () {
            this.familyMemberRequestInFocus = "";
        }

        this.isFamilyMemberRequestInFocus = function (familyMemberRequest) {
            return (this.familyMemberRequestInFocus !== null && this.familyMemberRequestInFocus !== "" && (this.familyMemberRequestInFocus === familyMemberRequest))
        }

        this.familyMemberAlreadyAdded = function (individual) {
            return (this.familyMemberRequests.indexOf(individual) > -1);
        }

        this.submitRegistration = function (url, redirectUrl) {
            if (this.profileDetails.dateOfBirth !== null && this.profileDetails.dateOfBirth !== "" && !angular.isUndefined(this.profileDetails.dateOfBirth)) {
                this.profileDetails.dateOfBirth = Date.parse(this.profileDetails.dateOfBirth);
            }

            if (this.profileDetails.country != null && this.profileDetails.country != "" && !angular.isUndefined(this.profileDetails.country)) {
                this.profileDetails.countryName = BFHCountriesList[this.profileDetails.country];
            }

            this.profileDetails.familyMemberRequests = this.familyMemberRequests;

            $http.post(url, this.profileDetails).success(function (data) {
                window.location.href = redirectUrl
            });
        }

        this.checkIfFormIsInvalid = function () {
            return (this.isFormInvalid.usernameCheck || this.isFormInvalid.emailCheck || this.isFormInvalid.passwordMatchCheck);
        }
    }]);

    app.controller('ProfileController', ['$http', function ($http) {
        var profileCtrl = this;

        this.invalidCurrentPassword = false;

        this.editMode = {
            individualUserInformation: false,
            contactInformation: false
        };

        this.profileDetailsProperties = {};
        this.changePassword = false;

        this.initProfileDetailsProperties = function (profileDetailsProperties) {
            this.profileDetailsProperties = JSON.parse(profileDetailsProperties);
        }

        this.showChangePasswordWell = function () {
            this.invalidCurrentPassword = false;
            this.changePassword = true;
        }

        this.hideChangePasswordWell = function () {
            this.invalidCurrentPassword = false;
            this.changePassword = false;
        }

        this.updatePassword = function (verifyPasswordUrl, updatePasswordUrl, redirectUrl) {
            if (angular.isDefined(this.currentPassword)) {
                var _data = {
                    username: this.profileDetailsProperties.accountInformation[0].value,
                    currentPassword: this.currentPassword
                };

                $http.post(verifyPasswordUrl, _data).success(function (data) {
                    if (data.valid === true || data.valid === 'true' && (profileCtrl.newPassword === profileCtrl.confirmNewPassword)) {
                        var _data2 = {
                            password: profileCtrl.newPassword
                        };
                        $http.post(updatePasswordUrl, _data2).success(function (data1) {
                            profileCtrl.invalidCurrentPassword = false;
                            window.location.href = redirectUrl;
                        });
                    }
                    else {
                        profileCtrl.invalidCurrentPassword = true;
                    }
                });
            }
        }

        this.editIndividualUserInformation = function () {
            this.editMode.individualUserInformation = true;
            this.setGender(this.profileDetailsProperties.individualUserInformation[2].value);
        }

        this.saveIndividualUserInformation = function () {
            this.editMode.individualUserInformation = false;
        }

        this.cancelIndividualUserInformation = function () {
            this.editMode.individualUserInformation = false;
        }

        this.isMale = function () {
            return (this.profileDetailsProperties.individualUserInformation[2].value === 'Male')
        }

        this.isFemale = function () {
            return (this.profileDetailsProperties.individualUserInformation[2].value === 'Female')
        }

        this.setGender = function (gender) {
            this.gender = gender;
        }

        this.editContactInformation = function () {
            this.editMode.contactInformation = true;
        }

        this.saveContactInformation = function () {
            this.editMode.contactInformation = false;
        }

        this.cancelContactInformation = function () {
            this.editMode.contactInformation = false;
        }

        this.deactivateProfile = function () {
            console.debug('deactivateProfile');
        }

        this.deleteProfile = function () {
            console.debug('deleteProfile');
        }
    }]);

    app.controller('HomeController', function () {
        this.activeSubNav = 'Dashboard';

        this.initController = function (activeSubNav) {
            this.activeSubNav = activeSubNav;
        }

        this.setActiveSubNav = function (activeSubNav) {
            this.activeSubNav = activeSubNav;
        }

        this.isActiveSubNav = function (subNav) {
            return (this.activeSubNav === subNav);
        }
    });

    app.controller('AlertController', ['$http', function ($http) {
        var alertCtrl = this;

        this.alerts = [];

        this.alertIndex = -1;
        this.currentAlert = null;

        this.previousAlertDisabled = true;
        this.nextAlertDisabled = true;

        this.initController = function (alertsUrl) {
            this.getAlerts(alertsUrl);
        }

        this.getAlerts = function (url) {
            $http.post(url).success(function (data) {
                alertCtrl.alerts = data.alerts;
                if (alertCtrl.alerts.length > 0) {
                    alertCtrl.alertIndex = 0;
                    alertCtrl.currentAlert = alertCtrl.alerts[alertCtrl.alertIndex];
                    if (alertCtrl.alerts.length > 1) {
                        alertCtrl.nextAlertDisabled = false;
                    }
                }
            });
        }

        this.nextAlert = function () {
            this.alertIndex++;
            this.currentAlert = this.alerts[this.alertIndex];

            if (this.alertIndex == (this.alerts.length - 1)) {
                this.nextAlertDisabled = true;
            }

            this.previousAlertDisabled = false;
        }

        this.previousAlert = function () {
            this.alertIndex--;
            this.currentAlert = this.alerts[this.alertIndex];

            if (this.alertIndex == 0) {
                this.previousAlertDisabled = true;
            }

            this.nextAlertDisabled = false;
        }

        this.processAlertAction = function (actionText, dismissUrl) {
            var actionTexts = [];

            angular.forEach(this.currentAlert.actions, function (action) {
                actionTexts.push(action.text);
            });

            var actionIndex = actionTexts.indexOf(actionText);

            if (actionIndex > -1) {
                $http.post(this.currentAlert.actions[actionIndex].link).success(function (data) {
                    alertCtrl.dismissCurrentAlert(dismissUrl);
                });
            }
        }

        this.dismissCurrentAlert = function (dismissUrl) {
            this.alerts.splice(this.alertIndex, 1);

            $http.post(dismissUrl, { id: this.currentAlert.id }).success(function (data) {
                if (alertCtrl.alerts.length > 0) {
                    alertCtrl.alertIndex = 0;
                    alertCtrl.currentAlert = alertCtrl.alerts[alertCtrl.alertIndex];
                }
                else {
                    alertCtrl.currentAlert = null;
                }
            });
        }
    }]);

    app.controller('BankAccountController', ['$http', function ($http) {
        var bankAccountCtrl = this;

        this.accountDetails = {};
        this.accountTypes = [];

        this.initController = function (accountTypes) {
            this.accountTypes = JSON.parse(accountTypes);
        }
    }]);
})();