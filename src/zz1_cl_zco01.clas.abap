CLASS zz1_cl_zco01 DEFINITION
    PUBLIC
    FINAL
    CREATE PUBLIC .

    PUBLIC SECTION.
        INTERFACES if_oo_adt_classrun .
        INTERFACES if_rap_query_provider .
    PROTECTED SECTION.
    PRIVATE SECTION.
ENDCLASS.



CLASS ZZ1_CL_ZCO01 IMPLEMENTATION.


    METHOD if_oo_adt_classrun~main.
    ENDMETHOD.


    METHOD if_rap_query_provider~select.
        IF io_request->is_data_requested( ).
            DATA(l_top)     = io_request->get_paging( )->get_page_size( ).
            DATA(l_offset)    = io_request->get_paging( )->get_offset( ).
            DATA(lt_parameter) = io_request->get_parameters( ).
            DATA(lt_filter)  = io_request->get_filter( )->get_as_ranges( ).
            DATA(lt_fields)  = io_request->get_requested_elements( ).
            DATA(lt_sort)    = io_request->get_sort_elements( ).

            DATA: l_offset_next TYPE i.
            DATA: l_total TYPE int8.
            DATA: lwa_filter TYPE if_rap_query_filter=>ty_name_range_pairs.
            DATA: lwa_parameter TYPE if_rap_query_request=>ty_parameter.
            DATA: lwa_range TYPE LINE OF  if_rap_query_filter=>tt_range_option.

            DATA: BEGIN OF lwa_data,
                        matnr   TYPE matnr,
                        bwkey   TYPE werks_d,
                        bwtar   TYPE bwtar_d,
                        maktx   TYPE maktx,
                        bklas   TYPE bklas,
                        bkbez   TYPE c LENGTH 25,
                        matkl   TYPE matkl,
                        wgbez   TYPE c LENGTH 20,
                        mtart   TYPE mtart,
                        mtbez   TYPE c LENGTH 25,
                        meins   TYPE meins,
                        qty01   TYPE lbkum,
                        amt01   TYPE salk3,
                        qty02   TYPE lbkum,
                        amt02   TYPE salk3,
                        qty03   TYPE lbkum,
                        amt03   TYPE salk3,
                        qty04   TYPE lbkum,
                        amt04   TYPE salk3,
                        qty05   TYPE lbkum,
                        amt05   TYPE salk3,
                        qty06   TYPE lbkum,
                        amt06   TYPE salk3,
                        qty07   TYPE lbkum,
                        amt07   TYPE salk3,
                        qty08   TYPE lbkum,
                        amt08   TYPE salk3,
                        qty09   TYPE lbkum,
                        amt09   TYPE salk3,
                        qty10   TYPE lbkum,
                        amt10   TYPE salk3,
                        waers   TYPE waers,
                        fn_verpr    TYPE p DECIMALS 4,
                        peinh   TYPE peinh,
                       END OF lwa_data,
                       lt_data LIKE STANDARD TABLE OF lwa_data.
            DATA: BEGIN OF lwa_list,
                        matnr   TYPE matnr,
                        bwkey   TYPE werks_d,
                        bwtar   TYPE bwtar_d,
                        qty01   TYPE lbkum,
                        amt01   TYPE salk3,
                        qty02   TYPE lbkum,
                        amt02   TYPE salk3,
                        qty03   TYPE lbkum,
                        amt03   TYPE salk3,
                        qty04   TYPE lbkum,
                        amt04   TYPE salk3,
                        qty05   TYPE lbkum,
                        amt05   TYPE salk3,
                        qty06   TYPE lbkum,
                        amt06   TYPE salk3,
                        qty07   TYPE lbkum,
                        amt07   TYPE salk3,
                        qty08   TYPE lbkum,
                        amt08   TYPE salk3,
                        qty09   TYPE lbkum,
                        amt09   TYPE salk3,
                        qty10   TYPE lbkum,
                        amt10   TYPE salk3,
                        waers   TYPE waers,
                       END OF lwa_list,
                       lt_list LIKE STANDARD TABLE OF lwa_list.

            DATA: lwa_setting   TYPE ZZ1_TF_STOCKMANAGE_SETTING,
                       lt_setting   TYPE STANDARD TABLE OF ZZ1_TF_STOCKMANAGE_SETTING,
                       lwa_run TYPE I_EstimatedCostCostingRunStdVH,
                       lt_run LIKE TABLE OF lwa_run,
                       lwa_yymm TYPE I_FiscalCalYearPeriodForLedger,
                       lt_yymm  TYPE STANDARD TABLE OF I_FiscalCalYearPeriodForLedger,
                       BEGIN OF lwa_mlrun,
                        RUN_TYPE    TYPE I_EstimatedCostCostingRunStdVH-EstimatedCostCostingRun,
                        gjahr TYPE gjahr,
                        poper   TYPE poper,
                       END OF lwa_mlrun,
                       lt_mlrun  LIKE TABLE OF lwa_mlrun,
                       lwa_actcost TYPE I_ActualCostingRunResult,
                       lt_actcost TYPE STANDARD TABLE OF I_ActualCostingRunResult,
                       BEGIN OF lwa_marc,
                        matnr   TYPE matnr,
                        bwkey   TYPE werks_d,
                       END OF lwa_marc,
                       lt_marc  LIKE STANDARD TABLE OF lwa_marc,
                       BEGIN OF lwa_mbew,
                        matnr   TYPE matnr,
                        maktx   TYPE maktx,
                        bwkey   TYPE werks_d,
                        bwtar   TYPE bwtar_d,
                        bklas   TYPE bklas,
                        bkbez   TYPE c LENGTH 25,
                        matkl   TYPE matkl,
                        wgbez   TYPE c LENGTH 20,
                        mtart   TYPE mtart,
                        mtbez   TYPE c LENGTH 25,
                        meins   TYPE meins,
                        peinh   TYPE peinh,
                       END OF lwa_mbew,
                       lt_mbew  LIKE STANDARD TABLE OF lwa_mbew,
                       lwa_move TYPE ZZ1_I_STOCKMANAGE_SUM,
                       lt_move  TYPE STANDARD TABLE OF ZZ1_I_STOCKMANAGE_SUM.

            DATA: p_lfgja TYPE gjahr,
                       p_bukrs  TYPE bukrs,
                       l_bwtar  TYPE c LENGTH 10,
                       l_date   TYPE datum,
                       l_year   TYPE n LENGTH 4,
                       l_month TYPE n LENGTH 2,
                       s_bwkey  TYPE RANGE OF bwkey,
                       s_bwkey_wa LIKE LINE OF s_bwkey,
                       s_bwkey_low  TYPE bwkey,
                       s_bwkey_high TYPE bwkey,
                       s_matnr  TYPE RANGE OF matnr,
                       s_matkl  TYPE RANGE OF matkl,
                       s_bklas  TYPE RANGE OF bklas,
                       s_mtart  TYPE RANGE OF mtart,
                       s_bwtar  LIKE RANGE OF l_bwtar,
                       s_perio_low  TYPE poper,
                       s_perio_high TYPE poper,
                       s_perio  TYPE RANGE OF poper,
                       s_perio_wa LIKE LINE OF s_perio.

            DATA: lr_date   TYPE RANGE OF sy-datum,
                       lr_date_wa LIKE LINE OF lr_date.

            DATA: l_text    TYPE c LENGTH 30.
            FIELD-SYMBOLS: <qty> TYPE lbkum,
                                           <amt> TYPE salk3,
                                           <tq> TYPE lbkum,
                                           <ta> TYPE salk3.

            LOOP AT lt_parameter INTO lwa_parameter.
                CASE lwa_parameter-parameter_name.
                    WHEN 'P_RYEAR'.
                        p_lfgja = lwa_parameter-value.
                    WHEN 'P_BUKRS'.
                        p_bukrs = lwa_parameter-value.
                    WHEN 'S_BWKEY_LOW'.
                        s_bwkey_low = lwa_parameter-value.
                        s_bwkey_wa-low = lwa_parameter-value.
                    WHEN 'S_BWKEY_HIGH'.
                        s_bwkey_high = lwa_parameter-value.
                        s_bwkey_wa-high = lwa_parameter-value.
                    WHEN 'S_PERIO_LOW'.
                        s_perio_low = lwa_parameter-value.
                        s_perio_wa-low = lwa_parameter-value.
                    WHEN 'S_PERIO_HIGH'.
                        s_perio_high = lwa_parameter-value.
                        s_perio_wa-high = lwa_parameter-value.
                ENDCASE.
            ENDLOOP.
            s_bwkey_wa(3)  = 'IBT'.
            APPEND s_bwkey_wa TO s_bwkey.
            s_perio_wa(3) = 'IBT'.
            APPEND s_perio_wa TO s_perio.

            LOOP AT lt_filter INTO lwa_filter.
                CASE lwa_filter-name.
                    "WHEN 'BWKEY'.
                        "MOVE-CORRESPONDING lwa_filter-range[] TO s_bwkey[].
                    WHEN 'MATNR'.
                        MOVE-CORRESPONDING lwa_filter-range[] TO s_matnr[].
                    WHEN 'BWTAR'.
                        MOVE-CORRESPONDING lwa_filter-range[] TO s_bwtar[].
                    WHEN 'MATKL'.
                        MOVE-CORRESPONDING lwa_filter-range[] TO s_matkl[].
                    WHEN 'MTART'.
                        MOVE-CORRESPONDING lwa_filter-range[] TO s_mtart[].
                    WHEN 'BKLAS'.
                        MOVE-CORRESPONDING lwa_filter-range[] TO s_bklas[].
                    "WHEN 'LFGJA'.
                        "READ TABLE lwa_filter-range INTO lwa_range INDEX 1.
                        "p_lfgja = lwa_range-low.
                    "WHEN 'LFMON'.
                        "MOVE-CORRESPONDING lwa_filter-range[] TO s_lfmon[].
                ENDCASE.
            ENDLOOP.

            SELECT Product as matnr, \_product\_text[ ( Language = @sy-langu ) ]-ProductName as maktx,
                            ValuationArea as bwkey, ValuationType as bwtar, \_product-BaseUnit as meins,
                            ValuationClass as bklas, \_valuationclass\_valuationclasstext[ ( Language = @sy-langu ) ]-ValuationClassDescription as bkbez,
                            \_product-ProductGroup as matkl, \_product\_productgrouptext_2[ ( Language = @sy-langu ) ]-ProductGroupName as wgbez,
                            \_product-ProductType as mtart, \_product\_producttypename_2[ ( Language = @sy-langu ) ]-ProductTypeName as mtbez,
                            PriceUnitQty as peinh
                FROM I_ProductValuationBasic
                WHERE Product IN @s_matnr
                       AND ValuationArea IN @s_bwkey
                       AND ValuationType IN @s_bwtar
                       AND \_product-ProductGroup IN @s_matkl
                       AND \_product-ProductType IN @s_mtart
                       AND ValuationClass IN @s_bklas
                INTO CORRESPONDING FIELDS OF TABLE @lt_mbew.

            CHECK lt_mbew[] IS NOT INITIAL.

            SORT lt_mbew BY bwkey matnr.
            MOVE-CORRESPONDING lt_mbew[] TO lt_marc[].
            DELETE ADJACENT DUPLICATES FROM lt_marc COMPARING bwkey matnr.

            SELECT * FROM ZZ1_I_STOCKMANAGE_SUM( p_bukrs = @p_bukrs,
                                                                                             s_bwkey_low = @s_bwkey_low,
                                                                                             s_bwkey_high = @s_bwkey_high,
                                                                                             p_ryear    = @p_lfgja,
                                                                                             s_perio_low    = @s_perio_low,
                                                                                             s_perio_high   = @s_perio_high )
                FOR ALL ENTRIES IN @lt_marc
                WHERE matnr = @lt_marc-matnr
                       AND bwkey = @lt_marc-bwkey
                INTO CORRESPONDING FIELDS OF TABLE @lt_move.

**************處理類型L 直接抓節點類的資料****************************************************

            SELECT * FROM ZZ1_TF_STOCKMANAGE_SETTING( p_langu = @sy-langu,
                                                                                                        p_bukrs = @p_bukrs )
                INTO CORRESPONDING FIELDS OF TABLE @lt_setting.

            LOOP AT lt_setting INTO lwa_setting WHERE categ IS NOT INITIAL.
                EXIT.
            ENDLOOP.
            IF sy-subrc = 0.
                SELECT * FROM I_FiscalCalYearPeriodForLedger
                    WHERE ledger = '0L' AND fiscalyear = @p_lfgja AND fiscalperiod IN @s_perio
                    INTO CORRESPONDING FIELDS OF TABLE @lt_yymm.

                SORT lt_yymm BY fiscalyear fiscalperiod.
                DELETE ADJACENT DUPLICATES FROM lt_yymm COMPARING fiscalyear fiscalperiod.

                CHECK lt_yymm[] IS NOT INITIAL.

                LOOP AT lt_yymm INTO lwa_yymm.
                    lr_date_wa(3) = 'IBT'.
                    lr_date_wa-low = lwa_yymm-FiscalYear && lwa_yymm-FiscalPeriod+1(2) && '01'.
                    l_year  = lwa_yymm-FiscalYear.
                    l_month = lwa_yymm-FiscalPeriod+1(2).
                    IF l_month = 12.
                        ADD 1 TO l_year.
                        l_month = 1.
                    ELSE.
                        ADD 1 TO l_month.
                    ENDIF.
                    CONCATENATE l_year l_month '01' INTO l_date.
                    SUBTRACT 1 FROM l_date.
                    lr_date_wa-high = l_date.
                    APPEND lr_date_wa TO lr_date.
                ENDLOOP.

                SELECT * FROM I_EstimatedCostCostingRunStdVH
                    WHERE EstimatedCostCostingRunDate IN @lr_date
                    INTO CORRESPONDING FIELDS OF TABLE @lt_run.

                LOOP AT lt_run INTO lwa_run.
                    lwa_mlrun-run_type = lwa_run-EstimatedCostCostingRun.
                    lwa_mlrun-gjahr = lwa_run-EstimatedCostCostingRunDate(4).
                    lwa_mlrun-poper = lwa_run-EstimatedCostCostingRunDate+4(2).
                    APPEND lwa_mlrun TO lt_mlrun.
                    CLEAR lwa_mlrun.
                ENDLOOP.

                LOOP AT lt_mlrun INTO lwa_mlrun.
                    SELECT * FROM I_ActualCostingRunResult( p_costingruntype = @lwa_mlrun-run_type,
                                                                                               p_fiscalperiod = @lwa_mlrun-poper,
                                                                                               p_fiscalyear = @lwa_mlrun-gjahr )
                    FOR ALL ENTRIES IN @lt_marc
                    WHERE Material = @lt_marc-matnr
                           AND ValuationArea = @lt_marc-bwkey
                           AND ledger = '0L' AND CurrencyRole = '10' AND processcategory IS NOT INITIAL
                     APPENDING CORRESPONDING FIELDS OF TABLE @lt_actcost.

                ENDLOOP.

            ENDIF.

            SORT lt_actcost BY ValuationArea Material MaterialLedgerCategory ProcessCategory.

********************************************************************************************

            MOVE-CORRESPONDING lt_move[] TO lt_list.

            LOOP AT lt_setting INTO lwa_setting WHERE srcty = 'L' AND categ IS NOT INITIAL.
                LOOP AT lt_actcost INTO lwa_actcost WHERE MaterialLedgerCategory = lwa_setting-categ AND ProcessCategory = lwa_setting-ptyp.
                    UNASSIGN <amt>.
                    l_text = 'AMT' && lwa_setting-mark.
                    ASSIGN COMPONENT l_text OF STRUCTURE lwa_list TO <amt>.
                    IF  sy-subrc = 0.
                        lwa_list-matnr   = lwa_actcost-Material.
                        lwa_list-bwkey   = lwa_actcost-ValuationArea.
                        lwa_list-bwtar  = lwa_actcost-InventoryValuationType.
                        lwa_list-waers = lwa_actcost-Currency.
                        <amt> = lwa_actcost-PriceDiffAmtInDisplayCrcy.
                        COLLECT lwa_list INTO lt_list.
                        CLEAR lwa_list.
                    ENDIF.
                ENDLOOP.
            ENDLOOP.

            LOOP AT lt_list INTO lwa_list.
                LOOP AT lt_setting INTO lwa_setting WHERE srcty = '1'.
                    UNASSIGN: <tq>, <ta>, <qty>, <amt>.
                    l_text = 'QTY' && lwa_setting-mark.
                    ASSIGN COMPONENT l_text OF STRUCTURE lwa_list TO <tq>.
                    l_text = 'AMT' && lwa_setting-mark.
                    ASSIGN COMPONENT l_text OF STRUCTURE lwa_list TO <ta>.
                    CHECK sy-subrc = 0.
                    l_text = 'QTY' && lwa_setting-smark.
                    ASSIGN COMPONENT l_text OF STRUCTURE lwa_list TO <qty>.
                    CHECK sy-subrc = 0.
                    l_text = 'AMT' && lwa_setting-smark.
                    ASSIGN COMPONENT l_text OF STRUCTURE lwa_list TO <amt>.
                    CHECK sy-subrc = 0.
                    ADD <qty> TO <tq>.
                    ADD <amt> TO <ta>.
                ENDLOOP.
            ENDLOOP.

            LOOP AT lt_list INTO lwa_list.
                MOVE-CORRESPONDING lwa_list TO lwa_data.
                READ TABLE lt_setting INTO lwa_setting WITH KEY srcty = '1'.
                IF sy-subrc = 0.
                    UNASSIGN: <tq>, <ta>, <qty>, <amt>.
                    l_text = 'QTY' && lwa_setting-mark.
                    ASSIGN COMPONENT l_text OF STRUCTURE lwa_list TO <tq>.
                    l_text = 'AMT' && lwa_setting-mark.
                    ASSIGN COMPONENT l_text OF STRUCTURE lwa_list TO <ta>.
                    CHECK sy-subrc = 0.
                    READ TABLE lt_mbew INTO lwa_mbew WITH KEY matnr = lwa_data-matnr bwkey = lwa_data-bwkey BINARY SEARCH.
                    IF sy-subrc = 0.
                        lwa_data-maktx = lwa_mbew-maktx.
                        lwa_data-bklas = lwa_mbew-bklas.
                        lwa_data-bkbez  = lwa_mbew-bkbez.
                        lwa_data-matkl  = lwa_mbew-matkl.
                        lwa_data-wgbez  = lwa_mbew-wgbez.
                        lwa_data-mtart  = lwa_mbew-mtart.
                        lwa_data-mtbez  = lwa_mbew-mtbez.
                        lwa_data-meins  = lwa_mbew-meins.
                        lwa_data-peinh  = lwa_mbew-peinh.
                        IF <tq> <> 0 AND <ta> <> 0.
                            lwa_data-fn_verpr   = <ta> / <tq>.
                        ENDIF.
                        APPEND lwa_data TO lt_data.
                    ENDIF.
                ENDIF.
                CLEAR: lwa_data.
            ENDLOOP.

            l_total = lines( lt_data ).
            io_response->set_total_number_of_records( l_total ).
            io_response->set_data( lt_data ).
        ENDIF.
    ENDMETHOD.
ENDCLASS.
