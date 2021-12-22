

-- =================================================================================
-- Author:		Frank Mi
-- Create date: April 07, 2021
-- Description:	Get Student Program identification information 
-- =================================================================================
 
CREATE FUNCTION [dbo].[Student.Program](
@Program		varchar(10), -- /IEP/IPR/Gift/Alter/ISP/ESL/ELL
@Type			varchar(30), -- /Flag/Result/Progress/Name/Level/Class
@SchoolYear		varchar(8),
@SchoolCode		varchar(8), 
@PersonID		varchar(13)
)
RETURNS varchar(150)
AS 
BEGIN
	declare @rValue varchar(150)
  	 if @Program ='IEP' 
		begin
            if @Type = 'Flag'  
                begin
                    if exists ( select * from dbo.tcdsb_IEP_registration where school_year = @SchoolYear and Person_id = @PersonID and IEP_End is null)
                        set @rValue =  '1'
                    else
                        set   @rValue = '0'
                end
            if @Type ='Result'
                begin
                    if exists ( select * from dbo.tcdsb_IEP_registration where school_year = @SchoolYear and Person_id = @PersonID and IEP_End is null )
                        set @rValue = (select top 1 Excep1 from dbo.tcdsb_IEP_registration where school_year = @SchoolYear and Person_id = @PersonID and IEP_End is null)
                    else
                        set   @rValue = ''
                end
            if @Type ='Name'
                begin
                    if exists ( select * from dbo.tcdsb_IEP_registration where school_year = @SchoolYear and Person_id = @PersonID and IEP_End is null)
                        set @rValue = (select top 1 Excep1 from dbo.tcdsb_IEP_registration where school_year = @SchoolYear and Person_id = @PersonID and IEP_End is null)
                    else
                        set   @rValue = ''
                end
            if @Type ='Class'
                begin
                    if exists ( select * from dbo.tcdsb_IEP_registration where school_year = @SchoolYear and Person_id = @PersonID and IEP_End is null)
                        set @rValue = (select top 1 Excep1 from dbo.tcdsb_IEP_registration where school_year = @SchoolYear and Person_id = @PersonID and IEP_End is null)
                    else
                        set   @rValue = 'No Class'
                end
        end
  	else if @Program ='Gift' 
		begin
			if @Type = 'Flag'  
				begin
					if  exists ( select * from dbo.tcdsb_IEP_registration where school_year = @SchoolYear  and Person_id = @PersonID  and IEP_End is null and Excep1 ='060')
						set @rValue =  '1'
					else
						set   @rValue = '0'
				end
			if @Type ='Result'
				begin
					if  exists ( select * from dbo.tcdsb_IEP_registration where school_year = @SchoolYear  and Person_id = @PersonID  and IEP_End is null and Excep1 ='060')
						set @rValue = (select top 1 Excep1 from dbo.tcdsb_IEP_registration where school_year = @SchoolYear  and Person_id = @PersonID  and IEP_End is null and Excep1 ='060')
 					else
					   set   @rValue = ''
				end
			if @Type ='Name'
				begin
					if  exists ( select * from dbo.tcdsb_IEP_registration where school_year = @SchoolYear  and Person_id = @PersonID  and IEP_End is null and Excep1 ='060')
						set @rValue = (select top 1 Excep1  from dbo.tcdsb_IEP_registration where school_year = @SchoolYear  and Person_id = @PersonID  and IEP_End is null and Excep1 ='060')
 					else
					   set   @rValue = ''
				end
			if @Type ='Class'
				begin
					if  exists ( select * from dbo.tcdsb_IEP_registration where school_year = @SchoolYear  and Person_id = @PersonID  and IEP_End is null and Excep1 ='060')
						set @rValue = (select top 1 Excep1 from dbo.tcdsb_IEP_registration where school_year = @SchoolYear  and Person_id = @PersonID  and IEP_End is null and Excep1 ='060')
 					else
					   set   @rValue = 'No Class'
				end
		end

	else if @Program ='ISP' 
		begin
			if @Type = 'Flag'  
				begin
					if  exists ( select * from  tcdsb_Trillium_ISP_Students  where school_year = @SchoolYear  and school_code = @SchoolCode and Person_id = @PersonID )
						set @rValue =  '1'
					else
						set   @rValue = '0'
				end
			if @Type ='Result'
				begin
					if  exists ( select * from  tcdsb_Trillium_ISP_Students where school_year = @SchoolYear  and school_code = @SchoolCode and Person_id = @PersonID )
						set @rValue = (select top 1 Full_name from tcdsb_Trillium_ISP_Students where school_year = @SchoolYear  and school_code = @SchoolCode and Person_id = @PersonID)
 					else
					   set   @rValue = ''
				end
			if @Type ='Name'
				begin
					if  exists ( select * from  tcdsb_Trillium_ISP_Students where school_year = @SchoolYear  and school_code = @SchoolCode and Person_id = @PersonID )
						set @rValue = (select top 1 Full_name from tcdsb_Trillium_ISP_Students where school_year = @SchoolYear  and school_code = @SchoolCode and Person_id = @PersonID)
 					else
					   set   @rValue = ''
				end
			if @Type ='Class'
				begin
					if  exists ( select * from  tcdsb_Trillium_ISP_Students where school_year = @SchoolYear  and school_code = @SchoolCode and Person_id = @PersonID )
						set @rValue = (select top 1 class_code from tcdsb_Trillium_ISP_Students where school_year = @SchoolYear  and school_code = @SchoolCode and Person_id = @PersonID)
 					else
					   set   @rValue = 'No Class'
				end
		end
  	 if @Program ='SHSM' 
		begin
             if exists ( select * from dbo.fs_student_awards where Person_id = @PersonID and award ='SHSM' and shsm_dropped_flag_10 ='0' and shsm_school_bsid = dbo.[School.BSID](@SchoolCode) )
				set @rValue = (select top 1 case @Type  when 'Flag' then 'Yes' 
														when 'Code' then isnull(DESTINATION_CODE,'')
														when 'Focus' then isnull(shsm_focus,'')
														else  requirement_version end
							   from dbo.fs_student_awards 
							   where Person_id = @PersonID and award ='SHSM' and shsm_dropped_flag_10 ='0' and shsm_school_bsid = dbo.[School.BSID](@SchoolCode)  
								)
			 else
				set @rValue = case @Type  when 'Flag' then 'No' else ''  end 
        end		 
 	 if @Program ='SHSM2' 
		begin
             if exists ( select * from dbo.fs_student_awards where Person_id = @PersonID and award ='SHSM' and shsm_dropped_flag_10 ='0' and shsm_school_bsid = dbo.[School.BSID](@SchoolCode) )
				set @rValue = (select top 1 case @Type  when 'Flag' then 'Yes' 
														when 'Code' then isnull(DESTINATION_CODE,'')
														when 'Focus' then isnull(shsm_focus,'')
														else  requirement_version end
							   from dbo.fs_student_awards 
							   where Person_id = @PersonID and award ='SHSM' and shsm_dropped_flag_10 ='0' -- and shsm_school_bsid = dbo.[School.BSID](@SchoolCode)  
								)
			 else
				set @rValue = case @Type  when 'Flag' then 'No' else ''  end 
        end		 
  set @rValue = isnull(@rValue,'') 
  RETURN(@rValue)
END


