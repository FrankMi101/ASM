CREATE FUNCTION dbo.ConvertDateToString (@mdate datetime)  
RETURNS varchar(10) AS  
BEGIN 
declare @retvalue varchar(10)
declare @yyyy int
declare @mm int
declare @dd int
declare @syyyy varchar(4)
declare @smm  varchar(2)
declare @sdd varchar(2)

if @mdate is null
begin
	set @retvalue = ' '
end
else
begin
	set @yyyy = year(@mdate)
	set @mm = month(@mdate)
	set @dd = day(@mdate)
	set @syyyy = cast(@yyyy as varchar(4))
	set @smm = cast(@mm as varchar(2))
	set @sdd = cast(@dd as varchar(2))
	set @retvalue = @syyyy + '/' + @smm + '/' + @sdd
end
return (@retvalue)
END