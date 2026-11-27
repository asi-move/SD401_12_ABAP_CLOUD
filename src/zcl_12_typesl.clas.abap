CLASS zcl_12_typesl DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
   INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_12_TYPESL IMPLEMENTATION.


METHOD if_oo_adt_classrun~main.
DATA(lv_int) = EXACT i( '123' ). " Funktioniert einwandfrei

" Beispiel 2: Auslösen einer Ausnahme (Datenverlust)
TRY.
    DATA(lv_int_bad) = EXACT i( '123.45' ). " Wirft Ausnahme, da Nachkommastellen verloren gehen würden
  CATCH cx_sy_conversion_error INTO DATA(lx_error).
    " Fehlerbehandlung: Wert ist nicht verlustfrei konvertierbar
ENDTRY.


ENDMETHOD.
ENDCLASS.
