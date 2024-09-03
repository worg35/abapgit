@AccessControl.authorizationCheck: #CHECK
@Search.searchable: true
@Metadata.allowExtensions: true
@EndUserText.label: '成本報表列次計算公式PROJECTION VIEW'
define root view entity ZZ1_PV_COM03
  provider contract transactional_query
  as projection on ZZ1_I_COM03
{
      @UI.facet: [
                    {
                        id:  'ZZ1_COM03',
                        purpose:         #STANDARD,
                        type:            #IDENTIFICATION_REFERENCE,
                        label:           'DATA',
                        position:        10
                    }
                 ]
      @UI.hidden: true
  key com03uuid,
      @UI: { lineItem:       [ { position: 10, importance: #HIGH } ],
             identification: [ { position: 10 } ] }
      @EndUserText.label: '公司代碼'
      companycode,      
      @UI: { lineItem:       [ { position: 20, importance: #HIGH } ],
             identification: [ { position: 20 } ] }
      @EndUserText.label: '報表編號'
      reportnumber,
      @Search.defaultSearchElement: true
      @UI: { lineItem:       [ { position: 30, importance: #HIGH } ],
             identification: [ { position: 30 } ] }
      @EndUserText.label: '報表列次'
      reportrow,
      @UI: { lineItem:       [ { position: 40, importance: #HIGH } ],
             identification: [ { position: 40 } ] }
      @EndUserText.label: '報表欄位'
      reportcolumn,
      @UI: { lineItem:       [ { position: 50, importance: #HIGH } ],
             identification: [ { position: 50 } ] }
      @EndUserText.label: '序號'
      serialnumber,
      @UI: { lineItem:       [ { position: 60, importance: #HIGH } ],
             identification: [ { position: 60 } ] }
      @EndUserText.label: '運算'
      operation,
      @UI: { lineItem:       [ { position: 70, importance: #HIGH } ],
             identification: [ { position: 70 } ] }
      @EndUserText.label: '來源類別'
      sourcetype,
      @UI: { lineItem:       [ { position: 80, importance: #HIGH } ],
             identification: [ { position: 80 } ] }
      @EndUserText.label: '評價類別'
      valuationclass,
      @UI: { lineItem:       [ { position: 90, importance: #HIGH } ],
             identification: [ { position: 90 } ] }
      @EndUserText.label: '異動類型'
      goodsmovementtype,
      @UI: { lineItem:       [ { position: 100, importance: #HIGH } ],
             identification: [ { position: 100 } ] }
      @EndUserText.label: '分類帳總類'
      materialledgercategory,
      @UI: { lineItem:       [ { position: 110, importance: #HIGH } ],
             identification: [ { position: 110 } ] }
      @EndUserText.label: '流程類別'
      processcategory,
      @UI: { lineItem:       [ { position: 120, importance: #HIGH } ],
             identification: [ { position: 120 } ] }
      @EndUserText.label: '總帳科目'
      glaccount,
      @UI: { lineItem:       [ { position: 130, importance: #HIGH } ],
             identification: [ { position: 130 } ] }
      @EndUserText.label: '會計科目-迄'
      accountto,
      @UI: { lineItem:       [ { position: 140, importance: #HIGH } ],
             identification: [ { position: 140 } ] }
      @EndUserText.label: '功能範圍'
      functionarea,
      @UI: { lineItem:       [ { position: 150, importance: #HIGH } ],
             identification: [ { position: 150 } ] }
      @EndUserText.label: '成本要素'
      costelement,
      @UI: { lineItem:       [ { position: 160, importance: #HIGH } ],
             identification: [ { position: 160 } ] }
      @EndUserText.label: '來源列次'
      sourcerow,
      @UI: { lineItem:       [ { position: 170 , importance: #HIGH } ],
             identification: [ { position: 170 } ] }
      @EndUserText.label: '來源欄位'
      sourcecolumn
}
