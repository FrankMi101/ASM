









 



-- =====================================================================================
-- Author:		Frank Mi
-- Create date: June 23, 2020  
-- Description:	 get Grade List by School
-- =====================================================================================
 
 
CREATE proc [dbo].[SIC_sys_GradeList]   
        @Operate 	varchar(50),
		@UserID 	varchar(30)=null,
		@UserRole  	varchar(50) = null,
		@SchoolYear 	varchar(8) = null,
		@SchoolCode   	varchar(8) = null
as
set nocount on 
begin
    
select Grade as [Value],  case  Grade when 'JK' then 'JK' when 'SK' then 'SK' else 'Gr. ' + Grade end as [Name] , case Grade when 'JK' then '1' when 'SK' then '2' else '3' end as orderby 
from  [dbo].[tcdsb_SES_School_Grade]
where school_year = @SchoolYear and school_code = @SchoolCode
union 
select '00' as  [Value], 'All Grade' as [Name], '4' as Ordrby 
union 
select '99' as  [Value], 'My Student' as [Name], '5' as Ordrby 

order by orderby, [Value]
 end  

	 




	  

