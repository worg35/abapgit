@AccessControl.authorizationCheck: #CHECK
@Search.searchable: true
@Metadata.allowExtensions: true
@EndUserText.label: '成本報表列次說明PROJECTION VIEW'
define root view entity ZZ1_PV_COM02
  provider contract transactional_query
  as projection on ZZ1_I_COM02
{
      @UI.facet: [ 
                    {   
                        id:  'ZZ1_COM02',
                        purpose:         #STANDARD,
                        type:            #IDENTIFICATION_REFERENCE,
                        label:           'DATA',
                        position:        10 
                    }      
                 ]
      @UI.hidden: true 
  key com02uuid,
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
      @EndUserText.label: '語言代碼'
      language,
      @UI: { lineItem:       [ { position: 60, importance: #HIGH } ],
             identification: [ { position: 60 } ] }
      @EndUserText.label: '運算列印'
      operationprint,
      @UI: { lineItem:       [ { position: 70, importance: #HIGH } ],
             identification: [ { position: 70 } ] }
      @EndUserText.label: '列次說明'
      rowdescription,
      @UI: { lineItem:       [ { position: 80, importance: #HIGH } ],
             identification: [ { position: 80 } ] }
      @EndUserText.label: '欄位說明'
      columndescription 
      
}
