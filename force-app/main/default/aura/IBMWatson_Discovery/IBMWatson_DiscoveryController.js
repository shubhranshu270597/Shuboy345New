({
    doInit : function(component, event, helper) {
        var action = component.get("c.getSearchResults");
        action.setParams({name: "trailhead"});
        action.setCallback(this, function(data) {
            component.set("v.searchResults", data.getReturnValue());
        });
        $A.enqueueAction(action);
    }
})