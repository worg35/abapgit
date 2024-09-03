@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '存貨進銷存表-加總金額'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #L,
    dataClass: #MIXED
}
define view entity ZZ1_I_STOCKMANAGE_SUM
    with parameters
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
    as select from ZZ1_TF_STOCKMANAGE_DETAIL( p_mandt: $session.client, 
                                                                                         p_langu: $session.system_language, 
                                                                                         p_bukrs: $parameters.p_bukrs,
                                                                                         s_bwkey_low: $parameters.s_bwkey_low,
                                                                                         s_bwkey_high: $parameters.s_bwkey_high,
                                                                                         p_ryear: $parameters.p_ryear,
                                                                                         s_perio_low: $parameters.s_perio_low,
                                                                                         s_perio_high: $parameters.s_perio_high
                                                                                       )
                                                                                      
{
    key bwkey,      //評價範圍
    key matnr,      //物料
    key bwtar,      //評價類型
    bklas,
    meins,
    waers,
//    rptcl,
    @Semantics.quantity.unitOfMeasure: 'meins'
    sum(qty01) as qty01,
    @Semantics.quantity.unitOfMeasure: 'meins'
    sum(qty02) as qty02,
    @Semantics.quantity.unitOfMeasure: 'meins'
    sum(qty03) as qty03,
    @Semantics.quantity.unitOfMeasure: 'meins'
    sum(qty04) as qty04,
    @Semantics.quantity.unitOfMeasure: 'meins'
    sum(qty05) as qty05,
    @Semantics.quantity.unitOfMeasure: 'meins'
    sum(qty06) as qty06,
    @Semantics.quantity.unitOfMeasure: 'meins'
    sum(qty07) as qty07,
    @Semantics.quantity.unitOfMeasure: 'meins'
    sum(qty08) as qty08,
    @Semantics.quantity.unitOfMeasure: 'meins'
    sum(qty09) as qty09,
    @Semantics.quantity.unitOfMeasure: 'meins'
    sum(qty10) as qty10,
    @Semantics.amount.currencyCode: 'waers'
    sum(amt01) as amt01,
    @Semantics.amount.currencyCode: 'waers'
    sum(amt02) as amt02,
    @Semantics.amount.currencyCode: 'waers'
    sum(amt03) as amt03,
    @Semantics.amount.currencyCode: 'waers'
    sum(amt04) as amt04,
    @Semantics.amount.currencyCode: 'waers'
    sum(amt05) as amt05,
    @Semantics.amount.currencyCode: 'waers'
    sum(amt06) as amt06,
    @Semantics.amount.currencyCode: 'waers'
    sum(amt07) as amt07,
    @Semantics.amount.currencyCode: 'waers'
    sum(amt08) as amt08,
    @Semantics.amount.currencyCode: 'waers'
    sum(amt09) as amt09,
    @Semantics.amount.currencyCode: 'waers'
    sum(amt10) as amt10
}        
//group by bwkey, matnr, bwtar, bklas, meins, waers, rptcl
group by bwkey, matnr, bwtar, bklas, meins, waers
