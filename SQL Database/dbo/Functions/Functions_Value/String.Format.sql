



 
  
-- Frank Mi modify by Frank @2020/11/25 add "2:2"
CREATE Function [dbo].[String.Format]
(	@Type varchar(30),
	@FormatSTR varchar(250) 
)
RETURNS varchar(60)
as
begin 
	declare @rValue varchar(60)
    set @FormatSTR = ltrim(rtrim(@FormatSTR))
        
    if @Type = '3-3-3'
        set @rValue =left(@FormatSTR,3) +'-'+ substring(@FormatSTR,4,3) +'-'+ 	right(@FormatSTR,3)  
     if @Type = '2:2'
        set @rValue =left(@FormatSTR,2) +':'+  	right(@FormatSTR,2)  

    if @Type ='2-6'
        set @rValue =left(@FormatSTR,2) +'-'+ substring(@FormatSTR,3,6)  
    if @Type ='3-3-4-2'
        set @rValue =left(@FormatSTR,3) +'-'+ substring(@FormatSTR,4,3) +'-' + substring(@FormatSTR,7,4)  +  isnull(  '-' + substring(@FormatSTR,11,2),'')
 
     set @rValue = isnull(@rValue,  ' ')
     Return(@rValue)
 
end 




































