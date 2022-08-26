/**
 * @File Name          : ZomatoWebService.cls
 * @Description        : 
 * @Author             : shubhranshu
 * @Group              : 
 * @Last Modified By   : shubhranshu
 * @Last Modified On   : 10/10/2019, 2:24:29 AM
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    8/10/2019   shubhranshu     Initial Version
**/
global class ZomatoWebService {

    @AuraEnabled
    public static String getLocation(String locationName){
        String reponse;

        List<ZomatoLocation.location_suggestions> locationList = new List<ZomatoLocation.location_suggestions>();
        //List<Object> locationList1 = new List<Object>();
        
        Http http = new Http();

        String url ='https://developers.zomato.com/api/v2.1/locations';
        url += '?query='+locationName;

        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('user-key', '3e8b235d70f0a4e7f0e5e6feebc29dd0'); // 6f8d243896b9c5b36e765e495b4804cc
        req.setMethod('GET');

        HttpResponse res = http.send(req);
        System.debug('response:--->'+res.getBody());
        reponse = res.getBody();

        if(res.getStatusCode() == 200){
            System.debug('status :--->'+res.getStatus());
            ZomatoLocation.location_suggestions locationClass = new ZomatoLocation.location_suggestions();
            ZomatoLocation jsonapex = ZomatoLocation.parse(reponse);

            System.debug('jsonApex :-->'+jsonapex.location_suggestions);

            for(ZomatoLocation.location_suggestions loc :jsonapex.location_suggestions){
                System.debug('location details: --->'+loc);
                locationList.add(loc);
            }

            System.debug('locationlist -->'+locationList);
        }

        String locationString = System.JSON.serialize(locationList);
        return locationString;
    }

    @AuraEnabled
    public static String  searchResturants(String entityId, String entityType , String searchTerm){
       string reponse;
        System.debug('Data::::'+ entityId+''+entityType+''+searchTerm);
        List<ZomatoSearch.Restaurants> restaurantsList = new List<ZomatoSearch.Restaurants>();
        // Instantiate a new http object
        Http h = new Http();
        String url = 'https://developers.zomato.com/api/v2.1/search';
        url += '?entity_id='+ entityId;
        url += '&entity_type='+ entityType;
        url += '&q='+searchTerm;
        
        // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('user-key', '3e8b235d70f0a4e7f0e5e6feebc29dd0'); // 6f8d243896b9c5b36e765e495b4804cc
        req.setMethod('GET');
        
        // Send the request, and return a response
        HttpResponse res = h.send(req);
        system.debug('response:::::'+res.getBody());
        reponse = res.getBody();
        //return res.getBody();
        //locationDetailsList = new List();
        if(res.getStatusCode() == 200){
            system.debug('Status::::::::'+res.getStatus());
            
            //string strResponse = reponse.replace('Currency', 'myCurrency');
            //System.debug('strResponse:::::'+strResponse);
            
            ZomatoSearch jsonApex = ZomatoSearch.parse(res.getBody());
            
            system.debug('jsonApex::::::'+jsonApex);
            
            for(ZomatoSearch.Restaurants rest : jsonApex.restaurants){
                System.debug('Restaurants:::::'+rest.Restaurant.name);
                //System.debug('Categories:' + category.Categories.id+':'+category.Categories.name);
                restaurantsList.add(rest);
            }
            system.debug('restaurantsList::::'+restaurantsList);
        }
        String restaurantString = System.JSON.serialize(restaurantsList);
        return restaurantString;
    }
}