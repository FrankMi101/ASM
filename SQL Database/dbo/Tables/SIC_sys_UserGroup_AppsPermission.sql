CREATE TABLE [dbo].[SIC_sys_UserGroup_AppsPermission] (
    [IDs]         INT           IDENTITY (1, 1) NOT NULL,
    [SchoolCode]  VARCHAR (8)   NOT NULL,
    [AppID]       VARCHAR (10)  NOT NULL,
    [GroupID]     VARCHAR (100) NOT NULL,
    [ModelID]     VARCHAR (20)  NOT NULL,
    [Permission]  VARCHAR (50)  NULL,
    [AccessScope] VARCHAR (20)  NULL,
    [Comments]    VARCHAR (800) NULL,
    [IDs_Group]   INT           NULL,
    [lu_date]     SMALLDATETIME NULL,
    [lu_user]     VARCHAR (50)  NULL,
    [lu_function] VARCHAR (100) NULL,
    CONSTRAINT [PK_SIC_sys_UserGroup_AppsPermission] PRIMARY KEY CLUSTERED ([SchoolCode] ASC, [GroupID] ASC, [AppID] ASC, [ModelID] ASC)
);

