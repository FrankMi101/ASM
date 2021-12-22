












 
 
-- ============================================================================
-- Author		: Frank Mi
-- Create date	: August 19, 2021 .  
-- Description	: check staff is a permanent position
-- =============================================================================  

CREATE FUNCTION [dbo].[Staff.IsPermanent](@CPNum varchar(10)  )  
RETURNS varchar(10) 
AS  
   BEGIN
        declare @rValue varchar(10)  
		if exists (select 1 from dbo.Trillium_SAP where CPNum = @CPNum and PickedForGAL ='X' and PerSubAreaCode in ('1002', '1003','1004','1005') )
			set @rValue ='Yes'
		else
			set @rValue ='No'
	   
	 RETURN(isnull(@rValue,''))
  END



  












