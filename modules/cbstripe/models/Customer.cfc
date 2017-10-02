component accessors="true" {

    property name="CustomerService"
             inject="CustomerService@cbstripe"
             getter="false"
             setter="false";

    property name="id";

    function save() {
        var res = "";
        if ( isNull( variables.id ) ) {
            res = CustomerService.create( this );
        }
        else {
            res = CustomerService.update( this );
        }
        writeDump( var = res, top = 2, abort = true );
    }

    function getMemento() {
        return {
            "id" = getId()
        };
    }

}
