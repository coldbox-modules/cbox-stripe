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

            it( "can retrieve paginated entries back and forth", function() {
                var customerService = getInstance( "CustomerService@cbstripe" );
                var customerA = customerService.create( getInstance( "Customer@cbstripe" ) );
                var customerB = customerService.create( getInstance( "Customer@cbstripe" ) );

                var customers = customerService.list( { "limit" = 1 } );
                expect( customers.getData() ).toBeArray();
                expect( customers.getData() ).notToBeEmpty();
                expect( customers.getData() ).toHaveLength( 1 );
                var retrievedCustomer = customers.getData()[ 1 ];

                customers = customers.next();
                expect( customers.getData() ).toBeArray();
                expect( customers.getData() ).notToBeEmpty();
                expect( customers.getData() ).toHaveLength( 1 );

                customers = customers.previous();
                expect( customers.getData() ).toBeArray();
                expect( customers.getData() ).notToBeEmpty();
                expect( customers.getData() ).toHaveLength( 1 );
                expect( customers.getData()[ 1 ].getId() ).toBe( retrievedCustomer.getId() );
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
