



-- =================================================================================
-- Author:		Frank Mi
-- Create date: October 21, 2015   change by Frank @ 2017/09/05
-- Description:	to get current school principal inforamtion by schoolcode 
-- ===================================================================================


-- drop function    select dbo.SchoolPrincipalCurrent ('0290', '20132014','ID')
CREATE Function [dbo].[School.Principal]
(@SchoolCode varchar(8),
 @NameType varchar(20))
RETURNS varchar(50)
as
begin 
	declare @rValue varchar(50)
 
   --  set Monsignor Fraser College  school ='0500,0532,0533,0534,0539,0557,0558,0564,0566,0567' 
  if @SchoolCode in ('0500','0532','0533','0534','0539','0557','0558','0564','0566','0567' )
      set @SchoolCode ='0533'
    

		  if exists (select * from [dbo].[tcdsb_PrincipalsCoordinators] where school_code =  @Schoolcode and [Status] ='3-Active' and Title in ('Principal','Coordinator') )
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
 
  if @Nametype ='Name' 
			set @rValue = ( select top 1 Lastname + ', ' + Firstname  
							from tcdsb_TPA_TCDSBStaff 
							where userid = @rValue)
  else if @Nametype ='NameIEP' 
			set @rValue = ( select top 1  left(ltrim(isnull(Firstname,'')),1) + '. ' +   isnull(Lastname,'') 
							from tcdsb_TPA_TCDSBStaff 
							where userid = @rValue)
			
  else if @Nametype ='NameCall' 
			set @rValue = ( select top 1  Firstname+ ' ' +   Lastname
							from tcdsb_TPA_TCDSBStaff 
							where userid = @rValue)
  else if @Nametype ='NameShort' 
	   	   
			set @rValue = ( select top 1  'Mr. '  + left(Firstname,1) + '. ' +   Lastname
							from tcdsb_TPA_TCDSBStaff 
							where userid = @rValue)
		
  else if @Nametype ='SurName' 
			set @rValue = ( select top 1     Lastname
							from tcdsb_TPA_TCDSBStaff 
							where userid = @rValue)
  else if @Nametype ='FirstName' 
			set @rValue = ( select top 1  Firstname 
							from tcdsb_TPA_TCDSBStaff 
							where userid = @rValue)
  else if @Nametype ='UserID' 
			set @rValue = ( select top 1  UserID 
							from tcdsb_TPA_TCDSBStaff 
							where userid = @rValue)
  else if @Nametype ='CPNum' 
			set @rValue = ( select top 1  CPNum 
							from tcdsb_TPA_TCDSBStaff 
							where userid = @rValue)
   else if @Nametype ='Email' 
			set @rValue =  [dbo].[School.Principal.eMailAddress](@SchoolCode, @rValue)

  set @rValue = isnull(@rValue,  'Non Principal')

  Return(@rValue)
 


 
end 
 

