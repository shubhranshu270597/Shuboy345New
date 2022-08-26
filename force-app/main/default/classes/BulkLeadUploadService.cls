/**
 * @File Name          : BulkLeadUploadService.cls
 * @Description        : 
 * @Author             : shubhranshu
 * @Group              : 
 * @Last Modified By   : shubhranshu
 * @Last Modified On   : 8/3/2020, 1:37:46 pm
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    8/3/2020   shubhranshu     Initial Version
**/
@RestResource(UrlMapping='/bulkLeadInsertion/*')

global class BulkLeadUploadService {
    
    @HttpPost
    global static String insertLead(){

      String username=RestContext.request.params.get('username');
      String password=RestContext.request.params.get('password');
      System.debug('username '+username +' password '+password +' ... '+System.Label.BulkUploadServiceUserName +'....'+System.Label.BulkUploadServicePassword);
      if(username == System.Label.BulkUploadServiceUserName && password == System.Label.BulkUploadServicePassword){
        system.JSONGenerator gn = JSON.createGenerator(True);
        gn.writeStartObject();
        Try{
            RestRequest req = RestContext.request;
            String reqBody = req.requestBody.ToString();
            List<Lead> leads = (List<Lead>) JSON.deserialize(reqBody, List<Lead>.Class);
            Database.insert(leads);
            gn.writeStringField('Status', 'Lead is successfully created');
        }
        Catch(Exception e){
            gn.writeStringField('Status', 'Operation Failed');
            gn.writeStringField('Error', e.getMessage());
        }
            Return gn.getAsString();
        }else{
            return 'Invalid username or password try again with different one';
        }
    }
}