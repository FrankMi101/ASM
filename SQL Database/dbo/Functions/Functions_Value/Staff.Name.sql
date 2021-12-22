









 
 
-- ============================================================================
-- Author		: Frank Mi
-- Create date	: March 13, 2017 . 
--				: Enhancement at 2017/01/30
--				: Enhancement at 2019/01/03   @StaffID could be a cpnum  or userid
--				: Simplefy by Case at 2019/01/03   @StaffID could be a cpnum  or userid
-- Description	: Staff Name by CPNum
-- =============================================================================  

CREATE FUNCTION [dbo].[Staff.Name](@StaffID varchar(30),@OBJ_attribt varchar(30) )  
RETURNS varchar(50) 
AS  
   BEGIN
        declare @rValue varchar(50) , @firstASCII int

	    if isnull(@StaffID,'') ='' 
		   set  @rValue =''
        else       
		   begin
				set @firstASCII = ascii(left(@StaffID,1))
				if (@firstASCII > 47 and @firstASCII <58)
					set @rValue = (select top 1 case @OBJ_attribt
													when 'Name'			then Firstname + ' ' + lastname 
													when 'NameOK'		then Firstname + ' ' +  + replace(lastname,'''','`')  
													when 'SurName'		then lastname
													when 'FirstName'	then Firstname
													when 'NameL'		then lastname  + ', ' + Firstname
													else  Firstname + ' ' + lastname end
									  from  dbo.SIC_sys_Employee where CPNum =  @StaffID  	order by CustomerStatusCode DESC )
				else
			 		set @rValue = (select top 1 case @OBJ_attribt
													when 'Name'			then Firstname + ' ' + lastname 
													when 'NameOK'		then Firstname + ' ' + replace(lastname,'''','`') 
													when 'SurName'		then lastname
													when 'FirstName'	then Firstname
													when 'NameL'		then lastname  + ', ' + Firstname
													else  Firstname + ' ' + lastname end
									  from   dbo.SIC_sys_Employee where UserID =   @StaffID 	order by CustomerStatusCode DESC )
			end 
	 RETURN(isnull(@rValue,''))
  END



  












