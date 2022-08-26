({
    doInit: function (component, event, helper) {
        var parameters = component.get('v.parameters');
        console.log('parameters ' + JSON.stringify(parameters) + ' Config Id ' + parameters.TPConfig);
        if(parameters.TPConfig){
            helper.getTripPandaConfigurations(component);
        }
        if(parameters.id){
            helper.getUserDetails(component);
        }
    },
    addComment: function (component, event, helper){
        var comments = component.find("commentinput").get("v.value");
        var TpCongId = component.get('v.TpCongId');
        console.log('comments ' + comments);
        var parameters = component.get('v.parameters');
        if (comments && parameters.id && TpCongId){
            var action = component.get('c.addCommentsForStroryLine');
            action.setParams({
                tpConfigId: TpCongId,
                tpUserId: parameters.id,
                Comments: comments
            });
            action.setCallback(this, function (response) {
                var state = response.getState();
                console.log('state ' + state);

                if (state === 'SUCCESS') {
                    var message = response.getReturnValue();
                    component.set('v.successFound', true);
                    component.set('v.successMsg', message);
                    component.set('v.comments',null);
                    helper.getStoryTimeline(component);
                } else if (state === "INCOMPLETE") {
                    component.set('v.warningFound', true);
                    component.set('v.warningMsg', 'Response is Incompleted');
                } else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            component.set('v.errorFound', true);
                            component.set('v.errorMsg', 'Something went wrong');
                        }
                    } else {
                        component.set('v.errorFound', true);
                        component.set('v.errorMsg', 'Unknown error');
                    }
                }
            });
            $A.enqueueAction(action);
        }else{
            component.set('v.warningFound', true);
            component.set('v.warningMsg', 'Parameters are missing');
        }
    },
    addReimbursement:function(component, event, helper){
        var reimbursement = component.get('v.reimbursement');
        //alert("reimbursement "+JSON.stringify(reimbursement));
        var parameters = component.get('v.parameters');
        var trip = component.get('v.tpConfig');
        var selectedtpusers = component.get('v.selectedtpusers');
        var reimbursementList = component.get('v.reimbursementList');
        var userString = selectedtpusers.toString();
       // alert('userString '+userString);
        let arrayOfUsers = userString ? userString.split(','): [];
        var reimbursementList2 = [];
        
        //alert("True "+arrayOfUsers +' length '+arrayOfUsers.length);
        if(arrayOfUsers.length > 0){
            // var reimburobject = reimbursement;
            arrayOfUsers.forEach(element => {
                let cloneReObj = Object.assign({}, reimbursement);
                cloneReObj.TripPandaMemberName__c = element;
                reimbursementList2.push(cloneReObj);
            });
            
            component.set('v.reimbursementList',reimbursementList2);
            
        }
        // else{
        //     // alert("False " +selectedtpusers);
        //     var reimburobject = reimbursement;
        //     // alert("reimburobject before "+JSON.stringify(reimburobject));
        //     reimburobject.TripPandaMemberName__c = selectedtpusers[0];
        //     component.set('v.reimbursement',reimburobject);
        //     reimbursementList2.push(reimburobject);
        //     component.set('v.reimbursementList',reimbursementList2);
        //     // alert("reimburobject after "+JSON.stringify(component.get('v.reimbursementList')));
        // }
        console.log('reimbursementList ' + JSON.stringify(component.get('v.reimbursementList')));
        if (reimbursementList) {
            var action = component.get('c.saveDetails');
            action.setParams({
                reimbur: component.get('v.reimbursementList'),
                tpuserId: parameters.id,
                tripName: trip.Trip_Title__c
            });
            action.setCallback(this, function (response) {
                var state = response.getState();
                console.log('state ' + state);

                if (state === 'SUCCESS') {
                    var message = response.getReturnValue();
                    component.set('v.successFound', true);
                    component.set('v.successMsg', message);
                    // component.set('v.reimbursement', "{\'sobjectType\':\'Reimbursement__c\',\'Amount__c\': '', \'Description__c\': '', \'Other_Type__c\': '', \'Reimbursement_name__c\': '', \'TripPandaMemberName__c\': '', \'TripPandaUser__c\': '', \'User_Email__c\': ''}");
                    // component.set('v.reimbursement',null);
                    location.reload();
                } else if (state === "INCOMPLETE") {
                    component.set('v.warningFound', true);
                    component.set('v.warningMsg', 'Response is Incompleted');
                } else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            component.set('v.errorFound', true);
                            component.set('v.errorMsg', 'Something went wrong');
                        }
                    } else {
                        component.set('v.errorFound', true);
                        component.set('v.errorMsg', 'Unknown error');
                    }
                }
            });
            $A.enqueueAction(action);
        } else {
            component.set('v.warningFound', true);
            component.set('v.warningMsg', 'Parameters are missing');
        }
    },
    addCommentForStoryLine: function (component, event, helper) {
        var addCommentShow = component.get('v.addCommentShow');
        if (addCommentShow) {
            component.set('v.addCommentShow',false);
        }else{
            component.set('v.addCommentShow', true);
        }  
    },
    showOtherType:function(component, event, helper){
        var retype = component.find('retype').get('v.value');
        console.log('retype ' + retype);
        if (retype === 'Others') {
            component.set('v.reOtherType', true);
        } else {
            component.set('v.reOtherType', false);
        }  
    },
    showProfileImageSection: function(component, event, helper) {
        let value = event.currentTarget.dataset.value;
        console.log('value ==> ' + value);
        var tpuserConfigObject = component.get('v.tpUserConfig');
        tpuserConfigObject.forEach(element => {
            if (element.value.TripPandaUser__r.Id === value) {
                if (!element.mouseover){
                    element.mouseover = true;
                }else{
                    element.mouseover = false;
                }
            }else if(element.mouseover){
                element.mouseover = false;
            }
        });
        component.set('v.tpUserConfig', tpuserConfigObject);
        // console.log(JSON.stringify(component.get('v.tpUserConfig')));
    },
    addIntoSelectedTpUsers: function(component,event,helper){
        var selectedOptionValue = event.getParam("value");
        //alert("Option selected with value: '" + selectedOptionValue.toString() + "'");
        component.set('v.selectedtpusers',selectedOptionValue.toString());
        //alert("selectedtpusers "+JSON.stringify(component.get('v.selectedtpusers')));
    },
    SignOut: function(component,event,helper){
        let retVal = confirm("Are you sure want to Sign-Out?");
        var LoginPageName = component.get('v.LoginPageName');
        if( retVal == true ) {
           console.log("User wants to continue! "+LoginPageName);
           window.location.replace("https://vaasaportal-developer-edition.ap4.force.com/"+LoginPageName);
        } else {
           console.log("User does not want to continue!");
        }
    },
    afterScriptsLoaded: function(component,event,helper){
        //alert("script loaded...");
        console.log("sharethis loaded....");
    },
    showShareSection: function (component, event, helper) {
        var sharethis = component.get('v.sharethis');
        console.log('sharethis '+sharethis);
        if (sharethis) {
            component.set('v.sharethis',false);
        }else{
            component.set('v.sharethis', true);
        }  
    }
})