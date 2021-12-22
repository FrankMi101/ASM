CREATE TABLE [dbo].[SIC_sys_SchoolGrade] (
    [SchoolYear] VARCHAR (8) NOT NULL,
    [SchoolCode] VARCHAR (8) NOT NULL,
    [Grade]      VARCHAR (2) NOT NULL
);


GO
CREATE UNIQUE CLUSTERED INDEX [SIC_sys_SchoolGrade_index]
    ON [dbo].[SIC_sys_SchoolGrade]([SchoolYear] ASC, [SchoolCode] ASC, [Grade] ASC);

