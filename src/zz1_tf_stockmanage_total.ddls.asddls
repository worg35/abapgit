//************************************************************************
//Copyright     : Innatech Co., Ltd.
//Author        : Worg
//Create Date   : 2024/05/30 
//************************************************************************
@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: '存貨進銷存表-合計期末+說明'
define table function ZZ1_TF_STOCKMANAGE_TOTAL
    with parameters
        @Environment.systemField: #CLIENT
        p_mandt : abap.clnt,
        @Environment.systemField: #SYSTEM_LANGUAGE
        p_langu : abap.lang,
        @EndUserText.label: '公司代碼'
        p_bukrs : abap.char(4),
        @EndUserText.label: '評價範圍-起'
        s_bwkey_low : abap.char(4),
        @EndUserText.label: '評價範圍-迄'
        s_bwkey_high : abap.char(4),
        @EndUserText.label: '本期年度'
        p_ryear : abap.numc(4),
        @EndUserText.label: '本期-起'
        s_perio_low : abap.numc(3),
        @EndUserText.label: '本期-迄'
        s_perio_high : abap.numc(3)
returns 
{
    mandt              : abap.clnt;
    bwkey              : abap.char( 4 );
    matnr               : abap.char(40);
    maktx              : abap.char(40);
    bwtar               : abap.char(10);
    bklas                : abap.char(10);
    bkbez               : abap.char( 25 );
    matkl                : abap.char( 4 );
    wgbez              : abap.char( 20 );
    mtart                : abap.char(4);
    mtbez              : abap.char( 25 );
    meins              : abap.unit( 3 );
    waers              : abap.cuky( 5 );
    qty01               : abap.quan( 13, 3 );
    qty02               : abap.quan( 13, 3 );
    qty03               : abap.quan( 13, 3 );
    qty04               : abap.quan( 13, 3 );
    qty05               : abap.quan( 13, 3 );
    qty06               : abap.quan( 13, 3 );
    qty07               : abap.quan( 13, 3 );
    qty08               : abap.quan( 13, 3 );
    qty09               : abap.quan( 13, 3 );
    qty10               : abap.quan( 13, 3 );
    amt01             : abap.curr( 13, 2 );
    amt02             : abap.curr( 13, 2 );
    amt03             : abap.curr( 13, 2 );
    amt04             : abap.curr( 13, 2 );
    amt05             : abap.curr( 13, 2 );
    amt06             : abap.curr( 13, 2 );
    amt07             : abap.curr( 13, 2 );
    amt08             : abap.curr( 13, 2 );
    amt09             : abap.curr( 13, 2 );
    amt10             : abap.curr( 13, 2 );
    fn_verpr          : abap.dec( 13, 4 );
}
implemented by method 
    ZZ1_CL_STOCKMANAGE=>exec_total;