component singleton {

    property name="APIRequestor" inject="APIRequestor@cbstripe";
    property name="URLUtil" inject="URLUtil@cbstripe";

    function find( id ) {
        var res = APIRequestor.request( URLUtil.join( "customers", id ) );
        writeDump( var = res, top = 2, abort = true );
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
