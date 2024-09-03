CLASS lhc_zz1_i_com02 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PUBLIC SECTION.
    DATA: t_com02  TYPE STANDARD TABLE OF zz1_i_com02.

    DATA: wa_com02n TYPE STRUCTURE FOR READ RESULT zz1_i_com02,
          t_com02n  TYPE TABLE FOR READ RESULT zz1_i_com02.

  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zz1_i_com02 RESULT result.

    METHODS process_data FOR DETERMINE ON SAVE
      IMPORTING keys FOR zz1_i_com02~process_data.

ENDCLASS.

CLASS lhc_zz1_i_com02 IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD process_data.
    DATA: l_tabix TYPE sy-tabix.
    DATA: l_str TYPE string.
    DATA: l_str2   TYPE string,
          lwa_mes  TYPE STRUCTURE FOR REPORTED LATE zz1_i_com02.

    CLEAR: t_com02, t_com02n.
    "此次異動資料
    READ ENTITIES OF zz1_i_com02 IN LOCAL MODE
       ENTITY zz1_i_com02
       ALL FIELDS WITH CORRESPONDING #( keys )
       RESULT t_com02n
       FAILED DATA(lt_failed)
       REPORTED DATA(lt_reported).

    "檢查本次異動中重複的資料
    LOOP AT t_com02n INTO wa_com02n.
      l_tabix = sy-tabix.
      READ TABLE t_com02n TRANSPORTING NO FIELDS
          WITH KEY companycode = wa_com02n-companycode
                   reportnumber = wa_com02n-reportnumber
                   reportrow = wa_com02n-reportrow
                   reportcolumn = wa_com02n-reportcolumn
                   language = wa_com02n-language.
      IF sy-subrc = 0 AND l_tabix <> sy-tabix.
        l_str =  wa_com02n-companycode
                  && ` ` && wa_com02n-reportnumber
                  && ` ` && wa_com02n-reportrow
                  && ` ` && wa_com02n-reportcolumn
                  && ` ` && wa_com02n-language.
        MESSAGE e501(zz1_co) WITH l_str INTO l_str2.
        lwa_mes-com02uuid = wa_com02n-com02uuid.
        lwa_mes-%msg = new_message_with_text( severity =  if_abap_behv_message=>severity-error text = l_str2 ).
        APPEND lwa_mes TO reported-zz1_i_com02.
      ENDIF.
    ENDLOOP.

    "若有錯誤則全部不上傳
    IF reported-zz1_i_com02 IS INITIAL.

    ELSE.
        MODIFY ENTITIES OF zz1_i_com02 IN LOCAL MODE
         ENTITY zz1_i_com02
         DELETE FROM VALUE #( FOR lwa_com02n IN t_com02n
          ( com02uuid = lwa_com02n-com02uuid ) ).
        CHECK 1 = 0.
    ENDIF.

    "取與此次建立資料重複的已建立資料
    IF t_com02n IS NOT INITIAL.
      SELECT * FROM zz1_i_com02
        FOR ALL ENTRIES IN @t_com02n
        WHERE companycode = @t_com02n-companycode
        AND reportnumber = @t_com02n-reportnumber
        AND reportrow = @t_com02n-reportrow
        AND reportcolumn = @t_com02n-reportcolumn
        AND language = @t_com02n-language
        INTO CORRESPONDING FIELDS OF TABLE @t_com02.
    ENDIF.

    "刪除重複的已建立資料
    IF t_com02 IS NOT INITIAL.
      MODIFY ENTITIES OF zz1_i_com02 IN LOCAL MODE
         ENTITY zz1_i_com02
         DELETE FROM VALUE #( FOR wa_com02 IN t_com02
          ( com02uuid = wa_com02-com02uuid ) ).
    ENDIF.
  ENDMETHOD.


ENDCLASS.
