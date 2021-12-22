
Create view dbo.SIC_sys_SchoolYear
WITH SCHEMABINDING
as 
 select    school_year as SchoolYear,School_code as SchoolCode,  start_date as StartDate, end_date as EndDate
 from dbo.school_years 
 where school_year >'20102010'
GO
CREATE UNIQUE CLUSTERED INDEX [SIC_sys_SchoolYear_index]
    ON [dbo].[SIC_sys_SchoolYear]([SchoolYear] ASC, [SchoolCode] ASC);

