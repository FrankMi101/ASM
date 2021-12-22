


CREATE FUNCTION  [dbo].[Teacher.Current.WorkingSchools]  
(  @UserID  varchar(30),
  @Schoolyear varchar(8)	
)  
RETURNS @Schools table (Schoolcode varchar(8))
 
AS  
BEGIN 
  
	if exists (select * from [dbo].[tcdsb_vSAP_GAL]  where ExchangeAlias = @UserID  and PickedForGAL ='X' )
 			 insert into @Schools
			 select distinct right(OrgUnit_code,4) 
			 from [dbo].[tcdsb_vSAP_GAL] -- dbo.tcdsb_TPA_school_staff
			 where ExchangeAlias =  @UserID  and  left( right(OrgUnit_code,4),2) in ('02','03','04','05','C5') 
 	else if exists (select * from [dbo].[tcdsb_vSAP_GAL]  where ExchangeAlias = @UserID )
 			 insert into @Schools
			 select distinct right(OrgUnit_code,4) 
			 from [dbo].[tcdsb_vSAP_GAL] -- dbo.tcdsb_TPA_school_staff
			 where ExchangeAlias =  @UserID  and  left( right(OrgUnit_code,4),2) in ('02','03','04','05','C5') 
    else  -- if exists (select * from [dbo].[tcdsb_SES_Teachers] where school_year = @Schoolyear and UserID = @UserID)
	 	 insert into @Schools
		 select distinct school_code
		 from [dbo].[tcdsb_SES_Teachers]
		 where  school_year = @SchoolYear and userID =  @UserID  and  left( school_code,2) in ('02','03','04','05','C5') 

    insert into @Schools
	select distinct lu.LocationID 
	from dbo.tcdsb_RSecurity_LocationUsers lu 
		inner join dbo.tcdsb_RSecurity_Locations rl on rl.LocationID=lu.LocationID
	where userid=@UserID and rl.LocationType='School' and disable =0
		and lu.LocationID  not in (select schoolCode from @Schools)
		order by lu.LocationID  
 

  if exists (select * from @Schools where schoolcode = '0532') 
		Insert  @Schools
		values ('C532')
  if exists (select * from @Schools where schoolcode = '0533') 
		Insert  @Schools
		values ('C533')

   RETURN 

END
