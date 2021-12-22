CREATE TABLE [dbo].[SIC_sys_UserRole] (
    [IDs]          INT           IDENTITY (1, 1) NOT NULL,
    [RoleType]     VARCHAR (20)  NOT NULL,
    [RoleID]       VARCHAR (20)  NOT NULL,
    [RoleName]     VARCHAR (200) NULL,
    [AppID]        VARCHAR (20)  NULL,
    [Permission]   VARCHAR (50)  NULL,
    [RolePriority] INT           NULL,
    [AccessScope]  VARCHAR (50)  NULL,
    [Comments]     VARCHAR (800) NULL,
    [lu_date]      DATETIME      NULL,
    [lu_user]      VARCHAR (50)  NULL,
    [lu_function]  VARCHAR (50)  NULL,
    CONSTRAINT [PK_SIC_sys_UserRole] PRIMARY KEY CLUSTERED ([RoleType] ASC, [RoleID] ASC)
);

