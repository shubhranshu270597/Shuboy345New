/**
 * @File Name          : ZomatoLocation.cls
 * @Description        : 
 * @Author             : shubhranshu
 * @Group              : 
 * @Last Modified By   : shubhranshu
 * @Last Modified On   : 8/10/2019, 5:38:52 PM
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    8/10/2019   shubhranshu     Initial Version
**/
public with sharing class ZomatoLocation {
    public List<location_suggestions> location_suggestions;
    public String status;
    public Integer has_more;
    public Integer has_total;

    public class location_suggestions{
        public String entity_type;
        public Integer entity_id;
        public String title;
        public Double latitude;
        public Double longitude;
        public Integer city_id;
        public String city_name;
        public Integer country_id;
        public String country_name;
    }

    public static ZomatoLocation parse(String json) {
        return (ZomatoLocation) System.JSON.deserialize(json, ZomatoLocation.class);
    }
}