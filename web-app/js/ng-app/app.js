(function () {
    var app = angular.module("myMoney", []);

    app.config(function ($httpProvider) {
        $httpProvider.defaults.useXDomain = true;
        delete $httpProvider.defaults.headers.common['X-Requested-With'];
        delete $httpProvider.defaults.headers.common['Content-Type'];
    });

    app.controller("MainController", ['$http', function ($http) {
        this.activeNav = 'Home';

        this.initActiveNav = function (activeNav) {
            this.activeNav = activeNav;
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
    }]);

    app.controller("LoginController", function () {
        this.j_username = null;
        this.j_password = null;
    });

    app.controller("RegistrationController", ['$http', function ($http) {
        var registrationCtrl = this;

        this.pageLoad = true;

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

        this.profileDetails = {};
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
                $http.post(verifyPasswordUrl,
                           { username: this.profileDetailsProperties.accountInformation[0].value, currentPassword: this.currentPassword }).success(function (data) {
                                                                                                                                                       if (data.valid === true || data.valid === 'true' && (profileCtrl.newPassword === profileCtrl.confirmNewPassword)) {
                                                                                                                                                           $http.post(updatePasswordUrl,
                                                                                                                                                                      { password: profileCtrl.newPassword }).success(function (data1) {
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

        this.deactivateProfile = function() {
            console.debug('deactivateProfile');
        }

        this.deleteProfile = function() {
            console.debug('deleteProfile');
        }
    }]);

    app.controller('HomeController', ['$http', function ($http) {
        var homeCtrl = this;

        this.alerts = [];

        this.alertIndex = -1;
        this.currentAlert = null;

        this.previousAlertDisabled = true;
        this.nextAlertDisabled = true;

        this.initHome = function (alertsUrl) {
            this.getAlerts(alertsUrl);
        }

        this.getAlerts = function (url) {
            $http.post(url).success(function (data) {
                homeCtrl.alerts = data.alerts;
                if (homeCtrl.alerts.length > 0) {
                    homeCtrl.alertIndex = 0;
                    homeCtrl.currentAlert = homeCtrl.alerts[homeCtrl.alertIndex];
                    if (homeCtrl.alerts.length > 1) {
                        homeCtrl.nextAlertDisabled = false;
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
                    homeCtrl.dismissCurrentAlert(dismissUrl);
                });
            }
        }

        this.dismissCurrentAlert = function (dismissUrl) {
            this.alerts.splice(this.alertIndex, 1);

            $http.post(dismissUrl, { id: this.currentAlert.id }).success(function (data) {
                if (homeCtrl.alerts.length > 0) {
                    homeCtrl.alertIndex = 0;
                    homeCtrl.currentAlert = homeCtrl.alerts[homeCtrl.alertIndex];
                }
                else {
                    homeCtrl.currentAlert = null;
                }
            });
        }
    }]);
})();