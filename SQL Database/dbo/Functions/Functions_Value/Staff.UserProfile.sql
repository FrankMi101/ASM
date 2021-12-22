



-- drop function  dbo.tcdsb_TPA_UserNamebyCPNum  

CREATE   FUNCTION [dbo].[Staff.UserProfile]
(@CPNum varchar(10), 
 @Type varchar(30) 
 )
RETURNS varchar(50)
AS
BEGIN

  declare @rValue varchar(30)

  if (@Type ='UserID') 
    set @rValue =  ( 	select   top 1  Exchange_NTUserID 
                      	from  [dbo].[tcdsb_vSAP_GAL] 
		      			where CPNum = @CPNum 	and PickedForGAL ='X'
						 
				)	
  else if (@Type ='Name') 
    set @rValue =  ( 	select   top 1   isnull(FirstName,'') + ' ' + isnull(LastName,'') 
                      	from  [dbo].[tcdsb_vSAP_GAL]  
		      			where CPNum = @CPNum 	and PickedForGAL ='X'		 
				)	
  else if (@Type ='sNameFirst') 
    set @rValue =  ( 	select   top 1    isnull(LastName,'') + ', ' + isnull(FirstName,'') 
                      	from  [dbo].[tcdsb_vSAP_GAL]  
		      			where CPNum = @CPNum 	and PickedForGAL ='X'		 
				)	
  else if (@Type ='fNameFirst') 
    set @rValue =  ( 	select   top 1   isnull(FirstName,'') + ' ' + isnull(LastName,'') 
                      	from  [dbo].[tcdsb_vSAP_GAL] 
		      			where CPNum = @CPNum 		and PickedForGAL ='X'	 
				)	
  
  else if (@Type ='shortName') 
    set @rValue =  ( 	select   top 1   isnull(FirstName,'') + ' ' + left(isnull(LastName,''),1)
                      	from  [dbo].[tcdsb_vSAP_GAL]   
		      			where CPNum = @CPNum 		and PickedForGAL ='X'	 
				)	

  else if (@Type ='firstName') or ( @Type ='fName')
    set @rValue =  ( 	select top 1   isnull(FirstName,'')
                      	from [dbo].[tcdsb_vSAP_GAL]   
		      			where CPNum = @CPNum 	and PickedForGAL ='X'
		    
		     )	
  else if (@Type = 'lastName') or (@Type ='sName')
      set @rValue =  ( 	select top 1  isnull(LastName,'')
                      from [dbo].[tcdsb_vSAP_GAL]    
		      			where CPNum = @CPNum 	and PickedForGAL ='X'
		     )	
 
 else if @Type ='Position'
          set @rValue = (select  top 1 isnull(PositionDesc,'Other')
                       from  [dbo].[tcdsb_vSAP_GAL]  
		      			where CPNum = @CPNum 	and PickedForGAL ='X'
		     )	
 else if @Type ='Gender'
          set @rValue = (select  top 1 isnull(GenderCodeDesc,'F')
                       from  [dbo].[tcdsb_vSAP_GAL]   
		      			where CPNum = @CPNum 	and PickedForGAL ='X'
		     )	
		     
  else if @Type ='FTE'
           set @rValue = (select  top 1 isnull(FTE,'')
                      		 from  [dbo].[tcdsb_vSAP_GAL] 
		      			where CPNum = @CPNum 	and PickedForGAL ='X'
		     )	
 else if @Type ='UnitCode'
           set @rValue = (select  top 1 right(isnull(OrgUnit_Code,''),4)
                      		 from [dbo].[tcdsb_vSAP_GAL] 
		      			where CPNum = @CPNum 	and PickedForGAL ='X'
		     )	
 
    set @rValue = isnull(@rValue,' ') 
 RETURN(@rValue)
 END
  





