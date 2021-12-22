CREATE TABLE [dbo].[SIC_sys_ReportsManagement] (
    [IDs]           INT           IDENTITY (1, 1) NOT NULL,
    [Category]      VARCHAR (50)  NULL,
    [ReportID]      VARCHAR (20)  NOT NULL,
    [ReportType]    VARCHAR (20)  NULL,
    [Name]          VARCHAR (250) NOT NULL,
    [ReportService] VARCHAR (250) NULL,
    [FilePath]      VARCHAR (100) NULL,
    [FileName]      VARCHAR (250) NULL,
    [lu_date]       DATETIME      NULL,
    [lu_user]       VARCHAR (50)  NULL,
    [lu_function]   VARCHAR (50)  NULL
);

