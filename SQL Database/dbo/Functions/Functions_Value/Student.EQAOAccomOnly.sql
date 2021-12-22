


 -- drop function dbo.student

CREATE FUNCTION [dbo].[Student.EQAOAccomOnly] (@PersonID varchar(13), @SchoolYear varchar(8), @SchoolCode varchar(8) )  
RETURNS varchar(20)
--- Frank Mi
--- March 24 2016
--- @perason_id   
AS  
   BEGIN
            declare @rValue varchar(20)

         if exists ( select  * 	from  [dbo].[tcdsb_IEP_subject_strand] 	where school_year = @SchoolYear and Person_id = @PersonID)    
		      set  @rValue ='No' 
         else if exists ( select * from   [dbo].[tcdsb_IEP_EQAOTest]  where school_year =  @SchoolYear and person_id = @PersonID and  (reading =1 or writing =1 or mathematics =1 ))
			  set  @rValue ='Yes'   
		 else
		      set  @rValue ='Unkonw'   
			      
		 
		  /*
			
		select  A.school_year,  dbo.school(school_code,'Name') as School, School_code, Grade, Student_name,  Student_no, A.person_id, Excep_Text as Exceptionality ,IPRC_text as Placement 
		,Q.EQAOType
		from  [dbo].[tcdsb_IEP_Registration_Exceptionality_Active] as A 
		inner join  [dbo].[tcdsb_IEP_EQAOTest]  as Q on A.school_year =Q.school_year  and A.person_id =Q.person_id and  (reading =1 or writing =1 or mathematics =1  )
		where A.school_year ='20152016' and left(A.school_code,2) ='05' 
			 and A.Person_id not  in (  select person_id from [dbo].[tcdsb_IEP_subject_strand] where school_year ='20152016' )
         */

       RETURN(@rValue)
  END



