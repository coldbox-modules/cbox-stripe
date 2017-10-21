component accessors="true" {

    property name="CustomerService"
             inject="CustomerService@cbstripe"
             getter="false"
             setter="false";

    property name="id";
    property name="isDeleted" default="false";

    function save() {
        var res = "";
        if ( isNull( variables.id ) ) {
            res = CustomerService.create( this );
        }
        else {
            res = CustomerService.update( this );
        }
    }

    function getMemento() {
        return {
            "id" = getId()
        };
    }

}
