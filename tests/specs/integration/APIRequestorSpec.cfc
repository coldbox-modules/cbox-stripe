component extends="coldbox.system.testing.BaseTestCase" {

    function run() {
        describe( "APIRequestor", function() {
            it( "is injected with the secret key", function() {
                var requestor = prepareMock( getWireBox().getInstance( "APIRequestor@cbstripe" ) );

                // this property is defaulted in `modules/cbstripe/ModuleConfig.cfc`
                // and overridden in `config/ColdBox.cfc`
                expect( requestor.$getProperty( "secretKey" ) )
                    .toBe( getSystemSetting( "STRIPE_SECRET_KEY" ) );
            } );

            it( "does not expose the secret key through a getter", function() {
                var requestor = getWireBox().getInstance( "APIRequestor@cbstripe" );
                expect( function() { requestor.getSecretKey(); } ).toThrow();
            } );

            it( "can make requests to Stripe's api", function() {
                var requestor = getWireBox().getInstance( "APIRequestor@cbstripe" );
                var res = requestor.request( "balance" );
                expect( res ).toBeInstanceOf( "cbstripe.models.APIResponse" );
                expect( res.getStatusCode() ).toBe( 200 );
                expect( res.getData().object ).toBe( "balance" );
            } );
        } );
    }

    function getSystemSetting( key, defaultValue ) {
        var system = createObject( "java", "java.lang.System" );
        var env = system.getEnv();
        if ( structKeyExists( env, key ) ) {
            return env[ key ];
        }
        var props = system.getProperties();
        if ( structKeyExists( props, key ) ) {
            return props[ key ];
        }
        if ( ! isNull( defaultValue ) ) {
            return defaultValue;
        }
        throw( "No env or system property named [#key#] was found." );
    }

}
