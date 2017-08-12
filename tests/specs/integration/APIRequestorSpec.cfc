component extends="coldbox.system.testing.BaseTestCase" {

    function run() {
        describe( "APIRequestor", function() {
            it( "is injected with the secret key", function() {
                var requestor = prepareMock( getWireBox().getInstance( "APIRequestor@cbstripe" ) );

                // this property is defaulted in `modules/cbstripe/ModuleConfig.cfc`
                // and overridden in `config/ColdBox.cfc`
                expect( requestor.$getProperty( "secretKey" ) ).toBe(
                    createObject( "java", "java.lang.System" ).getProperty( "STRIPE_SECRET_KEY" )
                );
            } );

            it( "does not expose the secret key through a getter", function() {
                var requestor = getWireBox().getInstance( "APIRequestor@cbstripe" );
                expect( function() { requestor.getSecretKey(); } ).toThrow();
            } );

            it( "can make requests to Stripe's api", function() {
                var requestor = getWireBox().getInstance( "APIRequestor@cbstripe" );
                var res = requestor.request( "balance" );
                expect( res ).toBeInstanceOf( "APIResponse" );
                expect( res.getStatusCode() ).toBe( 200 );
                expect( res.getData().object ).toBe( "balance" );
            } );
        } );
    }

}
