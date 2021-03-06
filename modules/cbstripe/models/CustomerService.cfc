component singleton {

    /*============================================
    =            Dependency Injection            =
    ============================================*/

    property name="APIRequestor" inject="APIRequestor@cbstripe";
    property name="populator"    inject="wirebox:populator";
    property name="path"         inject="Path@cbstripe";
    property name="wirebox"      inject="wirebox";

    function list( params = {} ) {
        var res = APIRequestor.request(
            endpoint = "customers",
            params = arguments.params
        );
        var paginator = wirebox.getInstance( "Paginator@cbstripe" );
        paginator.setService( this );
        paginator.setMethod( "list" );
        paginator.setHasMore( res.getData().has_more );
        paginator.setDefaultParams( arguments.params );
        paginator.setData(
            res.getData().data.map( function( customer ) {
                return wirebox.getInstance( "Customer@cbstripe" ).populate( customer );
            } )
        );
        return paginator;
    }

    function find( id ) {
        var res = APIRequestor.request( path.join( "customers", id ) );
        return populator.populateFromStruct(
            wirebox.getInstance( "Customer@cbstripe" ),
            res.getData()
        );
    }

    function create( customer ) {
        if ( ! isObject( customer ) ) {
            customer = wirebox.getInstance( "Customer@cbstripe" ).populate( customer );
        }
        var res = APIRequestor.request(
            endpoint = "customers",
            method   = "POST",
            fields   = customer.getMemento()
        );
        // writeDump( var = res, top = 2, abort = true );
        return populator.populateFromStruct(
            customer,
            res.getData()
        );
    }

    function delete( customer ) {
        var res = APIRequestor.request(
            endpoint = path.join( "customers", customer.getId() ),
            method   = "DELETE"
        );
        customer.setIsDeleted( true );
        return customer;
    }

}
