public with sharing class reCAPTCHAController {
    private String secret = '<secret>';
	private String baseUrl = 'https://www.google.com/recaptcha/api/siteverify'; 
    
	public String publicKey { get { return '<publicKey>' ; }} 
    public string token {get; set; }  { token = null; }
	public Boolean correctResponse { get; private set; } { correctResponse = false; }
    
	public PageReference regist() {
		System.debug( 'verify called');
        if ( token == null ) { 
            System.debug( 'verify called null ');
            return null; 
        }
        HttpResponse r = makeRequest(  baseUrl, 'secret=' + secret + '&response=' + token );
        System.debug(r.getBody());
    	if ( r != null ) {
              correctResponse = ( r.getBody().contains('true') );
        } 
        return null; 	
	}

	public PageReference reset() {
		token = null;
        correctResponse = false;
		return null; 
	}	

	private static HttpResponse makeRequest(String url, String body)  {
        HttpRequest req = new HttpRequest();   
        HttpResponse response = null;
        req.setEndpoint( url );
        req.setMethod('POST');
        req.setBody(body);
        try {
            Http http = new Http();
            response = http.send(req);
            System.debug('response: '+ response);
            System.debug('body: '+ response.getBody());
        } catch( System.Exception e) {
            System.debug('ERROR: '+ e);
        }
        return response;
    }	
}