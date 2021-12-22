CREATE TABLE [dbo].[SIC_sys_UserRole_AppsPermission] (
    [IDs]         INT           IDENTITY (1, 1) NOT NULL,
    [RoleType]    VARCHAR (10)  NOT NULL,
    [RoleID]      VARCHAR (20)  NOT NULL,
    [AppID]       VARCHAR (20)  NOT NULL,
    [ModelID]     VARCHAR (20)  NOT NULL,
    [Permission]  VARCHAR (50)  NOT NULL,
    [AccessScope] VARCHAR (50)  NULL,
    [Comments]    VARCHAR (800) NULL,
    [IDs_Role]    INT           NULL,
    [lu_date]     DATETIME      NULL,
    [lu_user]     VARCHAR (50)  NULL,
    [lu_function] VARCHAR (50)  NULL,
    CONSTRAINT [PK_SIC_sys_UserRole_AppsPermission_1] PRIMARY KEY CLUSTERED ([RoleID] ASC, [AppID] ASC, [ModelID] ASC, [Permission] ASC)
);

