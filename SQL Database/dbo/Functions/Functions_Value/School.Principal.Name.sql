



-- =================================================================================
-- Author:		Frank Mi
-- Create date: October 21, 2015
-- Description:	to get current school principal Name by schoolcode 
-- ===================================================================================


-- drop function    select dbo.SchoolPrincipalCurrent ('0290', '20132014','ID')
CREATE Function [dbo].[School.Principal.Name]
(@SchoolCode varchar(8),
 @NameType varchar(20))
RETURNS varchar(50)
as
begin 
	declare @rValue varchar(50)
 
   --  set Monsignor Fraser College  school ='0500,0532,0533,0534,0539,0557,0558,0564,0566,0567' 
  if @SchoolCode in ('0500','0532','0533','0534','0539','0557','0558','0564','0566','0567' )    set @SchoolCode ='0533'
   
 
  set @rValue = (select top 1 UserID from dbo.tcdsb_TPA_TCDSBPrincipals
						where LocationID =   @SchoolCode  and Status  = '3-Active'
						order by Title, PerNo desc )
 
  if @Nametype ='Name' 
			set @rValue = ( select top 1 Lastname + ', ' + Firstname  
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
         set @rValue =  @rValue 
   set @rValue = isnull(@rValue,  'Non Principal')

  Return(@rValue)
 


 
end 
 

