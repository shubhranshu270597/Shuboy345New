global class LeadSquaredConfigNew{

     global class ConfigRequest{
    
     @InvocableVariable(required=true)
     global String FirstName;
     
     @InvocableVariable(required=true)
     global String LastName;
     
     @InvocableVariable(required=true)
     global String EmailAddress;
     
     @InvocableVariable(required=true)
     global String Phone;
     
     @InvocableVariable(required=true)
     global String City;
     
    }
    
     @InvocableMethod(label='Lead Squaued Config' description='LeadSquared Config with Process builder.')
     global static void config(List<ConfigRequest> requests) {
        calloutLeadSquared(JSON.serialize(requests));
     }


    public static void calloutLeadSquared(String jsonResults){
        // Your callout logic

    }

}