

-- =================================================================================
-- Author:		Frank Mi
-- Create date: Oct 30, 2020
-- Description:	get current School Representative by schoolcode 
-- ===================================================================================


-- drop function School

CREATE Function [dbo].[School.Representative](@Type varchar(20),@SchoolYear varchar(8), @SchoolCode char(4))
RETURNS varchar(20)
as
begin 
   declare @rValue varchar(20) 
   if @Type ='IEPCommittee'
		begin
			 set @rValue = (select top 1 UserID from dbo.tcdsb_SES_IEPCommitteeRepresentative
							where Groupid = @Type and Active = 'X' and Area = (	select top 1 Nursing_Area from [dbo].[tcdsb_SES_School_Region] where school_code = @SchoolCode  and Area not in  ('TCDSB','SBSLT'))
							)
		end

	else if @Type ='RemoveUser'
		begin
			 set @rValue = (select top 1 UserID  from dbo.tcdsb_SES_IEPCommitteeRepresentative
							where Groupid = @Type and Active = 'X' and Area = 'TCDSB' 
							)
		end
	else if @Type ='IPRC'
		begin
			set @rValue = (select top 1 UserID from dbo.tcdsb_SES_IEPCommitteeRepresentative
						where Groupid = @Type and Active = 'X' and Area = (	select top 1 Nursing_Area from [dbo].[tcdsb_SES_School_Region] where school_code = @SchoolCode  and Area not in  ('TCDSB','SBSLT'))
						)
		end

		  
    Return(@rValue)
 
end 
