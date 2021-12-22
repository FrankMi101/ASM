





-- =================================================================================
-- Author		: Frank Mi
-- Create date	: September 23, 2015
-- Modfy		: by Frank at 2021/05/06  change Initial IPRC date comes from   dbo.tcdsb_IEP_PlacementInitial
-- Description	: get student Special Education info
-- ===================================================================================
 -- [dbo].[Student.SpecialEd](person_id,school_year,'Excep')
  
CREATE FUNCTION [dbo].[Student.SpecialEd](
@PersonID char(13),
@SchoolYear char(8),
@Type varchar(30) )
RETURNS varchar(250)
---@active   'Active'/'Inactive'/'PreReg'
AS 
BEGIN
  declare @rValue varchar(250)
  if @Type ='Excep'
		set @rValue = ( select top 1  isnull(Excep_Text,' ')
					from [dbo].[tcdsb_IEP_Registration_Exceptionality]
					where school_year =@SchoolYear and person_id = @PersonID 
		         )

  else if @Type ='Placement'
		set @rValue = (SELECT  top 1 isnull(IPRC_Text,' ')
					from dbo.tcdsb_IEP_Registration_Exceptionality
					where school_year =@SchoolYear and person_id = @PersonID )
  else if @Type ='IPRCDate'
		set @rValue = (SELECT  top 1 isnull(IPRC_Date,' ')
					from dbo.tcdsb_IEP_Registration_Exceptionality
					where school_year =@SchoolYear and person_id = @PersonID )

  else if @Type ='InitalIPRCDate'
		begin
			if exists (select * from dbo.tcdsb_IEP_Student_PlacementInitial  -- dbo.tcdsb_IEP_PlacementInitial -- dbo.tcdsb_SES_ExceptionalityIEP
 						 where person_ID = @PersonID and Excep1 <> '110' and school_year is not null and Placement1 is not null )
    			 set @rValue = ( select  top 1  dbo.DateF(IPRCDate,'YYYYMMDD')  
      							from  dbo.tcdsb_IEP_Student_PlacementInitial   --dbo.tcdsb_IEP_PlacementInitial
 								where person_ID = @PersonID and Excep1 <> '110' and school_year is not null   and Placement1 is not null 
								order by school_year,  IPRCDate  )
			  else
				 set @rValue =''
			--if exists (select * from  dbo.tcdsb_IEP_PlacementInitial -- dbo.tcdsb_SES_ExceptionalityIEP
 		--				 where person_ID = @PersonID and Excep_Code <> '110' and school_year is not null and school_code is not null  and PlacementCode is not null )
   -- 			 set @rValue = ( select  top 1  dbo.DateF(IPRC_Date,'YYYYMMDD')  
   --   							from  dbo.tcdsb_SES_ExceptionalityIEP
 		--						where person_ID = @PersonID and Excep_Code <> '110' and school_year is not null and school_code is not null and PlacementCode is not null  
			--					order by school_year,  IPRC_Date  )
			--  else
			--	 set @rValue =''
		end
  set @rValue = isnull(@rValue,'') 
  RETURN(@rValue)
END
 


