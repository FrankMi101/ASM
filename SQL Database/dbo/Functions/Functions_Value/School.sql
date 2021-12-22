




-- drop function School

CREATE Function [dbo].[School](@school_code char(4),@NameType char(20))
RETURNS varchar(100)
as
begin 
	declare @rValue varchar(100)
              declare @schoolyear  char(8)
              declare @EffectDate  varchar(10)
              declare @schoolcode1 varchar(8)
               select   @schoolyear  =  school_year ,
                        @EffectDate =  school_date,
						@schoolcode1 = school_code
               from tcdsb_trillium_companion where user_id = dbo.userID() 
if @school_code ='ADM1' set @school_code = @schoolcode1
	declare @max_end_date datetime
    set @max_end_date=(select max(end_date) from school_years 
	where  school_year = @schoolyear and school_code =@school_code)

    if @Nametype ='Name'
       begin
           set @rValue = (select top 1  isnull(school_name, ' ') 
			From schools
			WHERE school_code =@school_code)
       end  
    else if @Nametype ='Brief'
        begin
           set @rValue = (select top 1  isnull(school_brief_name, ' ') 
			From schools
			WHERE school_code =@school_code)
        end   
    else if @Nametype ='SuperArea'
        begin
            set @rValue = (select top 1  isnull(school_family_code, '  ') 
			From school_family_schools
			WHERE  left(school_family_code,4) ='Area'  and school_code = @school_code)

        end  
   else if @Nametype ='SuperArea1'
        begin
            set @rValue = (select top 1  left(isnull(full_name, ' '),7) 
			From school_families 
			where school_family_type_code ='Supt' 
                             and  school_family_code = (select top 1 school_family_code  from school_family_schools
						        WHERE  left(school_family_code,4)  ='Area'  and school_code = @school_code)
                           )
        end     
   else if @Nametype ='SuperFull'
        begin
            set @rValue = (select top 1  isnull(full_name, ' ') 
			From school_families 
			where school_family_type_code ='Supt' 
                             and  school_family_code = (select top 1 school_family_code  from school_family_schools
						        WHERE  left(school_family_code,4)  ='Area'  and school_code = @school_code)
                           )
        end    

  else if @Nametype ='SuperName'
        begin
             set @rValue  = 	dbo.tcdsb_TPA_School(@school_code,'SuperName')

--           set @rValue = (select top 1  isnull(S.Last_name, '  ') +' ' +  isnull(S.First_name, ' ') 
--			From Superintendent  as S
--			inner join  school_superintendent  as SS  on S.Superintendent_ID = SS.Superintendent_ID
--			WHERE SS.school_code  = @school_code )
        end   
 

     else if @Nametype ='BSID'
           begin
                  set @rValue = (select top 1  isnull(default_school_bsid, ' ') 
			From schools
			WHERE school_code =@school_code)
           end 
     else if @Nametype ='Address'
           begin
                  set @rValue = (select top 1 isnull(street_no + ' ','') + isnull(street + ' ','')  + isnull(Jurisdiction_name,'Toronto') + ' ' + isnull(Province_state_code,'ON') 
                                           from addresses   where address_id =  (select top 1 address_id from school_addresses where school_code =@school_code)
                                         )
           end 
     else if @Nametype ='AddressFull'
           begin
                  set @rValue = (select top 1 isnull(street_no + ' ','') + isnull(street + ' ','')  + char(13) + isnull(Jurisdiction_name,'Toronto') + ' ' + isnull(Province_state_code,'ON') + ' ' + isnull(dbo.Fpostcode(Postal_code),'X0X 0X0') 
                                           from addresses   where address_id =  (select top 1 address_id from school_addresses where school_code =@school_code) 
 				)
                                        
           end 
     else if @Nametype ='Street'
           begin
                  set @rValue = (select top 1 isnull(street_no + ' ','') + isnull(street + ' ','')  
                                           from addresses   where address_id =  (select top 1 address_id from school_addresses where school_code =@school_code) 
 				)
                                        
           end 

    else if @Nametype ='StreetCity'
           begin
		 set @rValue = (select top 1 isnull(Jurisdiction_name,'Toronto') + ' ' + isnull(Province_state_code,'ON') + ' ' + isnull(dbo.Fpostcode(Postal_code),'X0X 0X0') 
                                           from addresses   where address_id =  (select top 1 address_id from school_addresses where school_code =@school_code) 
 				)                                        
           end 

     else if @Nametype ='City'
           begin
                  set @rValue = (select top 1  isnull(Jurisdiction_name,'Toronto') + ' ' + isnull(Province_state_code,'ON')  
                                           from addresses   where address_id =  (select top 1 address_id from school_addresses where school_code =@school_code) 
 				)
                                        
           end 

    else if @Nametype ='PostCode'
           begin
                  set @rValue = (select top 1 isnull(dbo.Fpostcode(Postal_code),'X0X 0X0')  
                                            from addresses    where address_id = (select top 1 address_id from school_addresses where school_code = @school_code)
                                          )
           end 
  else if @Nametype ='Principal' 
           begin                       
	set @rValue = ( 
			SELECT  top 1  rtrim(ISNULL(preferred_surname, ' ' ))  + ', '+  ISNULL(preferred_first_name, ' ')
			FROM  	    persons 	
        		              WHERE person_id =  ( select top 1 person_id      From school_staff
 	  		                                       WHERE school_code = @school_code 	and    (end_date=@max_end_date or end_date>=getdate() )  and -----status_indicator_code = 'Active' and 
    				                                          principal_flag = 'x' 		and      staff_type_name LIKE 'prin%'  and school_year =@schoolyear
                                                                             ) 
                                      )
           end 

 else if @Nametype ='PrincipalIEP' 
           begin                       
	set @rValue = ( 
			SELECT  top 1  rtrim(isnull(salutation_code,' ')) + ' ' + left( ltrim(ISNULL(preferred_first_name, '')),1) +   '. ' +   ISNULL(preferred_surname, '  ') 
			FROM  	    persons 	
        		              WHERE person_id =  ( select top 1 person_id      From school_staff
 	  		                                       WHERE school_code = @school_code 	and    (end_date=@max_end_date or end_date>=getdate() )  and ----status_indicator_code = 'Active' and 
    				                                          principal_flag = 'x' 		and      staff_type_name LIKE 'prin%'  and school_year = @schoolyear
                                                                             ) 
                                      )
           end 
 

  else if @Nametype ='Principal1' 
           begin                       
	set @rValue = ( 
			SELECT  top 1  rtrim(ISNULL(preferred_surname, ' ' ))  + ', '+  ISNULL(preferred_first_name, ' ')
			FROM  	    persons 	
        		              WHERE person_id =  ( select top 1 person_id      From school_staff
 	  		                                       WHERE school_code = @school_code 	and    (end_date=@max_end_date or end_date>=getdate() )  and ---- status_indicator_code = 'Active' and 
    				                                          principal_flag = 'x' 		and      staff_type_name LIKE 'prin%'  and school_year = @schoolyear
                                                                             ) 
                                      )
           end 
  else if @Nametype ='PrincipalS' 
           begin                       

	set @rValue = ( 
			SELECT  top 1  rtrim(ISNULL(preferred_surname, ' ' ))   
			FROM  	    persons 	
        		              WHERE person_id =  ( select top 1 person_id      From school_staff
 	  		                                       WHERE school_code = @school_code 	and   (end_date=@max_end_date or end_date>=getdate() )  and ----  status_indicator_code = 'Active' and 
    				                                          principal_flag = 'x' 		and      staff_type_name LIKE 'prin%'   and school_year = @schoolyear
                                                                             ) 
                                      )
           end 
  else if @Nametype ='PrincipalF' 
           begin                       
	set @rValue = ( 
			SELECT  top 1   ISNULL(preferred_first_name, ' ')
			FROM  	    persons 	
        		              WHERE person_id =  ( select top 1 person_id      From school_staff
 	  		                                       WHERE school_code = @school_code 	and     (end_date=@max_end_date or end_date>=getdate() )  and ----status_indicator_code = 'Active' and 
    				                                          principal_flag = 'x' 		and      staff_type_name LIKE 'prin%'   and school_year = @schoolyear
                                                                             ) 
                                      )
           end 
 else if @Nametype ='Phone'
           begin                       
    	    set @rValue = (  select top 1 '('+ isnull(area_code,'416') +')' + isnull((left(phone_no,3)+'-'+ right(phone_no,4)),'999-9999') + isnull('Ext.'+ extension,' ')
			    from school_telecom
			     where school_code = @school_code  and telecom_type_name ='Business'
			    order by start_date DESC
                                         )
           end 
 else if @Nametype ='Fax'
           begin                       
	        set @rValue = (  select top 1 '('+ isnull(area_code,'416') +')' + isnull((left(phone_no,3)+'-'+ right(phone_no,4)),'999-9999') + isnull('Ext.'+ extension,' ')
			from school_telecom
			where school_code = @school_code  and telecom_type_name ='Fax'
			order by start_date DESC

                                      )
           end 
else if @Nametype ='Phone1'
           begin                       
    	    set @rValue = (  select top 1  isnull(area_code, '416')  + isnull(phone_no, '9999999') 
			    from school_telecom
			     where school_code = @school_code  and telecom_type_name ='Business'
			    order by start_date DESC
                                         )
           end 
 else if @Nametype ='Fax1'
           begin                       
	        set @rValue = (  select top 1  isnull(area_code, '416' )  + isnull(phone_no, '9999999')
				from school_telecom
				where school_code = @school_code  and telecom_type_name ='Fax'
				order by start_date DESC
                                             )
           end 
 else if @Nametype ='semester'
           begin                       
	        set @rValue = (  select top 1  isnull(semester, '1' )
				from school_terms
				where   school_code = @school_code  and  school_year =@schoolyear and @EffectDate  between  term_start and term_end 
                                             )
                     set @rValue = isnull(@rValue,'1')
           end 
 else if @Nametype ='Term'
           begin                       
	 set @rValue = (  select top 1  isnull(term, '1' )
				from school_terms
				where   school_code = @school_code  and  school_year =@schoolyear and @EffectDate  between  term_start and term_end  )
                      set @rValue = isnull(@rValue,'1')
           end 
else if @NameType ='PrincipaluserID'
		
		 set @rValue = (select top 1 default_AdminID from tcdsb_tpa_schools where school_code = @school_code)
else if @NameType ='SuperintendetID'
		
		 set @rValue = dbo.tcdsb_TPA_School(@school_code,'SuperID')

     set @rValue = isnull(@rValue,  ' ')
     Return(@rValue)
 

end 




































