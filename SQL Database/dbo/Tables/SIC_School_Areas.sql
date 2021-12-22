CREATE TABLE [dbo].[SIC_School_Areas] (
    [RegionID]    INT           NULL,
    [School_Area] VARCHAR (20)  NULL,
    [Area_Name]   VARCHAR (100) NULL,
    [UserID]      VARCHAR (30)  NULL,
    [fName]       VARCHAR (50)  NULL,
    [FirstName]   VARCHAR (30)  NULL,
    [LastName]    VARCHAR (30)  NULL,
    [Officer]     VARCHAR (30)  NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [SIC_sys_Schools_Areas_index]
    ON [dbo].[SIC_School_Areas]([School_Area] ASC);

