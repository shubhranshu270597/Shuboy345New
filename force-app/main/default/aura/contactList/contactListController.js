({
        handleNext: function (component, event, helper) {
            var details = event.getParams();
            console.log('Details ', JSON.stringify(details.testmsg));
        },
        handlePrevious: function (component, event, helper) {
            var details = event.getParams('testmsg');
            console.log('Details ', details);
        }
    })