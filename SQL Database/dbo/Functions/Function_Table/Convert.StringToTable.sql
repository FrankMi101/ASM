



-- ==================================================================================================
-- Author		: Frank Mi
-- Create date	: August 18, 2021  Come from [dbo].[ConvertStringToTable] Initial Auther Rob Templer
-- Description	: Convert multiple records valur to one string 
-- ===================================================================================================

CREATE FUNCTION [dbo].[Convert.StringToTable]
(
    @strValue	nvarchar(2048),
    @chrDelimiter	nchar(1)
)
RETURNS @TableValue TABLE ( N1Field nvarchar(2048) )
AS
BEGIN

    if @strValue is null and @chrDelimiter is null return

    declare @iStart int,   @iPosition int

    if substring( @strValue, 1, 1 ) = @chrDelimiter 
        set @iStart = 2
    else 
        set @iStart = 1

    while 1=1
		begin
			set @iPosition = charindex( @chrDelimiter, @strValue, @iStart )

			if @iPosition = 0 	set @iPosition = len( @strValue ) + 1

			if @iPosition - @iStart > 0  
 				insert into @TableValue values  ( rtrim(ltrim(substring( @strValue, @iStart, @iPosition - @iStart ))))
 		
		set @iStart = @iPosition + 1

			if @iStart > len( @strValue ) break
		end
    RETURN

END
