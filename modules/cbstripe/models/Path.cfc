component {

    function join() {
        var fragments = [];
        var fragmentCount = structCount( arguments );
        for ( var i = 1; i <= fragmentCount; i++ ) {
            var fragment = arguments[ i ];
            if ( i != 1 && left( fragment, 1 ) == "/" ) {
                fragment = mid( fragment, 2, len( fragment ) );
            }
            if ( right( fragment, 1 ) == "/" ) {
                fragment = left( fragment, len( fragment ) - 1 );
            }
            arrayAppend( fragments, fragment );
        }
        return arrayToList( fragments, "/" );
    }

}
