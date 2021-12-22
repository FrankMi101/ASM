






-- =================================================================================
-- Author:		Frank Mi
-- Create date: May  18, 2018    
-- Description:	to get Student MedicalInformation informatino 
-- ===================================================================================
CREATE FUNCTION [dbo].[Student.MedicalInformation] 
	(@PersonID varchar(13), 
	 @SchoolYear varchar(8), 
	 @Attr varchar(30) 
	 )  
RETURNS varchar(50)
 
AS  
   BEGIN
            declare @rValue varchar(50)
	if @Attr ='MedicalCondition'  
		begin
			declare @Anaphylaxis varchar(1), @Asthma varchar(1), @Diabetes  varchar(1) ,@Seizures varchar(1)
			select @Anaphylaxis='0', @Asthma='0', @Diabetes ='0', @Seizures='0'
			if exists (select * from  person_medical_details where person_id = @PersonID)
			   begin
					set @Anaphylaxis = (select Top 1  '1' FROM  medical_details as MD
						inner join person_medical_details as PMD on MD.medical_detail_id = PMD.medical_detail_id
       					where PMD.person_id = @personID and MD.active_flag ='x' and full_name like ('%Anaphyla%') )
					set @Asthma = (select Top 1  '1' FROM  medical_details as MD
						inner join person_medical_details as PMD on MD.medical_detail_id = PMD.medical_detail_id
       					where PMD.person_id = @personID and MD.active_flag ='x' and full_name like ('%Asthma%') )
					set @Diabetes = (select Top 1  '1' FROM  medical_details as MD
						inner join person_medical_details as PMD on MD.medical_detail_id = PMD.medical_detail_id
       					where PMD.person_id = @personID and MD.active_flag ='x' and full_name like ('%@Diabeti%') )
					set @Seizures = (select Top 1  '1' FROM  medical_details as MD
						inner join person_medical_details as PMD on MD.medical_detail_id = PMD.medical_detail_id
       					where PMD.person_id = @personID and MD.active_flag ='x' and full_name like ('%@Seizure%') )
                    set @rValue =  isnull(@Anaphylaxis,'0') + isnull(@Asthma,'0') + isnull(@Diabetes,'0') + isnull(@Seizures,'0')
				end		
			else
				set @rValue ='0000'
		end
	if @Attr ='MedicalInfo'  
			if exists (select * from  person_medical_details where person_id = @PersonID)
			set @rValue = (select Top 1  full_name 
	   					FROM  medical_details as MD
						inner join person_medical_details as PMD on MD.medical_detail_id = PMD.medical_detail_id
       					where PMD.person_id = @personID and MD.active_flag ='x' )
		else
			set @rValue =''
	if @Attr ='MedicalOther'
 		if exists (select * from  person_medical_details where person_id = @PersonID)
			set @rValue = (select Top 1  full_name 
	   					FROM  medical_details as MD
						inner join person_medical_details as PMD on MD.medical_detail_id = PMD.medical_detail_id
       					where PMD.person_id = @personID and MD.active_flag ='x' )
		else
			set @rValue =''

	 
       RETURN(@rValue)
  END





