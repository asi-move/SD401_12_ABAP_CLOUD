CLASS zcx_d401_12_failed DEFINITION
  PUBLIC
    INHERITING FROM cx_static_check

  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
  interfaces if_t100_message.
       " Definition der Text-ID für die T100-Nachricht
    constants:
        Begin of truck_cap_low,
                msgid   type symsgid    value 'Z12_1MESSAGES',
                msgno   type symsgno      value '030',
                attr1 TYPE scx_attrname VALUE 'MV_TEXT',
                attr2 TYPE scx_attrname VALUE '',
                attr3 TYPE scx_attrname VALUE '',
                attr4 TYPE scx_attrname VALUE '',
              END OF truck_cap_low.

  Data: mv_text type string.
  METHODS constructor
         IMPORTING !textid   LIKE if_t100_message=>t100key OPTIONAL
                   !previous LIKE previous OPTIONAL
                   !iv_text   TYPE string OPTIONAL.

ENDCLASS.
**********************************************************
CLASS zcx_d401_12_failed IMPLEMENTATION.

  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    call METHOD super->constructor
    EXPORTING
     previous = previous.

      CLEAR me->textid.
      if textid is INITIAL.
        if_t100_message~t100key     =   if_t100_message=>default_textid.
      else.
        if_t100_message~t100key     =   textid.
      endif.

     IF iv_text IS NOT INITIAL.
      me->mv_text = iv_text.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
