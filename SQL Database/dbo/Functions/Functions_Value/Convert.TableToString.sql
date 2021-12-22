






-- =================================================================================
-- Author:		Frank Mi
-- Create date: August 18, 2021   Extend from ConvertRecordsToStrng
-- Description:	Convert multiple records value to one string 
-- ===================================================================================
CREATE function [dbo].[Convert.TableToString](@ObjTable SingleFieldTable READONLY , @Split varchar(2))
RETURNS varchar(2500)
as 
Begin
	declare @rVal varchar(2500), @N1 varchar(100)
	set @rVal =''

	DECLARE Records CURSOR
	For select distinct ltrim(rtrim(N1)) from @ObjTable  
  
    OPEN Records		
	FETCH NEXT FROM Records INTO @N1
	While @@FETCH_STATUS = 0
	begin
	   if len(@rVal) = 0
			set @rVal = @N1 
	   else
  			set @rVal = @rVal +  @Split   + @N1 		 
		FETCH NEXT FROM Records INTO  @N1 
	end
	CLOSE 	Records
	DEALLOCATE Records
	--if  len(@rVal)> 2  set @rVal= left(@rVal,len(@rVal) - 1)

	Return isnull(@rVal,'')
End
