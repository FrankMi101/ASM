





-- drop function School

CREATE Function [dbo].[School.Phone](@school_code char(4),@NameType varchar(20))
RETURNS varchar(20)
as
begin 
     declare @rValue varchar(20)
    if @Nametype ='Phone'
    	    set @rValue = (  select top 1 '('+ isnull(area_code,'416') +')' + isnull((left(phone_no,3)+'-'+ right(phone_no,4)),'999-9999') + isnull('Ext.'+ extension,' ')
							from school_telecom
							 where school_code = @school_code  and telecom_type_name ='Business'
								order by start_date DESC
                                         )
	else if @Nametype ='Fax'
	        set @rValue = (  select top 1 '('+ isnull(area_code,'416') +')' + isnull((left(phone_no,3)+'-'+ right(phone_no,4)),'999-9999') + isnull('Ext.'+ extension,' ')
							from school_telecom
							where school_code = @school_code  and telecom_type_name ='Fax'
							order by start_date DESC         )


    set @rValue = isnull(@rValue,  ' ')

     Return(@rValue)
 

end 





































