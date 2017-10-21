component extends="coldbox.system.testing.BaseTestCase" {

    /**
    * @beforeEach
    */
    function cleanUpCustomers() {
        var customerService = getInstance( "CustomerService@cbstripe" );
        var allCustomers = customerService.list();
        allCustomers.getData().each( function( customer ) {
            customerService.delete( customer );
        } );
    }

}
