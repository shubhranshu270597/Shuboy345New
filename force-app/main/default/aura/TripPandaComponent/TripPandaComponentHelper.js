({
    getTripPandaConfigurations: function (component) {
        var parameters = component.get('v.parameters');
        console.log(parameters.TPConfig);

        var action = component.get('c.getTPConfiguration');
        action.setParams({
            tpConfigId: parameters.TPConfig
        });
        action.setCallback(this, function (response) {
            var state = response.getState();
            console.log('state ' + state);

            if (state === 'SUCCESS') {
                var TpConfigObject = response.getReturnValue();
                console.dir('obj ' + JSON.stringify(TpConfigObject));
                component.set('v.tpConfig', response.getReturnValue());
                component.set('v.tpConfigFound', true);
                if(TpConfigObject){
                    component.set('v.TpCongId', TpConfigObject.Id);
                    component.set('v.LoginPageName', TpConfigObject.LoginPage_Name__c);
                    var imageName = [TpConfigObject.StaticResourceImageName1__c, TpConfigObject.StaticResourceImageName2__c, TpConfigObject.StaticResourceImageName3__c];
                    var imageHeader = [TpConfigObject.HeaderImageName1__c, TpConfigObject.HeaderImageName2__c, TpConfigObject.HeaderImageName3__c];
                    var imageAltText = [TpConfigObject.StaticResourceImageName1__c, TpConfigObject.StaticResourceImageName2__c, TpConfigObject.StaticResourceImageName3__c];
                    component.set('v.ImageName', imageName);
                    console.log(component.get("v.ImageName"));
                    component.set('v.ImageHeader', imageHeader);
                    console.log(component.get("v.ImageHeader"));
                    component.set('v.ImageAltText', imageAltText);
                    console.log(component.get("v.ImageAltText"));
                    // component.set('v.successFound', true);
                    // component.set('v.successMsg', 'Configuration found');
                    if(TpConfigObject.Id){
                        this.getTpUserConfiguration(component);
                        this.getStoryTimeline(component);
                        this.getReimbursement(component);
                        this.getReimbursementRaise(component);
                        this.getReimbursementPayments(component);
                    }
                    var childComp = component.find('childComp');
                    childComp.callChild();
                }

            } else if (state === "INCOMPLETE") {
                component.set('v.warningFound',true);
                component.set('v.warningMsg','Response is Incompleted');
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        component.set('v.errorFound', true);
                        component.set('v.errorMsg', 'Configuration not found');
                    }
                } else {
                    component.set('v.errorFound', true);
                    component.set('v.errorMsg', 'Unknown error');
                }
            }
        });
        $A.enqueueAction(action);
    },
    getTpUserConfiguration: function (component) {
        var tpConfigId = component.get('v.TpCongId');
        // console.log('tpConfigId ' + tpConfigId);
        var action = component.get('c.getTPUserConfiguration');
        action.setParams({
            tpConfigId: tpConfigId
        });
        action.setCallback(this, function (response) {
            var state = response.getState();
            console.log('state ' + state);
            let aarayofTpUserConfigObject = [];
            let tpuserOptions = [];
            if (state === 'SUCCESS') {
                var TpUserConfigObject = response.getReturnValue();
                for (let key in TpUserConfigObject) {
                    // Preventing unexcepted data 
                    if (TpUserConfigObject.hasOwnProperty(key)) {
                        // Filtering the data in the loop
                        aarayofTpUserConfigObject.push({ value: TpUserConfigObject[key], key:key, mouseover: false});
                        tpuserOptions.push({ label: TpUserConfigObject[key].TripPandaUser__r.TP_Name__c, value: TpUserConfigObject[key].TripPandaUser__r.Id});
                    }
                }
                component.set('v.tpUserConfigFound',true);
                console.dir('obj ' + JSON.stringify(aarayofTpUserConfigObject));
                console.dir('tpuserOptions ' + JSON.stringify(tpuserOptions));
                component.set('v.tpusers', tpuserOptions);
                component.set('v.tpUserConfig', aarayofTpUserConfigObject);
                // component.set('v.tpConfigFound', true);
            } else if (state === "INCOMPLETE") {
                component.set('v.warningFound', true);
                component.set('v.warningMsg', 'Response is Incompleted');
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        component.set('v.errorFound', true);
                        component.set('v.errorMsg', 'User Configuration not found');
                    }
                } else {
                    component.set('v.errorFound', true);
                    component.set('v.errorMsg', 'Unknown error');
                }
            }
        });
        $A.enqueueAction(action);
    },
    getStoryTimeline: function(component){
        var tpConfigId = component.get('v.TpCongId');
        // console.log('tpConfigId ' + tpConfigId);
        var action = component.get('c.getStorytimeline');
        action.setParams({
            tpConfigId: tpConfigId
        });
        action.setCallback(this, function (response) {
            var state = response.getState();
            console.log('state ' + state);

            if (state === 'SUCCESS') {
                var TpUserConfigObject = response.getReturnValue();
                component.set('v.storyTimelineFound', true);
                console.dir('obj ' + JSON.stringify(TpUserConfigObject));
                component.set('v.storyTimeline', response.getReturnValue());
                // component.set('v.tpConfigFound', true);
            } else if (state === "INCOMPLETE") {
                component.set('v.warningFound', true);
                component.set('v.warningMsg', 'Response is Incompleted');
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        component.set('v.errorFound', true);
                        component.set('v.errorMsg', 'storyTimeline not found');
                    }
                } else {
                    component.set('v.errorFound', true);
                    component.set('v.errorMsg', 'Unknown error');
                }
            }
        });
        $A.enqueueAction(action);
    },
    getReimbursement: function(component){
        var tpConfig = component.get('v.tpConfig');
        var parameters = component.get('v.parameters');
        var action = component.get('c.getReimbursement');
        action.setParams({
            tpName: tpConfig.Trip_Title__c,
            tpUserId: parameters.id
        });
        action.setCallback(this, function (response) {
            var state = response.getState();
            console.log('state ' + state);

            if (state === 'SUCCESS') {
                var reimbursementObject = response.getReturnValue();
                component.set('v.reimbursementFound', true);
                console.dir('obj ' + JSON.stringify(reimbursementObject));
                component.set('v.reimbursementRecords', response.getReturnValue());
                // component.set('v.tpConfigFound', true);
            } else if (state === "INCOMPLETE") {
                component.set('v.warningFound', true);
                component.set('v.warningMsg', 'Response is Incompleted');
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        component.set('v.errorFound', true);
                        component.set('v.errorMsg', 'Reimbursement not found');
                    }
                } else {
                    component.set('v.errorFound', true);
                    component.set('v.errorMsg', 'Unknown error');
                }
            }
        });
        $A.enqueueAction(action);
    },
    getReimbursementRaise: function(component){
        var tpConfig = component.get('v.tpConfig');
        var parameters = component.get('v.parameters');
        var action = component.get('c.getReimbursementRaised');
        action.setParams({
            tpName: tpConfig.Trip_Title__c,
            tpUserId: parameters.id
        });
        action.setCallback(this, function (response) {
            var state = response.getState();
            console.log('state ' + state);

            if (state === 'SUCCESS') {
                var reimbursementObject = response.getReturnValue();
                component.set('v.reimbursementraiseFound', true);
                console.dir('obj ' + JSON.stringify(reimbursementObject));
                component.set('v.reimbursementraiseRecords', response.getReturnValue());
                // component.set('v.tpConfigFound', true);
            } else if (state === "INCOMPLETE") {
                component.set('v.warningFound', true);
                component.set('v.warningMsg', 'Response is Incompleted');
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        component.set('v.errorFound', true);
                        component.set('v.errorMsg', 'Reimbursement not found');
                    }
                } else {
                    component.set('v.errorFound', true);
                    component.set('v.errorMsg', 'Unknown error');
                }
            }
        });
        $A.enqueueAction(action);
    },
    getReimbursementPayments: function(component){
        var tpConfig = component.get('v.tpConfig');
        var parameters = component.get('v.parameters');
        var action = component.get('c.getReimbursementPaymentDetaisl');
        action.setParams({
            tpName: tpConfig.Trip_Title__c,
            tpUserId: parameters.id
        });
        action.setCallback(this, function (response) {
            var state = response.getState();
            console.log('state ' + state);

            if (state === 'SUCCESS') {
                var reimbursementObject = response.getReturnValue();
                component.set('v.reimbursementFound', true);
                console.dir('obj ' + JSON.stringify(reimbursementObject));
                component.set('v.reimbursementPaymentsRecords', response.getReturnValue());
                // component.set('v.tpConfigFound', true);
            } else if (state === "INCOMPLETE") {
                component.set('v.warningFound', true);
                component.set('v.warningMsg', 'Response is Incompleted');
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        component.set('v.errorFound', true);
                        component.set('v.errorMsg', 'Reimbursement not found');
                    }
                } else {
                    component.set('v.errorFound', true);
                    component.set('v.errorMsg', 'Unknown error');
                }
            }
        });
        $A.enqueueAction(action);
    },
    getUserDetails: function (component) {
        var parameters = component.get('v.parameters');
        var action = component.get('c.getTPuserDetails');
        action.setParams({
            tpUserID: parameters.id
        });
        action.setCallback(this, function (response) {
            var state = response.getState();
            console.log('state ' + state);

            if (state === 'SUCCESS') {
                var TpUserObject = response.getReturnValue();
                // component.set('v.tpUserConfigFound',true);
                console.dir('obj ' + JSON.stringify(TpUserObject));
                component.set('v.tpUser', response.getReturnValue());
                component.set('v.successFound', true);
                component.set('v.successMsg', 'Welcome ' + TpUserObject.TP_Name__c);
            } else if (state === "INCOMPLETE") {
                component.set('v.warningFound', true);
                component.set('v.warningMsg', 'Response is Incompleted');
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        component.set('v.errorFound', true);
                        component.set('v.errorMsg', 'User Configuration not found');
                    }
                } else {
                    component.set('v.errorFound', true);
                    component.set('v.errorMsg', 'Unknown error');
                }
            }
        });
        $A.enqueueAction(action);
    }
})