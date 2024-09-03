CLASS lhc_zz1_i_com03 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PUBLIC SECTION.
    DATA: t_com03  TYPE STANDARD TABLE OF zz1_i_com03.

    DATA: wa_com03n TYPE STRUCTURE FOR READ RESULT zz1_i_com03,
          t_com03n  TYPE TABLE FOR READ RESULT zz1_i_com03.

  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zz1_i_com03 RESULT result.

    METHODS process_data FOR DETERMINE ON SAVE
      IMPORTING keys FOR zz1_i_com03~process_data.

ENDCLASS.

CLASS lhc_zz1_i_com03 IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD process_data.
    DATA: l_tabix TYPE sy-tabix.
    DATA: l_str TYPE string.
    DATA: l_str2   TYPE string,
          lwa_mes  TYPE STRUCTURE FOR REPORTED LATE zz1_i_com03.

    CLEAR: t_com03, t_com03n.
    "此次異動資料
    READ ENTITIES OF zz1_i_com03 IN LOCAL MODE
       ENTITY zz1_i_com03
       ALL FIELDS WITH CORRESPONDING #( keys )
       RESULT t_com03n
       FAILED DATA(lt_failed)
       REPORTED DATA(lt_reported).

     "檢查本次異動中重複的資料
    LOOP AT t_com03n INTO wa_com03n.
      l_tabix = sy-tabix.
      READ TABLE t_com03n TRANSPORTING NO FIELDS
          WITH KEY companycode = wa_com03n-companycode
                   reportnumber = wa_com03n-reportnumber
                   reportrow = wa_com03n-reportrow
                   reportcolumn = wa_com03n-reportcolumn
                   serialnumber = wa_com03n-serialnumber.
      IF sy-subrc = 0 AND l_tabix <> sy-tabix.
        l_str =  wa_com03n-companycode
                  && ` ` && wa_com03n-reportnumber
                  && ` ` && wa_com03n-reportrow
                  && ` ` && wa_com03n-reportcolumn
                  && ` ` && wa_com03n-serialnumber.
        MESSAGE e501(zz1_co) WITH l_str INTO l_str2.
        lwa_mes-com03uuid = wa_com03n-com03uuid.
        lwa_mes-%msg = new_message_with_text( severity =  if_abap_behv_message=>severity-error text = l_str2 ).
        APPEND lwa_mes TO reported-zz1_i_com03.
      ENDIF.
    ENDLOOP.

    "若有錯誤則全部不上傳
    IF reported-zz1_i_com03 IS INITIAL.

    ELSE.
        MODIFY ENTITIES OF zz1_i_com03 IN LOCAL MODE
         ENTITY zz1_i_com03
         DELETE FROM VALUE #( FOR lwa_com03n IN t_com03n
          ( com03uuid = lwa_com03n-com03uuid ) ).
        CHECK 1 = 0.
    ENDIF.

    "取與此次建立資料重複的已建立資料
    IF t_com03n IS NOT INITIAL.
      SELECT * FROM zz1_i_com03
        FOR ALL ENTRIES IN @t_com03n
        WHERE companycode = @t_com03n-companycode
        AND reportnumber = @t_com03n-reportnumber
        AND reportrow = @t_com03n-reportrow
        AND reportcolumn = @t_com03n-reportcolumn
        AND serialnumber = @t_com03n-serialnumber
        INTO CORRESPONDING FIELDS OF TABLE @t_com03.
    ENDIF.

    "刪除重複的已建立資料
    IF t_com03 IS NOT INITIAL.
      MODIFY ENTITIES OF zz1_i_com03 IN LOCAL MODE
         ENTITY zz1_i_com03
         DELETE FROM VALUE #( FOR wa_com03 IN t_com03
          ( com03uuid = wa_com03-com03uuid ) ).
    ENDIF.
  ENDMETHOD.


ENDCLASS.
