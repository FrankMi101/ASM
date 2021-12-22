



-- =================================================================================
-- Author:		Frank Mi
-- Create date: November 29, 2020    by Frank @ 2017/09/05
-- Description:	to get current school principal inforamtion by schoolcode 
-- ===================================================================================


-- drop function   [dbo].[School.Principal.SIC]
CREATE Function [dbo].[School.Principal.SIC]
(@SchoolCode varchar(8),
 @NameType varchar(20))
RETURNS varchar(50)
 
as
begin 
	declare @rValue varchar(50), @userID varchar(30)
  
	if @SchoolCode in ('0500','0532','0533','0534','0539','0557','0558','0564','0566','0567' )  set @SchoolCode ='0533'
  --  if exists( select top 1 school_code from [dbo].[School.MsgrFraser]() where School_Code = @SchoolCode ) set @SchoolCode ='0533'
	set  @userID = (select top 1 default_AdminID  from dbo.[SIC_sys_Schools] where school_code = @Schoolcode )
  
	set @rValue =( select  top 1  Case @Nametype	when 'Name'		then Lastname + ', ' + Firstname 
													when 'SurName'	then Lastname
													when 'FirstName'then Firstname
													when 'UserID'	then UserID
													when 'CPNum'	then CPNum
													else  Firstname  + ' ' + Lastname  end
				   from [dbo].[SIC_sys_Employee]
					where  userID  = @userID
					) 

  Return(@rValue)
 
 
end 
 

