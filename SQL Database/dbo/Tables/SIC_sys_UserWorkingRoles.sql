CREATE TABLE [dbo].[SIC_sys_UserWorkingRoles] (
    [IDs]          INT           IDENTITY (1, 1) NOT NULL,
    [AppID]        VARCHAR (10)  NOT NULL,
    [AppRole]      VARCHAR (50)  NOT NULL,
    [UserID]       VARCHAR (30)  NOT NULL,
    [UserName]     VARCHAR (50)  NULL,
    [ScopeBy]      VARCHAR (50)  NULL,
    [ScopeByValue] VARCHAR (50)  NULL,
    [StartDate]    SMALLDATETIME NULL,
    [EndDate]      SMALLDATETIME NULL,
    [ActiveFlag]   VARCHAR (10)  NULL,
    [Comments]     VARCHAR (250) NULL,
    [lu_date]      SMALLDATETIME NULL,
    [lu_User]      VARCHAR (50)  NULL,
    [lu_Function]  VARCHAR (50)  NULL,
    CONSTRAINT [PK_SIC_sys_UserWorkingRoles] PRIMARY KEY CLUSTERED ([AppID] ASC, [AppRole] ASC, [UserID] ASC)
);

