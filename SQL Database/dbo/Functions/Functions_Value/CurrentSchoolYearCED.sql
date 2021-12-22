



-- drop function dbo.CurrentSchoolyearCED
CREATE FUNCTION  [dbo].[CurrentSchoolYearCED] 
( 
  @date datetime 
)  
RETURNS varchar(8) 
AS  
BEGIN 

declare @SchoolYear varchar(8)
declare @school_year varchar (08) 
declare @school_year4 varchar (04)
declare @school_year_fr varchar (04)
declare @school_year_to varchar (04)
declare @school_month varchar (02)
declare @school_year8 varchar (08)
declare @getendyear varchar (04)

set @school_year4 = STR(YEAR(GETDATE()),4,0)
set @school_month = str(month(getdate()),2,5)

set @getendyear = STR(YEAR(GETDATE()),4,0)

if @school_month < 9
     begin
      set @school_year_fr = @school_year4 - 1
      set @school_year_to = @school_year4
     end
else
      begin
        set @school_year_fr = @school_year4
        set @school_year_to = @school_year4 + 1
     end

set @school_year8 = @school_year_fr + @school_year_to

set @school_year = @school_year8
set @SchoolYear =@school_year -- '20042005' 
return @SchoolYear

END






