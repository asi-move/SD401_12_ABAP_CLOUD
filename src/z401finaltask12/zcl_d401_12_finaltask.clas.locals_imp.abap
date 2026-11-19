*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
class lcl_vehicle definition abstract .

        public section.
        METHODS constructor
            IMPORTING
                iv_make     TYPE string
                iv_model    type string
                iv_price    TYPE decfloat16
                iv_color    type string.

         METHODS display_attributes
                RETURNING VALUE(rv_output) TYPE string.


        protected section.
            DATA mv_make  TYPE string.
            DATA mv_model TYPE string.
            DATA mv_price TYPE decfloat16.
            DATA mv_color TYPE string.
        private section.

      endclass.

      class lcl_vehicle implementation.

        method constructor.
            me->mv_color = iv_color.
            me->mv_make  = iv_make.
            me->mv_model = iv_model.
            me->mv_price = iv_price.
        endmethod.

  method display_attributes.
     rv_output = |Hersteller: { mv_make }, Modell: { mv_model }, Preis: { mv_price } EUR, Farbe: { mv_color }|.
  endmethod.

endclass.
**********************************************************************

class lcl_truck definition INHERITING FROM lcl_vehicle.

  public section.
    CLASS-METHODS get_instance
      IMPORTING
        iv_make TYPE string
        iv_model TYPE string
        iv_price TYPE decfloat16
        iv_color TYPE string
        iv_cargo TYPE decfloat16
      RETURNING
        value(r_result) TYPE REF TO lcl_truck.

   METHODS constructor
            IMPORTING
                iv_make     TYPE string
                iv_model    type string
                iv_price    TYPE decfloat16
                iv_color    type string
                iv_cargo    type decfloat16.
      METHODS get_cargo
      RETURNING VALUE(rv_cargo) TYPE decfloat16.

    METHODS display_attributes REDEFINITION.

  protected section.
            DATA mv_cargo TYPE decfloat16.
  private section.

endclass.

class lcl_truck implementation.

  method get_instance.

    r_result = new #(
      iv_make = iv_make
      iv_model = iv_model
      iv_price = iv_price
      iv_color = iv_color
      iv_cargo = iv_cargo
    ).

  endmethod.

  method constructor.

    super->constructor( iv_make = iv_make iv_model = iv_model iv_price = iv_price iv_color = iv_color ).
    me->mv_cargo    = iv_cargo.

  endmethod.

  method display_attributes.
        rv_output   =  |[LKW]{ super->display_attributes( ) }, Frachtkapazität: { mv_cargo } t|.

  endmethod.

  method get_cargo.
    rv_cargo    =   me->mv_cargo.
  endmethod.

endclass.
**********************************************************************************

class lcl_bus definition INHERITING FROM lcl_vehicle.

  public section.
    CLASS-METHODS get_instance
      IMPORTING
        iv_make TYPE string
        iv_model TYPE string
        iv_seats TYPE i
        iv_price TYPE decfloat16
        iv_color TYPE string
      RETURNING
        value(r_result) TYPE REF TO lcl_bus.
  METHODS constructor
  IMPORTING
        iv_make  TYPE string
        iv_model type string
        iv_seats type i
        iv_price type decfloat16
        iv_color type string.

    METHODS get_seats RETURNING VALUE(rv_seats) TYPE decfloat16.
    Methods display_attributes REDEFINITION.
  protected section.

  DATA mv_seats type i.

  private section.

endclass.

class lcl_bus implementation.

  method get_instance.

    r_result = new #(
      iv_make = iv_make
      iv_model = iv_model
      iv_seats = iv_seats
      iv_price = iv_price
      iv_color = iv_color
    ).

  endmethod.

  method constructor.

    super->constructor( iv_make = mv_make iv_model = mv_model iv_price = mv_price iv_color = mv_color ).

  endmethod.

  method get_seats.
            rv_seats   = me->mv_seats.
  endmethod.

  method display_attributes.
        rv_output   =  |[BUS]{ super->display_attributes( ) }, Maxseats: { mv_seats } t|.

  endmethod.

endclass.

" ==========================================
" 4. Autovermietung (lcl_rental)
" ==========================================

class lcl_rental definition .
      public section.
        types: tt_vehicles TYPE STANDARD TABLE OF REF to lcl_vehicle WITH DEFAULT KEY.


    METHODS add_vehicle
        IMPORTING
            io_vehicle TYPE REF TO lcl_vehicle.
    Methods get_vehicles
        RETURNING VALUE(rt_vehicles) TYPE tt_vehicles.

    METHODS get_max_cargo_truck
        RETURNING VALUE(ro_max_truck) type REF TO lcl_truck.

    Methods check_truck_capacities
        raising zcx_d401_12_failed.

  protected section.
  private section.
    DATA mt_vehicles TYPE tt_vehicles.
endclass.

class lcl_rental implementation.

  method add_vehicle.
    APPEND io_vehicle TO mt_vehicles.
  endmethod.

  method check_truck_capacities.
        LOOP at mt_vehicles INTO data(lo_vehicles).
           if lo_vehicles is INSTANCE OF lcl_truck.
            data(lo_truck)  = cast lcl_truck( lo_vehicles ).
            if lo_truck->get_cargo( ) < 2.
                RAISE EXCEPTION type zcx_d401_12_failed
                        exporting
                        iv_text =  |Fehler: LKW ({ lo_truck->display_attributes( ) }) hat cap. weniger als 2 Tonn |.
            endif.

           ENDIF.
        endloop.
  endmethod.

  method get_max_cargo_truck.
        DATA lv_max_cargo TYPE decfloat16.
         LOOP AT mt_vehicles INTO DATA(lo_vehicles).
            if lo_vehicles is INSTANCE OF lcl_truck.
            data(lo_truck)  = cast lcl_truck( lo_vehicles ).
            if lo_truck->get_cargo( ) > lv_max_cargo.
                 lv_max_cargo   = lo_truck->get_cargo( ).
                 ro_max_truck   = lo_truck.
            endif.

           ENDIF.
         endloop.
  endmethod.

  method get_vehicles.
        rt_vehicles = mt_vehicles.
  endmethod.

endclass.

