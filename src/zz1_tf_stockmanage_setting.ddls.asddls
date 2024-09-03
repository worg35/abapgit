//************************************************************************
//Copyright     : Innatech Co., Ltd.
//Author        : Worg
//Create Date   : 2024/05/30
//************************************************************************
@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: '存貨進銷存表-取得設定檔'
define table function ZZ1_TF_STOCKMANAGE_SETTING
    with parameters
        @Environment.systemField: #CLIENT
        p_mandt : abap.clnt,
        @Environment.systemField: #SYSTEM_LANGUAGE
        p_langu : abap.lang,
        @EndUserText.label: '公司代碼'
        p_bukrs : abap.char(4)
returns 
{
    mandt       : abap.clnt;
    bukrs        : abap.char( 4 );
    rptcl          : abap.numc( 3 );
    rseq          : abap.numc( 2 );
    opcd         : abap.char( 1 );
    srcty         : abap.char( 1 );
    bwart        : abap.char( 3 );
    categ        : abap.char( 2 );
    ptyp          : abap.char( 4 );
    hkont        : abap.char( 10 );
    srccl         : abap.numc( 3 );
    mark         : abap.numc( 2 );
    smark       : abap.numc( 2 );
}
implemented by method 
    ZZ1_CL_STOCKMANAGE=>get_setting;