public class SOA_PostmanWs {
    public static HttpResponse getPostmanResponse() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://postman-echo.com/get?foo1=bar1&foo2=bar2');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // StatusCode == 200 i.e. Success!
        if (response.getStatusCode() == 200) {
            // Deserializes the JSON string.
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            System.debug('PostmanResponse'+results);
        }
        return response;
    } 
}