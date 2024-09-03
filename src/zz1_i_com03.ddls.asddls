@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '成本報表列次計算公式CDS VIEW'

define root view entity ZZ1_I_COM03
  as select from zz1_com03
{
  key com03_uuid as com03uuid,
      bukrs      as companycode,
      rptno      as reportnumber,
      rptrw      as reportrow,
      rptcl      as reportcolumn,
      rseq       as serialnumber,
      opcd       as operation,
      srcty      as sourcetype,
      bklas      as valuationclass,
      bwart      as goodsmovementtype,
      categ     as materialledgercategory,
      ptyp      as processcategory,
      hkont      as glaccount,
      hkott      as accountto,
      fkber      as functionarea,
      kstar      as costelement,
      srcrw      as sourcerow,
      srccl      as sourcecolumn,
      @Semantics.user.createdBy: true
      ernam      as createdby,
      @Semantics.systemDateTime.createdAt: true
      ertmp      as createdat,
      @Semantics.user.lastChangedBy: true
      laenam     as lastchangedby,
      @Semantics.systemDateTime.lastChangedAt: true
      laetmp     as lastchangedat
}
