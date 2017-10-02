component extends="coldbox.system.testing.BaseTestCase" {

    function run() {
        describe( "CustomerService", function() {
            it( "can create a new customer", function() {
                var customerService = getInstance( "CustomerService@cbstripe" );
                var customer = customerService.create( getInstance( "Customer@cbstripe" ) );
                expect( customer.getId() ).notToBeNull();
            } );

            xit( "can retrieve a customer by id", function() {
                var customerService = getInstance( "CustomerService@cbstripe" );
                var realId = "";
                var customer = customerService.find( realId );
                expect( customer ).toBeInstanceOf( "Customer" );
                fail( "test not implemented yet" );
            } );
        } );

        describe( "Customer", function() {
            xit( "can create a new customer from a new instance", function() {
                var customer = getInstance( "Customer@cbstripe" );
                expect( customer.getId() ).toBeNull();
                customer.save();
                expect( customer.getId() ).notToBeNull();
            } );
        } );
    }

}
