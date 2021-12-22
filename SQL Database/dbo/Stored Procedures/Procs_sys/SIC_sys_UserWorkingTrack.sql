



 
 


-- ==================================================================================
-- Author:		Frank Mi
-- Create date: June 24, 2020 
-- Description:	tracking Login User activities and get user last action information
-- ==================================================================================
  
CREATE proc [dbo].[SIC_sys_UserWorkingTrack] -- 'GetAll','CEC\mif'
	@Operate		varchar(30),
	@UserID			varchar(30),
	@Value 			varchar(50) = null, -- could be user role
	@MachinName		varchar(30) = null,
	@ScreenSize		varchar(30) = null,
	@BrowerType		varchar(30) = null,
	@BrowerVersion	varchar(30) = null 
as

set nocount on
  declare @CurrentApprYear varchar(8), @CurrentSchoolYear varchar(8)

  set @UserID = replace(@UserID,'CEC\','')

if @Value is null
   begin
        if not exists(select * from [dbo].[SIC_sys_UsersActionTrack]  where UserID = @UserID)
		   insert into [dbo].[SIC_sys_UsersActionTrack]
		  (UserID, UserRole, Working_EmployeeID, Working_Year, Working_Unit, Working_SessionID,   Working_Date, Content_Page, Server_Name,ScreenSize,Browser_Type,Browser_Version,Login_Time,LogOn,lu_date,lu_user,lu_function )
	       select top 1 @UserID,[dbo].[User.Role](@UserID,'SES'), CPnum,[dbo].[Current.SchoolYear]('SIC') ,UnitCode,'',getdate(), 'StudentList', '', '','','',getdate(),'Online',getdate(),@userID,app_name()
		   from dbo.tcdsb_TPA_TCDSBStaff where UserID = @UserID

		if @Operate = 'LastValue'
		   	select   Working_EmployeeID, Working_Year, Working_Unit, Working_SessionID,Working_Date,  Content_Page, UserRole, UserID
			from [dbo].[SIC_sys_UsersActionTrack]
			where UserID = @UserID
		else if @Operate = 'GetAll'
		   	select  Working_Year as SchoolYear, Working_Unit as SchoolCode,Working_Date as WorkingDate,  Content_Page as ContentPage, UserRole,
					dbo.[Staff.Name](userID,'Name') as UserName,
					dbo.[School.Name](Working_Unit) as SchoolName,
					dbo.[School.Area](Working_Unit,'Area') as SchoolArea
			from [dbo].[SIC_sys_UsersActionTrack]
			where UserID = @UserID

		else if @Operate ='WorkYear'
		   	select   top 1  Working_Year 
			from [dbo].[SIC_sys_UsersActionTrack]
			where UserID = @UserID	   
		else if @Operate ='OpenSchoolYear'
		   begin
		        select top 1 @CurrentApprYear =  [dbo].[Current.SchoolYear]('SIC') , @CurrentSchoolYear = [dbo].[Current.SchoolYear]('SIC')
				  from   [dbo].[SIC_sys_UsersActionTrack]  where UserID = @UserID 
				if @CurrentApprYear < @CurrentSchoolYear
				    select [dbo].[Current.SchoolYear.PreNext]('Previous', @CurrentApprYear)
                else 
				    select [dbo].[Current.SchoolYear.PreNext]('Previous', @CurrentSchoolYear )
            end
		else if @Operate ='WorkUnit'
		   	select top 1  Working_Unit 
			from [dbo].[SIC_sys_UsersActionTrack]
			where UserID = @UserID	   
		else if @Operate ='WorkingUser'
		   	select top 1 Working_EmployeeID 
			from [dbo].[SIC_sys_UsersActionTrack]
			where UserID = @UserID
		else if @Operate ='WorkSession'
		   	select top 1  Working_SessionID 
			from [dbo].[SIC_sys_UsersActionTrack]
			where UserID = @UserID			   
 		else if @Operate ='ContentPage'
		   	select top 1  Content_Page 
			from [dbo].[SIC_sys_UsersActionTrack]
			where UserID = @UserID			   
 		 	
		else if @Operate ='SchoolName'
		   	select top 1   [dbo].[School.Name]( Working_Unit)
			from [dbo].[SIC_sys_UsersActionTrack]
			where UserID = @UserID														
		else if @Operate ='SchoolArea'
		    select [dbo].[School.Area]( Working_Unit,'Name')
 			from [dbo].[SIC_sys_UsersActionTrack]
			where UserID = @UserID
		else if @Operate ='ClientScreen'
		   	select top 1 ScreenSize
			from [dbo].[SIC_sys_UsersActionTrack]
			where UserID = @UserID		
 						   
   end
else
   begin
	    begin try
			if @Operate ='LastValue'
			   begin
					if exists (select 1 from [dbo].[SIC_sys_UsersActionTrack] where UserID = @UserID)
							update [dbo].[SIC_sys_UsersActionTrack]
							set  UserRole = @Value, Server_Name = @MachinName, ScreenSize = @ScreenSize, Browser_Type = @BrowerType, Browser_Version = @BrowerVersion,Login_Time = getdate(), lu_date =getdate()
							where UserID = @UserID
					else
					   begin
						   declare @schoolYear varchar(8), @schoolCode varchar(8), @session varchar(20), @userRole varchar(20), @employeeID varchar(10)
						   select top 1     @schoolYear = [dbo].[Current.SchoolYear]('SIC'), @schoolCode = UnitCode, @session ='Appraisal 0', @userRole = 'Teacher',  @employeeID = cpnum
						   from dbo.tcdsb_TPA_TCDSBStaff   
						   where UserID = @UserID  

						   insert into [dbo].[SIC_sys_UsersActionTrack]
								(UserID, UserRole, Working_EmployeeID, Working_Year, Working_Unit, Working_SessionID,   Working_Date, Content_Page, Server_Name,ScreenSize,Browser_Type,Browser_Version,Login_Time,LogOn,lu_date,lu_user,lu_function )
						   values(@UserID,@Value, @employeeID,@schoolYear,@schoolCode,@session,getdate(), 'StudentList', @MachinName, @ScreenSize,@BrowerType,@BrowerVersion,getdate(),'Online',getdate(),@userID,app_name())	
					   end

					--select Working_UserID, Working_Year, Working_Unit, SessionID, Working_PageID, Working_ItemsID, Working_Date, UserRole
					--from [dbo].[SIC_sys_UsersActionTrack]
					--where UserID = @UserID
			   end
			else if @Operate ='WorkYear'
		   		update [dbo].[SIC_sys_UsersActionTrack] set Working_Year = @Value, lu_date =getdate(), lu_function =app_name(), lu_user = @UserID
				where UserID = @UserID	   
			else if @Operate ='WorkUnit'
				update [dbo].[SIC_sys_UsersActionTrack] set Working_Unit = @Value, lu_date =getdate(), lu_function =app_name(), lu_user = @UserID
				where UserID = @UserID	   
			else if @Operate ='WorkingUser'
				update [dbo].[SIC_sys_UsersActionTrack] set Working_EmployeeID = @Value, lu_date =getdate(), lu_function =app_name(), lu_user = @UserID
				where UserID = @UserID
			else if @Operate ='WorkSession'
		   		update [dbo].[SIC_sys_UsersActionTrack] set Working_SessionID = @Value, lu_date =getdate(), lu_function =app_name(), lu_user = @UserID
				where UserID = @UserID			   
 			else if @Operate ='ContentPage'
		   		update [dbo].[SIC_sys_UsersActionTrack] set Content_Page = @Value, lu_date =getdate(), lu_function =app_name(), lu_user = @UserID
				where UserID = @UserID			   
 			 
			else if @Operate ='ClientScreen'
		   		update [dbo].[SIC_sys_UsersActionTrack] set ScreenSize = @Value, lu_date =getdate(), lu_function =app_name(), lu_user = @UserID
				where UserID = @UserID		

			Select 'Successfully' as rValue
	   end try
       
	   begin catch
			   Select 'Failed' as rValue		
	   end catch
	end	    
	 




