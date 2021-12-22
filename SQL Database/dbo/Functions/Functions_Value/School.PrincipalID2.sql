
-- =================================================================================
-- Author:		Frank Mi
-- Create date: Jan 10, 2017
-- Description:	enhance to get school principal ID 
-- ===================================================================================


-- drop function    select dbo.SchoolPrincipalCurrent ('0290', '20132014','ID')
CREATE Function [dbo].[School.PrincipalID2]
(@SchoolCode varchar(8),
 @SchoolYear varchar(8)=null)
RETURNS varchar(13)
as
begin 
	declare @rValue varchar(50) , @max_end_date datetime
    set @max_end_date=(select max(end_date) from school_years 
	                   where  school_year = @SchoolYear and school_code =@SchoolCode
					   )
   if @SchoolYear is null set @SchoolYear = [dbo].[CurrentSchoolYear](getdate())
 -- ****************************************************************************************
  ---  Application needs handle the Monsigner Fraser College Principal
  --  set Monsignor Fraser College  school ='0500,0532,0533,0534,0539,0557,0558,0564,0566,0567' 
  -- if @SchoolCode in ('0500','0532','0533','0534','0539','0557','0558','0564','0566','0567' )
  --    set @SchoolCode ='0533'
 -- ********************************************************************************************  
  set  @rValue =( select top 1 person_id      
				 From school_staff
 	  		     WHERE  school_year = @SchoolYear and school_code = @SchoolCode  and principal_flag = 'x'
						and  (end_date=@max_end_date or end_date>=getdate() )   ---- and  status_indicator_code = 'Active' and 
    				    and  staff_type_name LIKE '%prin%'  
				 order by staff_type_name
				)
                                                                             
   set @rValue = isnull(@rValue,  '')

Return(@rValue)
 
end 
 



