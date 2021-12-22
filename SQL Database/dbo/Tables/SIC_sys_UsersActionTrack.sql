CREATE TABLE [dbo].[SIC_sys_UsersActionTrack] (
    [UserID]             VARCHAR (30)  NOT NULL,
    [Working_EmployeeID] VARCHAR (10)  NULL,
    [Working_Year]       VARCHAR (8)   NULL,
    [Working_Unit]       VARCHAR (8)   NULL,
    [Working_Date]       SMALLDATETIME NULL,
    [Working_SessionID]  VARCHAR (20)  NULL,
    [Unit_Area]          VARCHAR (20)  NULL,
    [Content_Page]       VARCHAR (50)  NULL,
    [Server_Name]        VARCHAR (100) NULL,
    [DBServer_Name]      VARCHAR (100) NULL,
    [ScreenSize]         VARCHAR (50)  NULL,
    [UserRole]           VARCHAR (50)  NULL,
    [Login_Time]         SMALLDATETIME NULL,
    [Logout_Time]        SMALLDATETIME NULL,
    [Browser_Type]       VARCHAR (50)  NULL,
    [Browser_Version]    VARCHAR (50)  NULL,
    [LogOn]              VARCHAR (50)  NULL,
    [lu_date]            DATETIME      NULL,
    [lu_user]            VARCHAR (50)  NULL,
    [lu_function]        VARCHAR (50)  NULL,
    CONSTRAINT [PK_SIC_sys_UsersActionTrack] PRIMARY KEY CLUSTERED ([UserID] ASC)
);

