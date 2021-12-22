





-- =================================================================================
-- Author:		Frank Mi
-- Create date: Dec 17, 2018
-- Description:	to get current tcdsb staff role
-- ===================================================================================
 
CREATE Function [dbo].[Staff.Role.TPA]
(
 @UserID varchar(20),
 @Position varchar(100) 
 )
RETURNS varchar(50)
as
begin 
	declare @rValue varchar(50) 
   if exists (select 1 from   dbo.tcdsb_TPA_position_match where  SAP_Position  = @Position )
      set @rValue = (select top 1 SES_Position  from  tcdsb_TPA_position_match where  SAP_Position  = @Position)
   else
      set @rValue ='Other'
						 
   set @rValue = isnull(@rValue,  'Other')

  Return(@rValue)
 
end 
 

