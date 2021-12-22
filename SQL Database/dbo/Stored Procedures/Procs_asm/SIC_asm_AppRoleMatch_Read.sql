





 

-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: April 06, 2021  
-- Description	: get Role list
-- =====================================================================================

-- drop  proc dbo.SIC_sys_UserRoleMatchManagement 'GetList' ,'mif','admin','Teacher','ClassDesc'
CREATE  proc [dbo].[SIC_asm_AppRoleMatch_Read]  
	@Operate		varchar(30),
	@UserID			varchar(30),
	@UserRole		varchar(30) = null,
	@RoleID			varchar(20) =null, 
	@RoleType		varchar(50) =null , 
	@MatchDesc		varchar(200) =null
	--@MatchRole		varchar(20) =null,  
	--@MatchScope		varchar(20) = null 
as 

set nocount on
 
if @Operate ='GetList' 
 	begin		
		declare @GoPage varchar(100), @Type varchar(10),@AppID varchar(20),  @ModelID varchar(50),@SchoolYear varchar(8),@SchoolCode varchar(8)
		select @AppID ='SIC',@ModelID ='Pages', @Type ='Role', @SchoolYear ='', @SchoolCode=''
	 

		--select @GoPage ='../PagesForms/Security_RoleMatch.aspx'  , @Target ='EditDIV',@Height='250',@Width ='450'
		--select @iPage ='SecurityRoleManageSub.aspx', @iTarget='IframeSubArea'
		if @RoleType ='PositionDesc' 
			begin
				if @RoleID ='All'
					select distinct
						 UserRole as MatchRole  
						,UserScope as MatchScope
						,PositionDesc as MatchDesc 
 						,dbo.[ActionTask.ASM]('Edit','PositionDesc',0,@SchoolYear,@SchoolCode,@AppID,UserScope,UserRole,PositionDesc,@RoleType)	as EditAction
 						,ROW_NUMBER() OVER(ORDER BY PositionDesc ) AS RowNo 
 	 	  	 		from  [dbo].[SIC_sys_UserProfileMatch_PositionDesc]
					where UserRole in (select RoleID from  [dbo].[SIC_sys_UserRole])   
					order by RowNo
				else if @RoleID ='Other'
					select distinct
						 UserRole as MatchRole  
						,UserScope as MatchScope
						,PositionDesc as MatchDesc 
 						,dbo.[ActionTask.ASM]('Edit','PositionDesc',0,@SchoolYear,@SchoolCode,@AppID,UserScope,UserRole,PositionDesc,@RoleType)	as EditAction
						--,dbo.[ActionTask.Role]('Edit',@GoPage,@Target,@Height,@Width,@SchoolYear,@SchoolCode, UserRole, UserScope,PositionDesc,PositionDesc,@RoleType)	as EditAction
 						,ROW_NUMBER() OVER(ORDER BY PositionDesc ) AS RowNo 
 	 	 			from  [dbo].[SIC_sys_UserProfileMatch_PositionDesc]
					where UserRole not in (select RoleID from  [dbo].[SIC_sys_UserRole])   
					order by RowNo
				else
					select distinct
						 UserRole as MatchRole  
						,UserScope as MatchScope
						,PositionDesc as MatchDesc 
 						,dbo.[ActionTask.ASM]('Edit','PositionDesc',0,@SchoolYear,@SchoolCode,@AppID,UserScope,UserRole,PositionDesc,@RoleType)	as EditAction
						,ROW_NUMBER() OVER(ORDER BY PositionDesc ) AS RowNo 
 	 	 			from  [dbo].[SIC_sys_UserProfileMatch_PositionDesc]
					where UserRole =   @RoleID  
					order by RowNo
			end
		else if @RoleType ='ClassDesc'
			select distinct
				 UserRole as MatchRole  
				,UserScope as MatchScope
				,ClassTypeIDDesc as MatchDesc 
 				,dbo.[ActionTask.ASM]('Edit','ClassDesc',0,@SchoolYear,@SchoolCode,@AppID,UserScope,UserRole,ClassTypeIDDesc,@RoleType)	as EditAction
			--	,dbo.[ActionTask.Role]('Edit',@GoPage,@Target,@Height,@Width,@SchoolYear,@SchoolCode, UserRole, UserScope,ClassTypeIDDesc,ClassTypeIDDesc,@RoleType)	as EditAction
 				,ROW_NUMBER() OVER(ORDER BY ClassTypeIDDesc ) AS RowNo 
 			from  [dbo].[SIC_sys_UserProfileMatch_ClassTypeDesc]
			where UserRole = @RoleID  
			order by RowNo
	end
else if @Operate ='Get'  
	begin
		if @RoleType ='PositionDesc' 
			select distinct
				 UserRole as MatchRole  
				,UserScope as MatchScope
				,PositionDesc as MatchDesc
				 
 			from  [dbo].[SIC_sys_UserProfileMatch_PositionDesc]
			where  PositionDesc like ( @MatchDesc + '%')
			 
		else if @RoleType ='ClassDesc'
			select distinct
				 UserRole as MatchRole  
				,UserScope as MatchScope
				,ClassTypeIDDesc as MatchDesc 			 
 			from  [dbo].[SIC_sys_UserProfileMatch_ClassTypeDesc]
			where  ClassTypeIDDesc like ( @MatchDesc + '%')
	 
	end
 
