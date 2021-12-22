CREATE TABLE [dbo].[SIC_sys_UserRequestLog] (
    [IDs]           INT           IDENTITY (1, 1) NOT NULL,
    [SchoolYear]    VARCHAR (8)   NOT NULL,
    [SchoolCode]    VARCHAR (8)   NOT NULL,
    [AppID]         VARCHAR (10)  NOT NULL,
    [ModelID]       VARCHAR (50)  NOT NULL,
    [Permission]    VARCHAR (20)  NOT NULL,
    [StaffID]       VARCHAR (30)  NOT NULL,
    [StartDate]     SMALLDATETIME NULL,
    [EndDate]       SMALLDATETIME NULL,
    [RequestType]   VARCHAR (30)  NULL,
    [RequestValue]  VARCHAR (50)  NULL,
    [RequestScope]  VARCHAR (50)  NULL,
    [RequestVerify] VARCHAR (50)  NULL,
    [Actions]       VARCHAR (200) NULL,
    [Comments]      VARCHAR (500) NULL,
    [lu_date]       SMALLDATETIME NULL,
    [lu_user]       VARCHAR (50)  NULL,
    [lu_function]   VARCHAR (100) NULL
);

