


-- =================================================================================
-- Author:		Frank Mi
-- Create date: October 21, 2015   change by Frank @ 2017/09/05
-- Description:	to get current school principal inforamtion by schoolcode 
-- ===================================================================================


-- drop function    select dbo.SchoolPrincipalCurrent ('0290', '20132014','ID')
CREATE Function [dbo].[School.Principal.ID.LTO]
(@SchoolYear varchar(8),
 @SchoolCode varchar(8))
RETURNS varchar(50)
as
begin 
	declare @rValue varchar(50)
 
   --  set Monsignor Fraser College  school ='0500,0532,0533,0534,0539,0557,0558,0564,0566,0567' 
		  if @SchoolCode in ('0500','0532','0533','0534','0539','0557','0558','0564','0566','0567' )    set @SchoolCode ='0533'
     
	      if exists (select * from  dbo.tcdsb_LTO_Principal_NewSchool_BeforeSept1 where school_code =  @Schoolcode and active  ='X'  ) 
		       select top 1  @rValue = UserID from dbo.tcdsb_LTO_Principal_NewSchool_BeforeSept1 where school_code =  @Schoolcode and active  ='X'
 		  else if exists (select * from [dbo].[tcdsb_PrincipalsCoordinators] where school_code =  @Schoolcode and [Status] ='3-Active' and Title in ('Principal','Coordinator') )
				select top 1  @rValue = UserID from [dbo].[tcdsb_PrincipalsCoordinators] 
				where school_code = @Schoolcode and [Status] ='3-Active' and Title in ('Principal','Coordinator') 
				order by DataSource
		  else if exists (select * from [dbo].[tcdsb_PrincipalsCoordinators] where school_code =  @Schoolcode and [Status] ='3-Active' and Title in ('Vice Principal') )
			    select top 1  @rValue = UserID from  [dbo].[tcdsb_PrincipalsCoordinators] 
			    where school_code = @Schoolcode and [Status] ='3-Active' and Title in ('Vice Principal') 
  				order by DataSource
		  else if exists ( select * from tcdsb_tpa_schools where school_code = @Schoolcode and school_code !='0000')
				select top 1 @rValue =  default_AdminID  from tcdsb_tpa_schools where school_code = @Schoolcode
		  else
				set @rValue ='No Principal'
 
  
   set @rValue = isnull(@rValue,  'No Principal')

  Return(@rValue)
 


 
end 
 


