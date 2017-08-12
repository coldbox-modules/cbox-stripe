component extends="testbox.system.BaseSpec" {

    function beforeAll() {
        variables.urlUtil = new modules.cbstripe.models.URLUtil();
    }

    function run() {
        describe( "join", function() {
            it( "combines url fragements in to one url", function() {
                expect( urlUtil.join( "/foo", "/bar" ) ).toBe( "/foo/bar" );
            } );

            it( "ignores extra forward slashes in between parts", function() {
                expect( urlUtil.join( "/baz/", "/qux" ) ).toBe( "/baz/qux" );
            } );

            it( "adds forward slashes in between parts where needed", function() {
                expect( urlUtil.join( "/wow", "ooh" ) ).toBe( "/wow/ooh" );
            } );

            it( "removes trailing forward slashes", function() {
                expect( urlUtil.join( "/boom", "/pow/" ) ).toBe( "/boom/pow" );
            } );

            it( "does not add an initial forward slash", function() {
                expect( urlUtil.join( "hello", "world" ) ).toBe( "hello/world" );
            } );

            it( "can handle as many parts as are passed in", function() {
                expect(
                    urlUtil.join( "https://api.stripe.com", "v1", "balance" )
                ).toBe( "https://api.stripe.com/v1/balance" );
            } );
        } );
    }

}
