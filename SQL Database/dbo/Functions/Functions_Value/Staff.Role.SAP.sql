









-- =================================================================================
-- Author:		Frank Mi
-- Create date: March 21, 2021
-- Description:	to get Staff SAP nature role by position  
-- ===================================================================================
 
CREATE Function [dbo].[Staff.Role.SAP]
(
 @UserID	varchar(30)
)
RETURNS varchar(50)

as

begin 
	declare @RolebyPosition  varchar(20),  @RolebyClassID  varchar(20),  @rValue varchar(50), @positionDesc varchar(200) , @classTypeDesc varchar(200)
 
		-- Step 1 get user SAP profile
			select top 1  @positionDesc = PositionDesc  , @classTypeDesc = ClassTypeIDDesc
			from [dbo].[SIC_sys_Employee] 
			where UserID = @UserID 
			order by PickedForGAL DESC, FTE DESC
 

		-- Step 2 get user role from standardization position 
		   set @RolebyPosition = (select top 1 UserRole  
								  from [dbo].[SIC_sys_UserProfileMatch_PositionDesc]
								  where PositionDesc = @positionDesc
								  )

		-- Step 3 get user role from standardization classIDdesc
		   set @RolebyClassID =  (select  top 1 UserRole  
								  from  [dbo].[SIC_sys_UserProfileMatch_ClassTypeDesc]
								  where ClassTypeIDDesc = @classTypeDesc
								  )

		-- Step 4 get highly priority Role    
			set @rValue = (	select top 1 RoleID  from [dbo].[SIC_sys_UserRole]
							where RoleID  in (@RolebyPosition,@RolebyClassID)
							order by RolePriority
							)
 

	set @rValue = isnull(@rValue,  'Other')

  Return(@rValue)
 
end 
   

