



 -- drop function dbo.student

CREATE FUNCTION [dbo].[Student.Name](@Person_id varchar(13),@OBJ_attribt varchar(30) )  
RETURNS varchar(100)
--- Frank Mi
--- January 27, 2017
--- @perason_id  
--- @OBJ_attribt   Student  Object's attribt  one of 'Number'/'Name'/Grade'/'Gender'/'Telephone'/'Parents'/ .....
AS  
   BEGIN
        declare @rValue varchar(100)
	    if isnull(@Person_id,'') ='' 
		   set  @rValue =''
        else
		   begin

     			if @OBJ_attribt ='NumberF'
				   set @rValue = (select top 1 left(student_no,3) +'-'+ substring(student_no,4,3) + '-' + right(student_no,3)
								  from persons where person_id =@Person_id)
     			else if @OBJ_attribt ='Number'
     			 
  	 			    set @rValue = dbo.FindStudentNo (@person_id)  
      
     			else if @OBJ_attribt ='O-E-N'
    	 		 	 set @rValue = (select top 1 left(oen_number,3) +'-'+ substring(oen_number,4,3) + '-' + right(oen_number,3) from persons where person_id = @person_id) 
     			else if @OBJ_attribt ='OEN'
    	 			 set @rValue = (select top 1 oen_number from persons where person_id = @person_id) 
 				else if @OBJ_attribt ='Name'
  						set @rValue = dbo.PersonName (@person_id,'Full') 
				else if @OBJ_attribt ='SurName'
  						set @rValue = dbo.PersonName (@person_id,'SurName') 
				else if @OBJ_attribt ='FirstName'
  					 set @rValue = dbo.PersonName (@person_id,'FirstName') 
				else if @OBJ_attribt ='NameF'
  					  set @rValue = dbo.PersonName (@person_id,'Name')  
	 
		end  

	 RETURN(@rValue)
  END



 













