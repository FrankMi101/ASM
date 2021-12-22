CREATE TABLE [dbo].[SIC_sys_UserRole_Apps] (
    [IDs]         INT           IDENTITY (1, 1) NOT NULL,
    [RoleType]    VARCHAR (20)  NOT NULL,
    [RoleID]      VARCHAR (20)  NOT NULL,
    [RoleName]    VARCHAR (200) NULL,
    [AppID]       VARCHAR (20)  NULL,
    [RoleSIC]     VARCHAR (20)  NULL,
    [RoleIEP]     VARCHAR (20)  NULL,
    [RoleSSF]     VARCHAR (20)  NULL,
    [RoleTPA]     VARCHAR (20)  NULL,
    [RolePPA]     VARCHAR (20)  NULL,
    [RoleLTO]     VARCHAR (20)  NULL,
    [lu_date]     DATETIME      NULL,
    [lu_user]     VARCHAR (50)  NULL,
    [lu_function] VARCHAR (50)  NULL,
    CONSTRAINT [PK_SIC_sys_UserRole_Apps] PRIMARY KEY CLUSTERED ([RoleID] ASC),
    CONSTRAINT [FK_SIC_sys_UserRole_Apps_SIC_sys_UserRole] FOREIGN KEY ([RoleType], [RoleID]) REFERENCES [dbo].[SIC_sys_UserRole] ([RoleType], [RoleID])
);

