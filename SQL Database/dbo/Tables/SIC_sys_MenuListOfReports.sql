CREATE TABLE [dbo].[SIC_sys_MenuListOfReports] (
    [IDs]         INT           NOT NULL,
    [category]    VARCHAR (20)  NOT NULL,
    [ReportID]    VARCHAR (20)  NOT NULL,
    [ReportName]  VARCHAR (200) NOT NULL,
    [OrderBy]     INT           NULL,
    [Image]       VARCHAR (20)  NULL,
    [Site]        VARCHAR (250) NULL,
    [Path]        VARCHAR (250) NULL,
    [Page]        VARCHAR (250) NULL,
    [Type]        VARCHAR (20)  NULL,
    [Level]       VARCHAR (100) NULL,
    [lu_date]     DATETIME      NULL,
    [lu_user]     VARCHAR (50)  NULL,
    [lu_function] VARCHAR (50)  NULL
);

