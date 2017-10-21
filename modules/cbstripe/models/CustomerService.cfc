component singleton {

    /*============================================
    =            Dependency Injection            =
    ============================================*/

    property name="APIRequestor" inject="APIRequestor@cbstripe";
    property name="populator"    inject="wirebox:populator";
    property name="path"         inject="Path@cbstripe";
    property name="wirebox"      inject="wirebox";

    function find( id ) {
        var res = APIRequestor.request( path.join( "customers", id ) );
        return populator.populateFromStruct(
            wirebox.getInstance( "Customer@cbstripe" ),
            res.getData()
        );
    }

    function create( customer ) {
        var res = APIRequestor.request(
            endpoint = "customers",
            method   = "POST",
            body     = customer.getMemento()
        );
        writeDump( var = res, abort = true );
    }

}
