({  
    doInit : function(component,event , helper){
        setInterval(
            function () { 
                var successFlag = component.get('v.successFound');
                var errorFlag = component.get('v.errorFound');
                var warningFlag = component.get('v.warningFound');

                if(successFlag){
                    component.set('v.successFound',false);
                } else if (errorFlag){
                    component.set('v.errorFound', false);
                } else if (warningFlag){
                    component.set('v.warningFound', false);
                }
            }, 5000
        );
    },
    closeSuccessMessage : function(component, event, helper) {
        var successFlag = component.get('v.successFound');
        if(successFlag){
            component.set('v.successFound',false);
        }else{
            component.set('v.successFound',true);
        }
    },
    closeErrorMessage: function (component, event, helper) {
        var successFlag = component.get('v.errorFound');
        if (successFlag) {
            component.set('v.errorFound', false);
        } else {
            component.set('v.errorFound', true);
        }
    },
    closeWarningMessage: function (component, event, helper) {
        var successFlag = component.get('v.warningFound');
        if (successFlag) {
            component.set('v.warningFound', false);
        } else {
            component.set('v.warningFound', true);
        }
    }
})