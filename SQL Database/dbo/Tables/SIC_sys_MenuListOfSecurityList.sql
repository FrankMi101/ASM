CREATE TABLE [dbo].[SIC_sys_MenuListOfSecurityList] (
    [IDs]         INT           IDENTITY (1, 1) NOT NULL,
    [Category]    VARCHAR (50)  NOT NULL,
    [MenuID]      VARCHAR (20)  NOT NULL,
    [Name]        VARCHAR (200) NOT NULL,
    [PageAction]  VARCHAR (50)  NULL,
    [OrderBy]     INT           NULL,
    [Ptop]        INT           NULL,
    [Pleft]       INT           NULL,
    [Pheight]     INT           NULL,
    [Pwidth]      INT           NULL,
    [Image]       VARCHAR (20)  NULL,
    [Site]        VARCHAR (250) NULL,
    [Path]        VARCHAR (250) NULL,
    [Page]        VARCHAR (250) NULL,
    [Type]        VARCHAR (100) NULL,
    [FileName]    VARCHAR (250) NULL,
    [Level]       VARCHAR (100) NULL,
    [lu_date]     DATETIME      NULL,
    [lu_user]     VARCHAR (50)  NULL,
    [lu_function] VARCHAR (50)  NULL,
    CONSTRAINT [PK_SIC_sys_MenuListOfSecurityList] PRIMARY KEY CLUSTERED ([Category] ASC, [MenuID] ASC)
);

