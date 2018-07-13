({
    doInit: function(component, event, helper) {
        component.set('v.columns', [
            {label: 'Name', fieldName: 'Name', type: 'text'},
            {label: 'Rating', fieldName: 'Rating', type: 'text'},
            {label: 'Industry', fieldName: 'Industry', type: 'text'},
            {label: 'Phone', fieldName: 'Phone', type: 'phone'}
        ]);
        // Fetch the account list from the Apex controller
        helper.getAccountList(component);
    }
    
})