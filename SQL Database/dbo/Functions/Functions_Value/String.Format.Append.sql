
-- =================================================================================
-- Author:		Frank Mi
-- Create date: January 07, 2021
-- Description:	 Appendsome Character to object
-- ===================================================================================

create FUNCTION [dbo].[String.Format.Append] 
(@Obj varchar(500),@Append varchar(50))  
RETURNS varchar(500)

AS  
   BEGIN
       declare @rValue varchar(500)
      if len(isnull(@Obj,'')) > 1 
	     set @rValue = rtrim(@Obj) + ' ' +  isnull(@Append,'')
      else
		 set @rValue = rtrim(@Obj)
		return rtrim(ltrim(@rValue))
   End