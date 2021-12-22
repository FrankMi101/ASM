


CREATE FUNCTION [dbo].[Student.ID] (@Type varchar(20), @ObjID varchar(20))  
RETURNS varchar(100)
--- Frank Mi
--- March 14, 2002
--- @perason_id  
--- @OBJ_attribt   Student  Object's attribt  one of 'Number'/'Name'/Grade'/'Gender'/'Telephone'/'Parents'/ .....
AS  
   BEGIN
		declare @rValue varchar(15)

    if @Type in ('NumToID','NumToOEN')
 	     set @rValue = (  select top 1 case @Type	when 'NumToID'  then person_id
													when 'NumToOEN' then oen_number
													else student_no  end 
						  from dbo.persons where student_no = @ObjID							
						)    
	else if @Type in ('OENToID','OENToNum')
  	     set @rValue = (  select top 1 case @Type   when 'OENToID'  then person_id
													when 'OENToNum' then student_no
													else oen_number  end 
						  from dbo.persons where oen_number = @ObjID							
						)
	else
 	     set @rValue = (  select top 1 case @Type	when 'NumberF'  then left(student_no,3) +'-'+ substring(student_no,4,3) + '-' + right(student_no,3)
													when 'Number' then student_no
													when 'O-E-N'  then left(oen_number,3) +'-'+ substring(oen_number,4,3) + '-' + right(oen_number,3)
													when 'OEN'	  then  oen_number
													else person_id  end 
						  from dbo.persons where person_id = @ObjID							
						)
       RETURN(@rValue)
  END



 












