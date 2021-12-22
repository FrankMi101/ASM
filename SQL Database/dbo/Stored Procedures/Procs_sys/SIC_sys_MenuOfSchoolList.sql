





-- =====================================================================================
-- Author:		Frank Mi
-- Create date: June 25, 2020  
-- Description:	 get student list
-- =====================================================================================

 
CREATE  proc [dbo].[SIC_sys_MenuOfSchoolList]  
	@Operate		varchar(30),
	@UserID			varchar(30),
	@UserRole		varchar(30) = null,
	@SchoolYear		varchar(8) = null,
	@SchoolCode		varchar(8) = null 
 

as 

set nocount on

 select 5 as Ptop,10 as Pleft,800 as Pheight, 1000 as Pwidth, 'IEPForm' as MenuID, 'IEP Form' as [Name], '' as Image
 union 
 select 5 as Ptop,10 as Pleft,800 as Pheight, 1000 as Pwidth, 'IEPReport' as MenuID, 'IEP PDF Report' as [Name], '' as Image
 union 
 select 5 as Ptop,10 as Pleft,800 as Pheight, 1000 as Pwidth, 'GiftRCForm' as MenuID, 'Gift Report Card' as [Name], '' as Image
 union 
 select 5 as Ptop,10 as Pleft,800 as Pheight, 1000 as Pwidth, 'GiftRCReport' as MenuID, 'Gift PDF Report' as [Name], '' as Image


