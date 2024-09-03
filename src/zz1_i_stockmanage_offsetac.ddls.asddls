//************************************************************************
//Copyright     : Innatech Co., Ltd.
//Author        : Worg
//Create Date   : 2024/08/13 
//************************************************************************
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '存貨進銷存表-沖銷科目'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #XL,
    dataClass: #MIXED
}
define view entity ZZ1_I_STOCKMANAGE_OFFSETAC
    as select from I_GLAccountLineItem as i_glac
    association [0..1] to I_ProductValuationBasic   as i_pdva  on  i_glac.Product = i_pdva.Product 
                                                                                                   and i_glac.ValuationArea = i_pdva.ValuationArea
                                                                                                   and i_glac.InventoryValuationType = i_pdva.ValuationType      
{
    key i_glac.CompanyCode as bukrs,    //公司代碼
    key i_glac.FiscalYear as ryear,
    key i_glac.FiscalPeriod as perio,
    key i_glac.ValuationArea as bwkey,
    key i_glac.Product as matnr,
    key i_glac.InventoryValuationType as bwtar,  //評價類型
    key i_pdva.ValuationClass as bklas,   //評價類型
    key i_glac.GLAccount as saknr,  //總帳科目
    key i_glac.OffsettingAccount as gkont, //沖銷科目
    key cast ( i_glac.FiscalPeriod as abap.dec(4,0) ) as perio_n,
    key i_glac.CompanyCodeCurrency as waers,    //公司代碼幣別
    @Semantics.amount.currencyCode: 'waers'
    sum( i_glac.AmountInCompanyCodeCurrency )  as Amount  //金額
}
where Ledger = '0L' 
group by i_glac.CompanyCode, i_glac.FiscalYear, i_glac.FiscalPeriod, i_glac.Product, i_glac.ValuationArea, i_pdva.ValuationClass,
                 i_glac.InventoryValuationType, i_glac.GLAccount, i_glac.OffsettingAccount, i_glac.CompanyCodeCurrency
