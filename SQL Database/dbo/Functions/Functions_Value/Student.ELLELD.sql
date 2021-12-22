








-- =================================================================================
-- Author:		Frank Mi
-- Create date: May  18, 2018    
-- Description:	to get Student ELL /ELD informatino 
-- ===================================================================================
CREATE FUNCTION [dbo].[Student.ELLELD] 
	(@PersonID varchar(13), 
	 @SchoolYear varchar(8), 
	 @Attr varchar(30) 
	 )  
RETURNS varchar(10)
 
AS  
   BEGIN
            declare @rValue varchar(10)

	if @Attr ='ELL'   
		begin
			if exists(select top 1 * from student_registrations where school_year=@SchoolYear 	and person_id= @PersonID
						and (isnull(esl_level_code,'') <>'' or isnull(english_skills_development,'')<>''))
				set @rValue='Y'
			else
				set @rValue='N'
		end 
	else if @Attr ='ESL'
		begin
			if exists(select top 1 person_id from student_registrations where school_year= @SchoolYear 	and person_id= @PersonID
						and isnull(esl_level_code,'') <>'' )
				set @rValue=(select top 1 case when esl_level_code > 0 then 'Y' else 'N' end from student_registrations where school_year= @SchoolYear 	and person_id= @PersonID
						and isnull(esl_level_code,'') <>'' )
			else
				set @rValue='N'
				 
		end 
	else if @Attr ='ELD'    
		begin
			if exists(select top 1 person_id from student_registrations where school_year= @SchoolYear 	and person_id= @PersonID
						and isnull(english_skills_development,'') <>'' )
				set @rValue=(select top 1 case when english_skills_development > 0 then 'Y' else 'N' end from student_registrations where school_year= @SchoolYear 	and person_id= @PersonID
						and isnull(english_skills_development,'') <>'' )
			else
				set @rValue='N'
				 
		end 
   else 
        select @rValue=case esl_level_code when '' then english_skills_development else esl_level_code end from student_registrations
		where school_year= @SchoolYear 	and person_id= @PersonID
		and (isnull(esl_level_code,'') <>'' or isnull(english_skills_development,'')<>'')
 
	 
       RETURN(isnull(@rValue,'0'))
  END







