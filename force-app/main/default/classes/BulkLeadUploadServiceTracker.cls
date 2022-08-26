/**
 * @File Name          : BulkLeadUploadServiceTracker.cls
 * @Description        : 
 * @Author             : shubhranshu
 * @Group              : 
 * @Last Modified By   : shubhranshu
 * @Last Modified On   : 8/3/2020, 1:43:24 pm
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    8/3/2020   shubhranshu     Initial Version
**/
@isTest
public without sharing class BulkLeadUploadServiceTracker {
    static testMethod void testBukService1(){
        Test.startTest();     
		String myJSON = '[{"lastName": "test123","Company": "testcompany"},{"lastName": "test12","Company": "testtcompany"}]';
        RestRequest request = new RestRequest();
        request.params.put('username', 'testuser');
        request.params.put('password', 'pass@123');
        request.requestUri = 'https://vaasaportal-developer-edition.ap4.force.com/services/apexrest/bulkLeadInsertion';
        request.httpMethod = 'POST';
        request.requestBody = Blob.valueof(myJSON);
        RestContext.request = request;
		BulkLeadUploadService.insertLead();
		Test.stopTest();
    }

    static testMethod void testBukService2(){
        Test.startTest();     
		String myJSON = '[{"lastName": "test123","Company": "testcompany"},{"lastName": "test12","Company": "testtcompany"}]';
        RestRequest request = new RestRequest();
        request.params.put('username', 'testuser');
        request.params.put('password', 'pass@1234');
        request.requestUri = 'https://vaasaportal-developer-edition.ap4.force.com/services/apexrest/bulkLeadInsertion';
        request.httpMethod = 'POST';
        request.requestBody = Blob.valueof(myJSON);
        RestContext.request = request;
		BulkLeadUploadService.insertLead();
		Test.stopTest();
    }

    static testMethod void testBukService3(){
        Test.startTest();     
		String myJSON = '[{"lastName": "test123","Company": "testcompany"}{"lastName": "test12","Company": "testtcompany"}]';
        RestRequest request = new RestRequest();
        request.params.put('username', 'testuser');
        request.params.put('password', 'pass@1234');
        request.requestUri = 'https://vaasaportal-developer-edition.ap4.force.com/services/apexrest/bulkLeadInsertion';
        request.httpMethod = 'POST';
        request.requestBody = Blob.valueof(myJSON);
        RestContext.request = request;
		BulkLeadUploadService.insertLead();
		Test.stopTest();
    }
}