({
        listAction: function (component, event, helper) {
            //change the image names,header,description etc as required
            // var name = ['Carousel1', 'Carousel2', 'Carousel3'];
            var name = component.get("v.lstImageName");
            console.log('name '+name);
            // var header = ['Card1', 'Card2', 'Card3'];
            var header = component.get("v.lstImageHeader");
            console.log('header '+header);
            // var description = ['Description1', 'Description2', 'Description3'];
            // var AlternativeText = ['Text1', 'Text2', 'Text3'];
            var AlternativeText = component.get("v.lstImageAltText");
            console.log('AlternativeText '+AlternativeText);
            // var ImageUrl = ['https://www.salesforce.com', 'https://www.salesforce.com', 'https://www.salesforce.com'];
            // var b = ['1', '2', '3', '4', '5'];
            var list1 = [];
            var a = name.length;
            if (typeof name !== 'undefined' && name.length > 0 
                && typeof header !== 'undefined' && header.length > 0
                && typeof AlternativeText !== 'undefined' && AlternativeText.length > 0){

                    for (var i = 0; i < a; i++) {
                        list1.push({ image: $A.get('$Resource.' + name[i]), Header: header[i], AlterText: AlternativeText[i] });

                    }
                    component.set("v.lstimg", list1);
                }
        }
})