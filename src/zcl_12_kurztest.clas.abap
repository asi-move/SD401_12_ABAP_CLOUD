CLASS zcl_12_kurztest DEFINITION
 PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_12_kurztest IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    types: tt_flights type STANDARD TABLE OF /lrn/passflight WITH EMPTY KEY .
    SELECT FROM /lrn/passflight
  FIELDS *
  INTO TABLE @DATA(lt_db_flights).

  data(irt) = value tt_flights( FOR <wa> in lt_db_flights
                      WHERE ( carrier_id = 'LH' ) ( <wa> ) ).
    out->write( irt ).
  ENDMETHOD.

ENDCLASS.
