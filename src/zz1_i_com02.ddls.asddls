@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '成本報表列次說明CDS VIEW'

define root view entity ZZ1_I_COM02
  as select from zz1_com02   
{
  key com02_uuid as com02uuid,
      bukrs      as companycode,
      rptno      as reportnumber,
      rptrw      as reportrow,
      rptcl      as reportcolumn,
      spras      as language,
      optxt      as operationprint,
      rwdsc      as rowdescription,
      cldsc      as columndescription,
      @Semantics.user.createdBy: true
      ernam      as createdby,
      @Semantics.systemDateTime.createdAt: true
      ertmp      as createdat,
      @Semantics.user.lastChangedBy: true
      laenam     as lastChangedby,
      @Semantics.systemDateTime.lastChangedAt: true
      laetmp     as lastChangedat
}
