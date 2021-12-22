
 CREATE proc [dbo].[SIC_EXEC_SP_Result]
	@Schoolyear varchar(8)
 as 
 set nocount on
 if @Schoolyear = '20202021'
	select 'My SP EXEC successfully Result ' + @Schoolyear
 else
 	select 'My SP EXEC Failed Result ' + @Schoolyear
