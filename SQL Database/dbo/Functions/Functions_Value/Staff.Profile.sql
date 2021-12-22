





 
 
-- ============================================================================
-- Author:		Frank Mi
-- Create date: March 21, 2021  
-- Description:	Get SAP Staff profile by user ID or CPNum
-- =============================================================================  

CREATE FUNCTION [dbo].[Staff.Profile](@UserID varchar(20),@Type varchar(30) )  
RETURNS varchar(100) 
AS  
   BEGIN
        declare @rValue varchar(100), @CPNum varchar(10)
		if ASCII(left(@UserID,1)) between  48 and 57
			set @UserID =  (select top 1 UserID  from dbo.SIC_sys_Employee where CPNum = @UserID )
 	 
		set @rValue = (	select top 1	case @Type	when 'CPNum'	then CPNum
													when 'Name'		then LastName + ', ' + FirstName
													when 'UserID'	then UserID
													when 'School'	then SchoolCode
													when 'Unit'		then OrgUnit_desc
													when 'Position'	then PositionDesc
													when 'Class'	then ClassTypeIDDesc
													when 'Status'	then CustomerStatusCode
													when 'FTE'		then FTE
													when 'SIN'		then [SIN]
													when 'Pernr'		then Pernr
													else 	HR_UID end
					 		from dbo.SIC_sys_Employee
							where UserID = @UserID 	
							order by PickedForGAL DESC , FTE DESC)			
	 

	 RETURN  isnull(@rValue,'')
  END



 















