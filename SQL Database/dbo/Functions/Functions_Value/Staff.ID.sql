





 
-- ============================================================================
-- Author:		Frank Mi
-- Create date: August 15, 2017  
-- Description:	Staff Name by CPNum
-- =============================================================================  

CREATE FUNCTION [dbo].[Staff.ID](@UserID varchar(20),@OBJ_attribt varchar(30) )  
RETURNS varchar(50) 
AS  
   BEGIN
        declare @rValue varchar(20), @firstASCII int
		set @firstASCII = ascii(left(@UserID,1))
	    if isnull(@UserID,'') ='' 
		   set  @rValue =''
        else if (@firstASCII > 47 and @firstASCII <58)
			set @UserID = (select top 1 UserID  from  dbo.tcdsb_SAP_Base where CPNum =  @UserID )
		

		if exists (select 1 from dbo.tcdsb_SAP_Base where UserID = @UserID)
			 set @rValue = ( select top 1 case @OBJ_attribt	when 'CPNum'		 then CPNum
															when 'PernrNum'		 then Pernr
															when 'EmployeeID'	 then HR_UID
															when 'NetWorkUserID' then UserID
															when 'PersonID'		 then (select top 1  Person_id  from dbo.fs_staff_custom --  dbo.tcdsb_vSAP_GAL
																						where network_userid =   @UserID
																						order by last_update_date_time  DESC) 
															else  @UserID end
							from  dbo.tcdsb_SAP_Base 
							where UserID =  @UserID
							order by CustomerStatusCode DESC 
						 )
		else
			set @rValue = @UserID
 
	 RETURN(@rValue)
  END



 















