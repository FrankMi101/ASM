



-- =====================================================================================
-- Author:		Frank Mi
-- Create date: June 23, 2020  
-- Description:	 get Grade List by School
-- =====================================================================================
 
 
CREATE proc [dbo].[SIC_sys_ConvertFunctionCheck]   
        @Operate 		varchar(50),
		@StringValue 	varchar(2400)=null,
		@Delimiter 		varchar(1) = null,
		@TableName 		varchar(100) = null,
		@CheckType		varchar(50) =  null  -- CPNum 
as
set nocount on 
begin
     if @Operate = 'StringToTable'
		begin
			select N1Field from  [dbo].[Convert.StringToTable](@StringValue,@Delimiter)
		end
	else if @Operate = 'TableToString'
		begin
			declare @ObjTable as SingleFieldTable
			if @TableName = 'StaffQualification'
				insert into @ObjTable
				select QualDesc from [dbo].[tcdsb_LTO_Qualifications_Long]  where CPNum = '00000023' --@CheckType 'Mathematics'
			else if @TableName ='TestTable'
				insert into @ObjTable
				select [Name] from [dbo].[SIC_sys_ConvertFun_TestTable]  where ValueType = @CheckType
			else
				insert into @ObjTable
				Values('Goood value 1'),('Good Value 2'),('Bad Value 1'),('Bad Value 2')

			select [dbo].[Convert.TableToString](@OBjTable , @Delimiter )
		end
 end  

	 




	  

