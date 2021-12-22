

 
CREATE function [dbo].[Student.Medical](@personID varchar(13))
returns Varchar(500)
 as 
   begin
		 declare @MedicalT varchar (500)
		 declare @Medical varchar (200)
		 declare @Remark varchar (200)
		 set @MedicalT =''
	
		 DECLARE Student_Medical CURSOR 
		 FOR	SELECT Full_name, PMD.remark 
				FROM  medical_details as MD
				inner join person_medical_details as PMD on MD.medical_detail_id = PMD.medical_detail_id
				where PMD.person_id = @personID and MD.active_flag ='x' 

				  OPEN Student_Medical
				  FETCH NEXT FROM Student_Medical  INTO  @Medical,@Remark
				  WHILE  @@FETCH_STATUS = 0
					  begin
						if len(@MedicalT) > 1
						   set @Medical = '; ' +  @Medical + isnull( ' - ' + @Remark , '') 
						else
						   set @Medical =  @Medical + isnull( ' - ' + @Remark , '')  
						    
						set @MedicalT = @MedicalT + @Medical	   
						FETCH NEXT FROM Student_Medical  INTO  @Medical,@Remark    
					  end
		 CLOSE Student_Medical
		 DEALLOCATE Student_Medical

		set @MedicalT = isnull(@MedicalT, '')
		 
		return @MedicalT

 end

-- select top 100 * from person_medical_details where person_id ='00011408130'
-- select top 100 * from medical_details where medical_detail_id in ('0001100025','0001100162')

--select dbo.studentMedical('00011408130')
