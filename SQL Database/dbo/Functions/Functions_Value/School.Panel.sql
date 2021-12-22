




-- =================================================================================
-- Author:		Frank Mi
-- Create date: October 21, 2015
-- Description:	to enhancement get school name by schoolcode 
-- ===================================================================================
 
CREATE Function [dbo].[School.Panel](@SchoolCode char(4))
RETURNS varchar(20)
as
begin 
   declare @rValue varchar(20)
   set @rValue = case left(@schoolCode,2)	when '02' then 'Elementary'
											when '03' then 'Elementary'
											when '04' then 'Elementary'
											when '05' then 'Secondary'
											when 'c5' then 'Secondary'
											when 'XI' then 'Elementary'
											else 'E/S Panel' end
    
     Return(@rValue)
 
end 

