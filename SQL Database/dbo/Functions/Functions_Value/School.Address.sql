

-- =================================================================================
-- Author:		Frank Mi
-- Create date: March 29, 2016
-- Description:	get School Address by School code 
-- ===================================================================================

 
-- drop function SchoolAddress

CREATE Function [dbo].[School.Address]
(@schoolCode varchar(8),
 @NameType varchar(20))
RETURNS varchar(300)
as
begin 
	declare @rValue varchar(200)
  
if @Nametype ='Address'
         set @rValue = (select top 1 isnull(street_no + ' ','') + isnull(street + ' ','')  + isnull(Jurisdiction_name,'Toronto') + ' ' + isnull(Province_state_code,'ON') 
                        from addresses   where address_id =  (select top 1 address_id from school_addresses where school_code =@schoolCode)
                       )
else if @Nametype ='AddressFull'
         set @rValue = (select top 1 isnull(street_no + ' ','') + isnull(street + ' ','')  + char(13) + isnull(Jurisdiction_name,'Toronto') + ' ' + isnull(Province_state_code,'ON') + ' ' + isnull(dbo.Fpostcode(Postal_code),'X0X 0X0') 
                        from addresses   where address_id =  (select top 1 address_id from school_addresses where school_code =@schoolCode) 
 				       )
                                        
else if @Nametype ='Street'
     set @rValue = (select top 1 isnull(street_no + ' ','') + isnull(street + ' ','')  
                    from addresses   where address_id =  (select top 1 address_id from school_addresses where school_code =@schoolCode) 
 				)
else if @Nametype ='StreetCity'
	 set @rValue = (select top 1 isnull(Jurisdiction_name,'Toronto') + ' ' + isnull(Province_state_code,'ON') + ' ' + isnull(dbo.Fpostcode(Postal_code),'X0X 0X0') 
                     from addresses   where address_id =  (select top 1 address_id from school_addresses where school_code =@schoolCode) )
else if @Nametype ='City'
     set @rValue = (select top 1  isnull(Jurisdiction_name,'Toronto') + ' ' + isnull(Province_state_code,'ON')  
                    from addresses   where address_id =  (select top 1 address_id from school_addresses where school_code =@schoolCode) )
else if @Nametype ='PostCode'
     set @rValue = (select top 1 isnull(dbo.Fpostcode(Postal_code),'X0X 0X0')  
                    from addresses    where address_id = (select top 1 address_id from school_addresses where school_code = @schoolCode) )
else if @Nametype ='Phone'
     set @rValue = (  select top 1 '('+ isnull(area_code,'416') +')' + isnull((left(phone_no,3)+'-'+ right(phone_no,4)),'999-9999') + isnull('Ext.'+ extension,' ')
			      from school_telecom
			     where school_code = @schoolCode  and telecom_type_name ='Business'
			      order by start_date DESC  )
else if @Nametype ='Fax'
	        set @rValue = (  select top 1 '('+ isnull(area_code,'416') +')' + isnull((left(phone_no,3)+'-'+ right(phone_no,4)),'999-9999') + isnull('Ext.'+ extension,' ')
			from school_telecom
			where school_code = @schoolCode  and telecom_type_name ='Fax'
			order by start_date DESC)
else if @Nametype ='Phone1'
    	    set @rValue = (  select top 1  isnull(area_code, '416')  + isnull(phone_no, '9999999') 
			    from school_telecom
			     where school_code = @schoolCode  and telecom_type_name ='Business'
			    order by start_date DESC  )
 else if @Nametype ='Fax1'
 	        set @rValue = (  select top 1  isnull(area_code, '416' )  + isnull(phone_no, '9999999')
				from school_telecom
				where school_code = @schoolCode  and telecom_type_name ='Fax'
				order by start_date DESC)
 

     set @rValue = isnull(@rValue,  ' ')
     Return(@rValue)
 

end 



