CLASS zcl_d401_12_finaltask DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

**********************************************************************

CLASS ZCL_D401_12_FINALTASK IMPLEMENTATION.
    METHOD if_oo_adt_classrun~main.
         DATA(lo_rental) = NEW lcl_rental( ).
    " Aufgabe 3: 5 Lastkraftwagen und 5 Omnibusse erfassen
*    lo_rental->add_vehicle( NEW lcl_truck( iv_make = 'MAN'     iv_model = 'TGX 18.500' iv_price = 120000 iv_color = 'Blau'   iv_cargo = '18.0' ) ).
*    lo_rental->add_vehicle( NEW lcl_truck( iv_make = 'Volvo'   iv_model = 'FH16'       iv_price = 140000 iv_color = 'Rot'    iv_cargo = '25.0' ) ).
*    lo_rental->add_vehicle( NEW lcl_truck( iv_make = 'Scania'  iv_model = 'R 500'      iv_price = 130000 iv_color = 'Weiß'   iv_cargo = '20.0' ) ).
*    lo_rental->add_vehicle( NEW lcl_truck( iv_make = 'DAF'     iv_model = 'XF 530'     iv_price = 115000 iv_color = 'Grün'   iv_cargo = '15.0' ) ).
*    lo_rental->add_vehicle( NEW lcl_truck( iv_make = 'Ford'    iv_model = 'Transit 2t' iv_price =  35000 iv_color = 'Gelb'   iv_cargo = '1.5'  ) ). " Löste Ausnahme aus (< 2t)

*    lo_rental->add_vehicle( NEW lcl_bus( iv_make = 'Mercedes' iv_model = 'Citaro'    iv_price = 220000 iv_color = 'Silber'  iv_seats = 45 ) ).
*    lo_rental->add_vehicle( NEW lcl_bus( iv_make = 'MAN'      iv_model = 'Lion City' iv_price = 210000 iv_color = 'Blau'    iv_seats = 50 ) ).
*    lo_rental->add_vehicle( NEW lcl_bus( iv_make = 'Setra'    iv_model = 'S 515 HD'  iv_price = 250000 iv_color = 'Weiß'    iv_seats = 54 ) ).
*    lo_rental->add_vehicle( NEW lcl_bus( iv_make = 'Volvo'    iv_model = '9700'      iv_price = 230000 iv_color = 'Schwarz' iv_seats = 49 ) ).
*    lo_rental->add_vehicle( NEW lcl_bus( iv_make = 'Neoplan'  iv_model = 'Skyliner'  iv_price = 300000 iv_color = 'Gelb'    iv_seats = 75 ) ).

    "Aufgabe 6: per Factory Methoden 5 Lastkraftwagen und 5 Omnibusse erfassen
    lo_rental->add_vehicle( lcl_truck=>get_instance( iv_make = 'MAN'     iv_model = 'TGX 18.500' iv_price = 120000 iv_color = 'Blau'   iv_cargo = '18.0' ) ).
    lo_rental->add_vehicle( lcl_truck=>get_instance( iv_make = 'Volvo'   iv_model = 'FH16'       iv_price = 140000 iv_color = 'Rot'    iv_cargo = '25.0' ) ).
    lo_rental->add_vehicle( lcl_truck=>get_instance( iv_make = 'Scania'  iv_model = 'R 500'      iv_price = 130000 iv_color = 'Weiß'   iv_cargo = '20.0' ) ).
    lo_rental->add_vehicle( lcl_truck=>get_instance( iv_make = 'DAF'     iv_model = 'XF 530'     iv_price = 115000 iv_color = 'Grün'   iv_cargo = '15.0' ) ).
    lo_rental->add_vehicle( lcl_truck=>get_instance( iv_make = 'Ford'    iv_model = 'Transit 2t' iv_price =  35000 iv_color = 'Gelb'   iv_cargo = '1.5'  ) ). " Löste Ausnahme aus (< 2t)

    lo_rental->add_vehicle( lcl_bus=>get_instance( iv_make = 'Mercedes' iv_model = 'Citaro'    iv_price = 220000 iv_color = 'Silber'  iv_seats = 45 ) ).
    lo_rental->add_vehicle( lcl_bus=>get_instance( iv_make = 'MAN'      iv_model = 'Lion City' iv_price = 210000 iv_color = 'Blau'    iv_seats = 50 ) ).
    lo_rental->add_vehicle( lcl_bus=>get_instance( iv_make = 'Setra'    iv_model = 'S 515 HD'  iv_price = 250000 iv_color = 'Weiß'    iv_seats = 54 ) ).
    lo_rental->add_vehicle( lcl_bus=>get_instance( iv_make = 'Volvo'    iv_model = '9700'      iv_price = 230000 iv_color = 'Schwarz' iv_seats = 49 ) ).
    lo_rental->add_vehicle( lcl_bus=>get_instance( iv_make = 'Neoplan'  iv_model = 'Skyliner'  iv_price = 300000 iv_color = 'Gelb'    iv_seats = 75 ) ).



" 1. Fahrzeugliste ausgeben
    out->write( '<=== GESAMTE FAHRZEUGLISTE ===>' ).
    LOOP AT lo_rental->get_vehicles( ) INTO DATA(lo_vehicle).
      out->write( lo_vehicle->display_attributes( ) ).
    ENDLOOP.

    " 2. Aufgabe 4: LKW mit höchster Frachtkapazität ermitteln
    out->write( '' ).
    out->write( '<=== LKW MIT HÖCHSTER FRACHTKAPAZITÄT ===>' ).
    DATA(lo_max_truck) = lo_rental->get_max_cargo_truck( ).
    IF lo_max_truck IS BOUND.
      out->write( lo_max_truck->display_attributes( ) ).
    ENDIF.

    " 3. Aufgabe 5: Ausnahmebehandlung (< 2t Frachtkapazität)
    out->write( '' ).
    out->write( '=== PRÜFUNG FRACHTKAPAZITÄTEN (< 2 TONNEN) ===' ).
    TRY.
        lo_rental->check_truck_capacities( ).
        out->write( 'Alle LKWs erfüllen die geforderte Mindestkapazität von 2 Tonnen.' ).
      CATCH zcx_d401_12_failed INTO DATA(lx_failed).
        out->write( lx_failed->mv_text ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
