


CREATE  View [dbo].[SIC_sys_Employee]
  
as

/*
select distinct tg.*,vgal.CPNum,vgal.OCTNum,MENNum from tcdsb_vTrillium_sap_gal vgal
inner join trillum_tblsap_gal tg on tg.pernr=vgal.pernr and tg.orgunit_code=vgal.orgunit_code
and tg.positionDesc=vgal.positionDesc and isnull(tg.exchange_NTUserID,'')=isnull(vgal.exchange_NTUserID,'')
*/

--- select * from trilliumsql01.rsecurity.dbo.tcdsb_vTrillium_sap_gal  Modify by Frank @ 2017/01/16 trilliumsql01 dose not exists in tcDevDB01 Database
 

select  
AsOfDate, UserID, FirstName,LastName,CPNum, right(OrgUnit_Code,4) as SchoolCode,  Pernr,ExchangeAlias,Exchange_NTUserID_Domain,HR_UID,OrgUnit_Code,OrgUnit_desc,KnowAsName,PositionDesc,CustomerStatusCode,CustomerStatusCodeDesc,GenderCode,GenderCodeDesc,PickedForGAL,FTE,SIN,PerSubAreaCode,OCTNum,MENNum,BoardSeniorityDate,ElementarySeniorityDate,SecondarySeniorityDate,ClassTypeIDCode,ClassTypeIDDesc,NTIP_Flag,NTIP_OOP_Flag,JobScore, ActionTypeReason, ActionStart,ActionEnd, UniqueID

 from dbo.tcdsb_SAP_Base --   [dbo].[Trillium_SAP] --  dbo.tcdsb_vTrillium_sap_gal
 where UserID is not null
