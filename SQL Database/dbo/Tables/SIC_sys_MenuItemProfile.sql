CREATE TABLE [dbo].[SIC_sys_MenuItemProfile] (
    [IDs]         INT           IDENTITY (1, 1) NOT NULL,
    [AppID]       VARCHAR (20)  NOT NULL,
    [ItemID]      VARCHAR (20)  NOT NULL,
    [Display]     VARCHAR (200) NULL,
    [Role]        VARCHAR (50)  NULL,
    [Url]         VARCHAR (200) NULL,
    [CssClass]    VARCHAR (50)  NULL,
    [Target]      VARCHAR (50)  NULL,
    [Active]      VARCHAR (1)   NULL,
    [Show]        VARCHAR (1)   NULL,
    [Enable]      VARCHAR (1)   NULL,
    [lu_date]     DATETIME      NULL,
    [lu_user]     VARCHAR (50)  NULL,
    [lu_function] VARCHAR (50)  NULL
);

