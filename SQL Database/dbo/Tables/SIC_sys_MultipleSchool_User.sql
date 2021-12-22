CREATE TABLE [dbo].[SIC_sys_MultipleSchool_User] (
    [IDs]         INT           IDENTITY (1, 1) NOT NULL,
    [SchoolYear]  VARCHAR (8)   NOT NULL,
    [GroupType]   VARCHAR (50)  NOT NULL,
    [GroupID]     VARCHAR (50)  NOT NULL,
    [UserID]      VARCHAR (30)  NOT NULL,
    [UserName]    VARCHAR (50)  NULL,
    [AppID]       VARCHAR (20)  NULL,
    [AppRole]     VARCHAR (50)  NULL,
    [StartDate]   SMALLDATETIME NULL,
    [EndDate]     SMALLDATETIME NULL,
    [ActiveFlag]  VARCHAR (10)  NULL,
    [lu_Date]     SMALLDATETIME NULL,
    [lu_User]     VARCHAR (50)  NULL,
    [lu_Function] VARCHAR (50)  NULL,
    CONSTRAINT [PK_SIC_sys_MultipleSchool_User] PRIMARY KEY CLUSTERED ([SchoolYear] ASC, [GroupType] ASC, [GroupID] ASC, [UserID] ASC)
);

