@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '存貨進銷存表-輸出結果'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #L,
    dataClass: #MIXED
}
@UI: {
     headerInfo: {
                typeName: '存貨進銷存表',
                typeNamePlural: '存貨進銷存表'
     }
}
define view entity ZZ1_I_STOCKMANAGE_LIST
    with parameters
        @Consumption.valueHelpDefinition: [ { entity: { name: 'I_CompanyCodeStdVH', element: 'CompanyCode' } } ]
        @EndUserText.label: '公司代碼'
        p_bukrs : bukrs,
        @Consumption.valueHelpDefinition: [ { entity: { name: 'I_ProductValuationAreaVH', element: 'ValuationArea' } } ]
        @EndUserText.label: '評價範圍-起'
        s_bwkey_low : werks_d,
        @Consumption.valueHelpDefinition: [ { entity: { name: 'I_ProductValuationAreaVH', element: 'ValuationArea' } } ]
        @EndUserText.label: '評價範圍-迄'
        s_bwkey_high : werks_d,
        @EndUserText.label: '本期年度'
        p_ryear : mjahr,
        @EndUserText.label: '本期-起'
        s_perio_low : poper,
        @EndUserText.label: '本期-迄'
        s_perio_high : poper        
    as select from  ZZ1_TF_STOCKMANAGE_TOTAL( p_mandt: $session.client, 
                                                                                         p_langu: $session.system_language, 
                                                                                         p_bukrs: $parameters.p_bukrs,
                                                                                         s_bwkey_low: $parameters.s_bwkey_low,
                                                                                         s_bwkey_high: $parameters.s_bwkey_high,
                                                                                         p_ryear: $parameters.p_ryear,
                                                                                         s_perio_low: $parameters.s_perio_low,
                                                                                         s_perio_high: $parameters.s_perio_high
                                                                                       )
  
{
    @UI: { lineItem:       [ { position: 10, importance: #HIGH } ]
             }
    @EndUserText.label: '評價範圍'
    key bwkey,
    @UI: { lineItem:       [ { position: 20, importance: #HIGH } ],
             selectionField: [{ position: 20 }]
             }
    @Consumption.valueHelpDefinition: [ { entity: { name: 'I_ProductStdVH', element: 'Product' } } ]
    @EndUserText.label: '物料號碼'
    key matnr,
    @UI: { lineItem:       [ { position: 30, importance: #HIGH } ]
             }
     @EndUserText.label: '物料說明'
     key maktx,
    @UI: { lineItem:       [ { position: 40, importance: #HIGH } ],
             selectionField: [{ position: 40 }]
             }
    @Consumption.valueHelpDefinition: [ { entity: { name: 'I_MaterialValuationTypeVH', element: 'InventoryValuationType' } } ]
    @EndUserText.label: '評價類型'
    key bwtar,
    @UI: { lineItem:       [ { position: 50, importance: #HIGH } ],
             selectionField: [{ position: 50 }]
             }
    @Consumption.valueHelpDefinition: [ { entity: { name: 'I_Prodvaluationclass', element: 'ValuationClass' } } ]
    @EndUserText.label: '評價類別'
    bklas,
    @UI: { lineItem:       [ { position: 60, importance: #HIGH } ]
             }
    @EndUserText.label: '評價類別說明'
    bkbez,
    @UI: { lineItem:       [ { position: 70, importance: #HIGH } ],
             selectionField: [{ position: 70 }]
             }
    @Consumption.valueHelpDefinition: [ { entity: { name: 'I_CnsldtnMaterialGroupVH', element: 'MaterialGroup' } } ]
    @EndUserText.label: '物料群組'
    matkl,
    @UI: { lineItem:       [ { position: 80, importance: #HIGH } ]
             }
    @EndUserText.label: '物料群組說明'
    wgbez,
    @UI: { lineItem:       [ { position: 90, importance: #HIGH } ],
             selectionField: [{ position: 90 }]
             }
    @Consumption.valueHelpDefinition: [ { entity: { name: 'I_Producttype', element: 'ProductType' } } ]         
    @EndUserText.label: '物料類型'
    mtart,
    @UI: { lineItem:       [ { position: 100, importance: #HIGH } ]
             }
    @EndUserText.label: '物料類型說明'
    mtbez,
    @UI: { lineItem:       [ { position: 110 } ]
             }
    @EndUserText.label: '單位'
    meins,
    @UI: { lineItem:       [ { position: 120 } ],
             hidden: true
             }
    @EndUserText.label: '幣別'
    waers,
    @UI: { lineItem:       [ { position: 130 } ]
             }
    @EndUserText.label: '期初數量'
    @Semantics.quantity.unitOfMeasure: 'meins'
    qty01,
    @UI: { lineItem:       [ { position: 140 } ]
             }
    @EndUserText.label: '期初金額'
    @Semantics.amount.currencyCode: 'waers'
    amt01,    
    @UI: { lineItem:       [ { position: 150 } ]
             }
    @EndUserText.label: '進貨數量'
    @Semantics.quantity.unitOfMeasure: 'meins'
    qty02,
    @UI: { lineItem:       [ { position: 160 } ]
             }
    @EndUserText.label: '進貨金額'
    @Semantics.amount.currencyCode: 'waers'
    amt02,        
    @UI: { lineItem:       [ { position: 170 } ]
             }
    @EndUserText.label: '生產入庫數量'
    @Semantics.quantity.unitOfMeasure: 'meins'
    qty03,
    @UI: { lineItem:       [ { position: 180 } ]
             }
    @EndUserText.label: '生產入庫金額'
    @Semantics.amount.currencyCode: 'waers'
    amt03,    
    @UI: { lineItem:       [ { position: 190 } ]
             }
    @EndUserText.label: '委外入庫數量'
    @Semantics.quantity.unitOfMeasure: 'meins'
    qty04,
    @UI: { lineItem:       [ { position: 200 } ]
             }
    @EndUserText.label: '委外入庫金額'
    @Semantics.amount.currencyCode: 'waers'
    amt04,    
    @UI: { lineItem:       [ { position: 210 } ]
             }
    @EndUserText.label: '生產領料數量'
    @Semantics.quantity.unitOfMeasure: 'meins'
    qty05,
    @UI: { lineItem:       [ { position: 220 } ] 
             }
    @EndUserText.label: '生產領料金額'
    @Semantics.amount.currencyCode: 'waers'
    amt05,
    @UI: { lineItem:       [ { position: 230 } ]
             }
    @EndUserText.label: '銷貨數量'
    @Semantics.quantity.unitOfMeasure: 'meins'
    qty06,
    @UI: { lineItem:       [ { position: 240 } ]
             }
    @EndUserText.label: '銷貨金額'
    @Semantics.amount.currencyCode: 'waers'
    amt06,
    @UI: { lineItem:       [ { position: 250 } ]
             }
    @EndUserText.label: '盤盈虧數量'
    @Semantics.quantity.unitOfMeasure: 'meins'
    qty07,
    @UI: { lineItem:       [ { position: 260 } ]
             }
    @EndUserText.label: '盤盈虧金額'
    @Semantics.amount.currencyCode: 'waers'
    amt07,
    @UI: { lineItem:       [ { position: 270 } ] 
             }
    @EndUserText.label: '轉費用數量'
    @Semantics.quantity.unitOfMeasure: 'meins'
    qty08,
    @UI: { lineItem:       [ { position: 280 } ]
             }
    @EndUserText.label: '轉費用金額'
    @Semantics.amount.currencyCode: 'waers'
    amt08,    
    @UI: { lineItem:       [ { position: 290 } ]
             }
    @EndUserText.label: '報廢數量'
    @Semantics.quantity.unitOfMeasure: 'meins'
    qty09,
    @UI: { lineItem:       [ { position: 300 } ]
             }
    @EndUserText.label: '報廢金額'
    @Semantics.amount.currencyCode: 'waers'
    amt09,    
    @UI: { lineItem:       [ { position: 310 } ]
             }
    @EndUserText.label: '調撥數量'
    @Semantics.quantity.unitOfMeasure: 'meins'
    qty10,
    @UI: { lineItem:       [ { position: 320 } ]
             }
    @EndUserText.label: '調撥金額'
    @Semantics.amount.currencyCode: 'waers'
    amt10    
//    @UI: { lineItem:       [ { position: 330 } ]
//             }
//    @EndUserText.label: '其他數量'
//    @Semantics.quantity.unitOfMeasure: 'meins'
//    qty11,
//    @UI: { lineItem:       [ { position: 340 } ]
//             }
//    @EndUserText.label: '其他金額'
//    @Semantics.amount.currencyCode: 'waers'
//    amt11,    
//    @UI: { lineItem:       [ { position: 350 } ]
//             }
//    @EndUserText.label: '期末數量'
//    @Semantics.quantity.unitOfMeasure: 'meins'
//    qty12,
//    @UI: { lineItem:       [ { position: 360 } ]
//             }
//    @EndUserText.label: '期末金額'
//    @Semantics.amount.currencyCode: 'waers'
//    amt12
//    @UI: { lineItem:       [ { position: 370 } ]
//             }
//    @EndUserText.label: '數量13'
//    @Semantics.quantity.unitOfMeasure: 'meins'
//    qty13,
//    @UI: { lineItem:       [ { position: 380 } ]
//             }
//    @EndUserText.label: '金額13'
//    @Semantics.amount.currencyCode: 'waers'
//    amt13,
//    @UI: { lineItem:       [ { position: 390 } ]
//             }
//    @EndUserText.label: '數量14'
//    @Semantics.quantity.unitOfMeasure: 'meins'
//    qty14,
//    @UI: { lineItem:       [ { position: 400 } ]
//             }
//    @EndUserText.label: '金額14'
//    @Semantics.amount.currencyCode: 'waers'
//    amt14,
//    @UI: { lineItem:       [ { position: 410 } ]
//             }
//    @EndUserText.label: '數量15'
//    @Semantics.quantity.unitOfMeasure: 'meins'
//    qty15,
//    @UI: { lineItem:       [ { position: 420 } ]
//             }
//    @EndUserText.label: '金額15'
//    @Semantics.amount.currencyCode: 'waers'
//    amt15
}
