
-- ============================================================================
-- Author:		Frank Mi
-- Create date: August 25, 2021  
-- Description:	Get Monsignor Fraser School list  
-- =============================================================================  
CREATE FUNCTION [dbo].[School.MsgrFraser]
()
 
RETURNS @MsrgSchool  TABLE 
		(School_Code varchar(8),
		 School_name varchar(250),
		 School_Brief varchar(100),
		 School_BSID	varchar(10)
		)
 
AS 
BEGIN 
	insert into @MsrgSchool
	select school_code, school_name, school_brief_name, default_school_bsid 
	from schools where school_name like ('Monsignor Fraser%')   --and active_flag = 'X'  
	Return 
 End
  