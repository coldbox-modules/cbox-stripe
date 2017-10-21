component extends="tests.resources.BaseStripeSpec" {

    function run() {
        describe( "Pagination", function() {
            it( "retrieves the next page of paginated entries", function() {
                var customerService = getInstance( "CustomerService@cbstripe" );
                var customerA = customerService.create( getInstance( "Customer@cbstripe" ) );
                var customerB = customerService.create( getInstance( "Customer@cbstripe" ) );

                var customers = customerService.list( { "limit" = 1 } );
                expect( customers.getData() ).toBeArray();
                expect( customers.getData() ).notToBeEmpty();

                customers = customers.next();
                expect( customers.getData() ).toBeArray();
                expect( customers.getData() ).notToBeEmpty();

                customers = customers.next();
                expect( customers.getData() ).toBeArray();
                expect( customers.getData() ).toBeEmpty();
            } );

            it( "returns an empty array when there are no records", function() {
                var customerService = getInstance( "CustomerService@cbstripe" );
                var customerA = customerService.create( getInstance( "Customer@cbstripe" ) );
                var customerB = customerService.create( getInstance( "Customer@cbstripe" ) );

                var customers = customerService.list( { "limit" = 1 } );
                expect( customers.getData() ).toBeArray();
                expect( customers.getData() ).notToBeEmpty();

                customers = customers.previous();
                expect( customers.getData() ).toBeArray();
                expect( customers.getData() ).toBeEmpty();
            } );
        } );
    }

}
