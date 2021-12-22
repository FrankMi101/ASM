




-- ============================================================================
-- Author:		Frank Mi
-- Create date:Decmber 12, 2016 
-- Description:	cget school list by Area for Referral Case management
-- =============================================================================


CREATE FUNCTION [dbo].[SchoolList.byArea]
	(@Area  varchar(10)
	 )
 
 
  RETURNS @SchoolList  TABLE 
		(School_Code varchar(8),
		 School_Name varchar(200),
		 School_Name_B  varchar(50) ,
		 School_Area   varchar(10) 
)

AS 
BEGIN 
   if left(@Area,4) ='Area'
        insert into @SchoolList
		select '0000','All Area Schools','All Area',@Area
		union
		Select distinct S.school_code,S.school_name, S.school_brief_name,A.School_Area 
		from schools as S
		inner join tcdsb_SSF_Referral_AreaSchoolList as A on S.school_code = A.School_Code 
		where A.School_Area  =@Area
   else 
        insert into @SchoolList
		select '0000','All Area Schools','All Area',@Area
		union
		Select distinct S.school_code,S.school_name, S.school_brief_name,A.School_Area 
		from schools as S
		inner join tcdsb_SSF_Referral_AreaSchoolList as A on S.school_code = A.School_Code 
		where A.School_Area  in (select school_area from  tcdsb_SSF_Referral_Area_Officer  where Area = @Area) 
	
RETURN  
	 

END   
