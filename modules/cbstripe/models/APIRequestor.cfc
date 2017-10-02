component {

    variables.STRIPE_BASE_URL = "https://api.stripe.com/";
    variables.STRIPE_API_VERSION = "v1";

    /*============================================
    =            Dependency Injection            =
    ============================================*/

    property name="populator" inject="wirebox:populator";
    property name="urlUtil" inject="URLUtil@cbstripe";
    property name="wirebox" inject="wirebox";

    /*===================================
    =            Stripe Keys            =
    ===================================*/

    property name="secretKey"
             inject="coldbox:setting:secretKey@cbstripe";

    property name="publishableKey"
             inject="coldbox:setting:publishableKey@cbstripe";

    /*======================================
    =            Public Methods            =
    ======================================*/

    function request( endpoint, method = "GET", headers = {} ) {
        structAppend( headers, {
            "Authorization" = "Bearer #secretKey#"
        } );

        writeDump( urlUtil.join( STRIPE_BASE_URL, STRIPE_API_VERSION, endpoint ) );

        cfhttp(
            url          = urlUtil.join( STRIPE_BASE_URL, STRIPE_API_VERSION, endpoint ),
            result       = "local.result",
            method       = method,
            throwonerror = true,
            timeout      = 10
        ) {
            for ( var name in headers ) {
                cfhttpparam(
                    type  = "header",
                    name  = name,
                    value = headers[ name ]
                );
            }
        };

        // writeDump( local.result );

        return populator.populateFromStruct(
            wirebox.getInstance( "APIResponse@cbstripe" ), {
                "statusCode" = local.result.status_code,
                "headers"    = local.result.responseheader,
                "body"       = local.result.filecontent,
                "data"       = deserializeJSON( local.result.filecontent )
            }
        );
    }

}
