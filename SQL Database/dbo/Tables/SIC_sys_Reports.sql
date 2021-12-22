CREATE TABLE [dbo].[SIC_sys_Reports] (
    [IDs]         INT           IDENTITY (1, 1) NOT NULL,
    [Category]    VARCHAR (20)  NOT NULL,
    [SeqNo]       INT           NULL,
    [ReportID]    VARCHAR (20)  NOT NULL,
    [ReportName]  VARCHAR (200) NOT NULL,
    [ReportTitle] VARCHAR (300) NULL,
    [ReportType]  VARCHAR (20)  NULL,
    [Panel]       VARCHAR (20)  NULL,
    [Owners]      VARCHAR (250) NULL,
    [Developer]   VARCHAR (150) NULL,
    [StartDate]   SMALLDATETIME NULL,
    [EndDate]     SMALLDATETIME NULL,
    [ActiveFlag]  VARCHAR (10)  NULL,
    [Comments]    VARCHAR (800) NULL,
    [lu_date]     DATETIME      NULL,
    [lu_user]     VARCHAR (50)  NULL,
    [lu_function] VARCHAR (50)  NULL,
    CONSTRAINT [PK_SIC_sys_Reports] PRIMARY KEY CLUSTERED ([Category] ASC, [ReportID] ASC, [ReportName] ASC)
);

