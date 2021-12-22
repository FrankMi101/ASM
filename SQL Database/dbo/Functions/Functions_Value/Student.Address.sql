






-- =================================================================================
-- Author:		Frank Mi
-- Create date: November 16, 2015
-- Modified   : Delete all other non- address attribut 
-- Description:	get student information by person id 
-- ===================================================================================
 

CREATE FUNCTION [dbo].[Student.Address] (@Person_id char(13),@OBJ_attribt char(30) )  
RETURNS varchar(100)
--- @perason_id  
--- @OBJ_attribt   Student  Object's attribt  one of 'Number'/'Name'/Grade'/'Gender'/'Telephone'/'Parents'/ .....
AS  
   BEGIN
             declare @rValue varchar(100)
	declare @rDoctorname varchar (30)
	declare @rDoctorphone varchar (30)
             declare @ReleshipID varchar(13)
             declare @rDate    smalldatetime
	declare @school_year varchar(8)
	declare @school_code varchar(4)
              declare @school_date smalldatetime
              declare @PFirstName  varchar(20)
              declare @LFirstName   varchar(20)  
	declare  @CreditT   numeric(8,1)

 
	if @OBJ_attribt ='Address'   
        set @rValue =  dbo.FindStudentAddress (@person_id ,'All')
	else if @OBJ_attribt ='Address1'   
        set @rValue =  dbo.FindStudentAddress (@person_id ,'Street') + '  ' +  dbo.FindStudentAddress (@person_id ,'City') + '  ' +  dbo.FindStudentAddress (@person_id ,'Province') + '  ' +  dbo.FindStudentAddress (@person_id ,'Country')
	else if @OBJ_attribt ='AddressLine1'   
  	 	begin      
	           set @rValue =   dbo.FindStudentAddress (@person_id ,'Street') + 
	           case dbo.FindStudentAddress (@person_id ,'Unit') when '0000' then ''
	           else  ' ' + dbo.FindStudentAddress (@person_id ,'UnitType') +' ' +  dbo.FindStudentAddress (@person_id ,'Unit')  end
	           + ' ' + dbo.FindStudentAddress (@person_id ,'City') 
	     end      
	else if @OBJ_attribt ='AddressLine2'   
          set @rValue =  dbo.FindStudentAddress (@person_id ,'Province') + '  ' + dbo.FindStudentAddress (@person_id ,'PostCode') + ' ' +  dbo.FindStudentAddress (@person_id ,'Country')
	else if @OBJ_attribt ='Street'   
          set @rValue =  dbo.FindStudentAddress (@person_id ,'Street')  
	else if @OBJ_attribt ='StreetLine'   
          set @rValue = dbo.FindStudentAddress (@person_id ,'Street') + ' ' + 
	           case dbo.FindStudentAddress (@person_id ,'Unit') when '0000' then ''
	           else  ' ' + dbo.FindStudentAddress (@person_id ,'UnitType') +' ' +  dbo.FindStudentAddress (@person_id ,'Unit')  end
	else if @OBJ_attribt ='StreetName'   
          set @rValue =  dbo.FindStudentAddress (@person_id ,'StreetName')
	else if @OBJ_attribt ='StreetNo'   
         set @rValue =  dbo.FindStudentAddress (@person_id ,'StreetNo')
	else if @OBJ_attribt ='StreetNoQualifier'   
         set @rValue =  dbo.FindStudentAddress (@person_id ,'StreetNoQ')
	else if @OBJ_attribt ='Unit'   
         set @rValue =  dbo.FindStudentAddress (@person_id ,'Unit')
	else if @OBJ_attribt ='Unit2'   
         set @rValue =  case dbo.FindStudentAddress (@person_id ,'Unit')
							  when '0000' then ''	
							  else dbo.FindStudentAddress (@person_id ,'UnitType') +' ' +  dbo.FindStudentAddress (@person_id ,'Unit')
							  end
	else if @OBJ_attribt ='City'   
         set @rValue =  dbo.FindStudentAddress (@person_id ,'City')
	else if @OBJ_attribt ='CityLine'   
		begin
			set @rValue =  dbo.FindStudentAddress (@person_id ,'PostCode')
            if len(@rValue) =6  set @rValue = left(@rValue,3) + ' ' + right(@rValue,3)
            set @rValue =  dbo.FindStudentAddress (@person_id ,'City') +  ' ' + dbo.FindStudentAddress (@person_id ,'Province') + '  ' + @rValue  
		end
	else if @OBJ_attribt ='PostCode'
		begin
			set @rValue =  dbo.FindStudentAddress (@person_id ,'PostCode')
            if len(@rValue) =6  set @rValue = left(@rValue,3) + ' ' + right(@rValue,3)
                                     
	    end    
	else if @OBJ_attribt ='Telephone'   
  	 	begin      
			set @rValue =  dbo.personphonenumber(@person_id,'Home')
		    set @rValue = isnull(@rValue, 'Non')        	      				 
		end    
  	else if @OBJ_attribt ='Telephone1'   
  	 	begin      
	        set @rValue =  dbo.personphoneshort(@person_id,'Home')
		    set @rValue = isnull(@rValue, ' ')        	      				 
	    end      	 
  

     RETURN(@rValue)
  END



 















