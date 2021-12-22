CREATE TABLE [dbo].[SIC_sys_SchoolAreas] (
    [RegionID]    INT           NULL,
    [School_Area] VARCHAR (20)  NULL,
    [Area_Name]   VARCHAR (100) NULL,
    [District]    VARCHAR (10)  NULL,
    [UserID]      VARCHAR (30)  NULL,
    [fName]       VARCHAR (50)  NULL,
    [FirstName]   VARCHAR (30)  NULL,
    [LastName]    VARCHAR (30)  NULL,
    [Officer]     VARCHAR (30)  NULL
);


GO
CREATE UNIQUE CLUSTERED INDEX [SIC_sys_SchoolAreas_index]
    ON [dbo].[SIC_sys_SchoolAreas]([School_Area] ASC);

