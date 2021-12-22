


CREATE FUNCTION [dbo].[Teacher.SchoolList]
	(@TeacherCPNum  varchar(10)= null,--- CPNum 
	 @TeacherID		varchar(13) =null,  --- PersonID
	 @UserID		varchar(20) =null   --- UserID
	 )
RETURNS   table   
--- Frank Mi
--- 2017.09.08 
 
AS
 
  return
  select right(Orgunit_code,4)  as School_Code, [dbo].[School.Name]( right(Orgunit_code,4) ) as School_Name, CustomerStatusCodeDesc,PickedForGAL
  from dbo.tcdsb_VSAP_GAL -- tcdsb_TPA_TCDSBStaff 
  where (ExchangeAlias =  @UserID or CPNum = @TeacherCPNum or Pernr = @TeacherID )   
		and left(right(Orgunit_code,4),2) in ('02','03','04','05')
 -- order by PickedForGAL, [status] DESC  

 
