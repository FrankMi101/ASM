
 

-- ==================================================================================
-- Author:		Frank Mi
-- Create date: April 22, 2022 
-- Description:	get and update SIC title and help content
-- ==================================================================================
--			drop proc	[dbo].[SIC_sys_HelpTitleContentSP] 'Read','mif','LTO','All','Summary1','Title'  
CREATE proc [dbo].[SIC_sys_HelpTitleContentSP]  
 	(	@Operate		varchar(30)= null,	
		@UserID			varchar(50) ='upaUser',
		@Category		varchar(50) ='UPA',
		@Area			varchar(50) = 'Sys-Profile', 
		@ItemCode		varchar(20) = null, 
		@ContentType	varchar(20) = null, 
		@Value			varchar(2000) = null 
 	)

 
AS
 
-- select * from      SIC_sys_HelpTitleContent    order by ids  where  contentType ='Help' and  category ='TPA' and area ='ManageList'
  


BEGIN 
	if @Operate ='Get' -- is null
		begin
			if exists (select 1 from dbo.SIC_sys_HelpTitleContent  where  Category = @Category and Area = @Area and ItemCode = @ItemCode and ContentType = @ContentType)
				 select top 1 isnull(ContentText, '')  
				 from  dbo.SIC_sys_HelpTitleContent 
				 where  Category = @Category and Area = @Area and ItemCode = @ItemCode and ContentType = @ContentType 		
			else
 				select    case   @ContentType  when 'SubTitle' then  ''
											   when 'Message' then ''
											   else  @ContentType + ' content text of '   +  @Category + ' ' +  @Area + ' ' + @ItemCode  end as rValue
 
		end
	else
		begin
			begin try
			   begin tran
					if exists (select 1 from dbo.SIC_sys_HelpTitleContent  where   Category = @Category and Area = @Area and ItemCode = @ItemCode and ContentType = @ContentType )
						update dbo.SIC_sys_HelpTitleContent set ContentText = @Value
						where  Category = @Category and Area = @Area and ItemCode = @ItemCode and ContentType = @ContentType 	 	
					else
						insert into dbo.SIC_sys_HelpTitleContent
								(Category,Area, ItemCode, ContentType,ContentText,lu_user,lu_function,lu_date)
						values (@Category,@Area,@ItemCode,	@ContentType, @Value   ,@UserID, app_name(),getdate())

			   commit tran	
					Select 'Successfully' as rValue
		   end try
		   begin catch
			   Rollback tran
			   Select 'Failed' as rValue		
		   end catch
	 end
END

