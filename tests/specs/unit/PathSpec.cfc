component extends="testbox.system.BaseSpec" {

    function beforeAll() {
        variables.path = new modules.cbstripe.models.Path();
    }

    function run() {
        describe( "join", function() {
            it( "combines url fragements in to one url", function() {
                expect( path.join( "/foo", "/bar" ) ).toBe( "/foo/bar" );
            } );

            it( "ignores extra forward slashes in between parts", function() {
                expect( path.join( "/baz/", "/qux" ) ).toBe( "/baz/qux" );
            } );

            it( "adds forward slashes in between parts where needed", function() {
                expect( path.join( "/wow", "ooh" ) ).toBe( "/wow/ooh" );
            } );

            it( "removes trailing forward slashes", function() {
                expect( path.join( "/boom", "/pow/" ) ).toBe( "/boom/pow" );
            } );

            it( "does not add an initial forward slash", function() {
                expect( path.join( "hello", "world" ) ).toBe( "hello/world" );
            } );

            it( "can handle as many parts as are passed in", function() {
                expect(
                    path.join( "https://api.stripe.com", "v1", "balance" )
                ).toBe( "https://api.stripe.com/v1/balance" );
            } );
        } );
    }

}
