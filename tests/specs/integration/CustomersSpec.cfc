component extends="tests.resources.BaseStripeSpec" {

    function run() {
        describe( "CustomerService", function() {
            describe( "list", function() {
                it( "returns an empty array if there are no customers", function() {
                    var customerService = getInstance( "CustomerService@cbstripe" );
                    var customers = customerService.list().getData();
                    expect( customers ).toBeArray();
                    expect( customers ).toBeEmpty();
                } );

                it( "can list all customers", function() {
                    var customerService = getInstance( "CustomerService@cbstripe" );
                    var customerA = customerService.create( getInstance( "Customer@cbstripe" ) );
                    var customerB = customerService.create( getInstance( "Customer@cbstripe" ) );

                    var customers = customerService.list().getData();

                    expect( customers ).toBeArray();
                    expect( customers ).notToBeEmpty();
                    expect( customers ).toHaveLength( 2 );

                    var customerIds = customers.map( function( customer ) {
                        return customer.getId();
                    } );

                    expect( customerIds ).toInclude( customerA.getId() );
                    expect( customerIds ).toInclude( customerB.getId() );
                } );
            } );

            describe( "create", function() {
                it( "can create a new blank customer", function() {
                    var customerService = getInstance( "CustomerService@cbstripe" );
                    var customer = customerService.create( getInstance( "Customer@cbstripe" ) );
                    expect( customer.getId() ).notToBeNull();
                } );

                it( "can create a customer with passed in data", function() {
                    var customerService = getInstance( "CustomerService@cbstripe" );
                    var newCustomer = getInstance( "Customer@cbstripe" );
                    newCustomer.setEmail( "john@example.com" );
                    var customer = customerService.create( newCustomer );
                    expect( customer.getId() ).notToBeNull();
                    expect( customer.getEmail() ).toBe( "john@example.com" );
                } );

                it( "can create a new customer from a struct of data", function() {
                    var customerService = getInstance( "CustomerService@cbstripe" );
                    var customer = customerService.create( {
                        "email" = "john@example.com"
                    } );
                    expect( customer.getId() ).notToBeNull();
                    expect( customer.getEmail() ).toBe( "john@example.com" );
                } );
            } );

            describe( "delete", function() {
                it( "can delete an existing customer", function() {
                    var customerService = getInstance( "CustomerService@cbstripe" );
                    var customer = customerService.create( getInstance( "Customer@cbstripe" ) );
                    expect( customer.getIsDeleted() ).toBeFalse( "The customer should not be deleted" );
                    customer = customerService.delete( customer );
                    expect( customer.getIsDeleted() ).toBeTrue( "The customer should be deleted" );
                } );

                xit( "can delete an existing customer when providede with just the id", function() {
                    fail( "test not implemented yet" );
                } );

                xit( "throws an exception if the customer provided does not have an id", function() {
                    fail( "test not implemented yet" );
                } );
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
