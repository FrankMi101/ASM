

CREATE proc [dbo].[SIC_EXEC_SP]
as

set nocount on

declare @Result varchar(100)
 EXEC  @Result = [dbo].[SIC_EXEC_SP_Result] '20202020'
 print @Result
											
